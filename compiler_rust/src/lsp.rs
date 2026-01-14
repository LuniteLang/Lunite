use lsp_server::{Connection, Message, Notification, Request, Response};
use lsp_types::{
    Diagnostic, DiagnosticSeverity, DidChangeTextDocumentParams, DidOpenTextDocumentParams,
    Hover, HoverContents, HoverParams, InitializeParams, Location, MarkupContent, MarkupKind,
    Position, PublishDiagnosticsParams, Range, ServerCapabilities, TextDocumentSyncCapability,
    TextDocumentSyncKind, Url, GotoDefinitionParams, OneOf, HoverProviderCapability,
};
use std::error::Error;
use std::path::PathBuf;
use crate::parser::Parser;
use crate::lexer::Lexer;
use crate::semantic::{SemanticAnalyzer, TItem, TStatement, TStatementKind, TExpression, TExpressionKind};
use crate::ast::Type;
use crate::span::Span;

pub fn start_lsp() -> Result<(), Box<dyn Error + Send + Sync>> {
    eprintln!("[LSP] Starting Lunite Language Server...");

    let (connection, io_threads) = Connection::stdio();

    let server_capabilities = serde_json::to_value(&ServerCapabilities {
        text_document_sync: Some(TextDocumentSyncCapability::Kind(TextDocumentSyncKind::FULL)),
        hover_provider: Some(HoverProviderCapability::Simple(true)),
        definition_provider: Some(OneOf::Left(true)),
        ..Default::default()
    })
    .unwrap();

    let initialization_params = connection.initialize(server_capabilities)?;
    let _init_params: InitializeParams = serde_json::from_value(initialization_params).unwrap();

    let mut state = LspState::new();

    for msg in &connection.receiver {
        match msg {
            Message::Request(req) => {
                if connection.handle_shutdown(&req)? {
                    return Ok(());
                }
                match req.method.as_str() {
                    "textDocument/hover" => {
                        let id = req.id.clone();
                        let params: HoverParams = serde_json::from_value(req.params).unwrap();
                        let resp = state.handle_hover(params);
                        let result = serde_json::to_value(&resp).unwrap();
                        let resp_msg = Response { id, result: Some(result), error: None };
                        connection.sender.send(Message::Response(resp_msg))?;
                    }
                    "textDocument/definition" => {
                        let id = req.id.clone();
                        let params: GotoDefinitionParams = serde_json::from_value(req.params).unwrap();
                        let resp = state.handle_definition(params);
                        let result = serde_json::to_value(&resp).unwrap();
                        let resp_msg = Response { id, result: Some(result), error: None };
                        connection.sender.send(Message::Response(resp_msg))?;
                    }
                    _ => {}
                }
            }
            Message::Notification(not) => {
                if not.method == "textDocument/didOpen" {
                    if let Ok(params) = serde_json::from_value::<DidOpenTextDocumentParams>(not.params) {
                        let text = params.text_document.text;
                        let uri = params.text_document.uri;
                        state.check_document(&connection, uri, &text)?;
                    }
                } else if not.method == "textDocument/didChange" {
                    if let Ok(params) = serde_json::from_value::<DidChangeTextDocumentParams>(not.params) {
                        if let Some(change) = params.content_changes.into_iter().last() {
                            let text = change.text;
                            let uri = params.text_document.uri;
                            state.check_document(&connection, uri, &text)?;
                        }
                    }
                }
            }
            Message::Response(_) => {}
        }
    }
    io_threads.join()?;
    Ok(())
}

struct LspState {
    analyzer: Option<SemanticAnalyzer>,
    current_uri: Option<Url>,
    source_code: String,
    entry_module_name: Option<String>,
}

impl LspState {
    fn new() -> Self {
        Self {
            analyzer: None,
            current_uri: None,
            source_code: String::new(),
            entry_module_name: None,
        }
    }

    fn check_document(&mut self, connection: &Connection, uri: Url, text: &str) -> Result<(), Box<dyn Error + Send + Sync>> {
        self.current_uri = Some(uri.clone());
        self.source_code = text.to_string();
        
        let mut diagnostics = Vec::new();
        
        // 1. Lexer & Parser Check
        let lexer = Lexer::new(text);
        let mut parser = Parser::new(lexer);
        
        match parser.parse_program() {
            Ok(_) => {
                // 2. Semantic Analysis
                let tmp_path = std::env::temp_dir().join("lunite_lsp_tmp.lun");
                if let Err(e) = std::fs::write(&tmp_path, text) {
                    eprintln!("[LSP] Failed to write temp file: {}", e);
                } else {
                    let mut analyzer = SemanticAnalyzer::new(vec![std::env::current_dir().unwrap_or_default()]);
                    match analyzer.analyze_module_recursive(tmp_path) {
                        Ok(mod_name) => {
                            self.entry_module_name = Some(mod_name);
                            self.analyzer = Some(analyzer);
                        }
                        Err(e) => {
                            let line = (e.line as u32).saturating_sub(1);
                            let char_start = (e.column as u32).saturating_sub(1);
                            let diag = Diagnostic {
                                range: Range {
                                    start: Position { line, character: char_start },
                                    end: Position { line, character: char_start + 5 },
                                },
                                severity: Some(DiagnosticSeverity::ERROR),
                                code: None,
                                code_description: None,
                                source: Some("lunite".to_string()),
                                message: e.message,
                                related_information: None,
                                tags: None,
                                data: None,
                            };
                            diagnostics.push(diag);
                            self.analyzer = Some(analyzer); // Keep state even on error
                        }
                    }
                }
            },
            Err(e) => {
                let line = (e.line as u32).saturating_sub(1);
                let char_start = (e.column as u32).saturating_sub(1);
                let diag = Diagnostic {
                    range: Range {
                        start: Position { line, character: char_start },
                        end: Position { line, character: char_start + 5 },
                    },
                    severity: Some(DiagnosticSeverity::ERROR),
                    code: None,
                    code_description: None,
                    source: Some("lunite".to_string()),
                    message: e.message,
                    related_information: None,
                    tags: None,
                    data: None,
                };
                diagnostics.push(diag);
            }
        }

        let params = PublishDiagnosticsParams {
            uri,
            diagnostics,
            version: None,
        };
        
        let not = Notification {
            method: "textDocument/publishDiagnostics".to_string(),
            params: serde_json::to_value(&params)?,
        };
        connection.sender.send(Message::Notification(not))?;
        Ok(())
    }

    fn offset_at_position(&self, line: u32, col: u32) -> usize {
        let mut cur_line = 0;
        let mut cur_col = 0;
        let mut last_offset = 0;
        for (i, c) in self.source_code.char_indices() {
            last_offset = i;
            if cur_line == line && cur_col == col {
                return i;
            }
            if c == '\n' {
                cur_line += 1;
                cur_col = 0;
            } else {
                cur_col += 1;
            }
        }
        if cur_line == line {
             return last_offset + (col as usize - cur_col as usize); // approx
        }
        self.source_code.len()
    }

    fn position_at_offset(&self, offset: usize) -> Position {
        let mut cur_line = 0;
        let mut cur_col = 0;
        for (i, c) in self.source_code.char_indices() {
            if i == offset {
                return Position { line: cur_line, character: cur_col };
            }
            if c == '\n' {
                cur_line += 1;
                cur_col = 0;
            } else {
                cur_col += 1;
            }
        }
        Position { line: cur_line, character: cur_col }
    }

    fn find_at_pos(&self, offset: usize) -> Option<(Span, String)> {
        let analyzer = self.analyzer.as_ref()?;
        let mod_name = self.entry_module_name.as_ref()?;
        let module = analyzer.analyzed_modules.get(mod_name)?;

        let mut best_match: Option<(Span, String)> = None;

        let mut update = |span: Span, msg: String| {
            if offset >= span.start && offset <= span.end {
                let len = span.end - span.start;
                let current_best_len = if let Some((bs, _)) = &best_match {
                     bs.end - bs.start
                } else {
                    usize::MAX
                };
                if len < current_best_len {
                    best_match = Some((span, msg));
                }
            }
        };

        for item in &module.items {
            match item {
                TItem::Function(f) => {
                    update(f.span, format!("Function: {} -> {:?}", f.name, f.return_type));
                    // Traverse Body... (omitted)
                }
                TItem::Struct(s) => {
                    update(s.span, format!("Struct: {}", s.name));
                }
                TItem::Enum(e) => {
                    update(e.span, format!("Enum: {}", e.name));
                }
                _ => {}
            }
        }
        best_match
    }

    fn handle_hover(&self, params: HoverParams) -> Option<Hover> {
        let pos = params.text_document_position_params.position;
        let offset = self.offset_at_position(pos.line, pos.character);

        if let Some((_, info)) = self.find_at_pos(offset) {
            return Some(Hover {
                contents: HoverContents::Markup(MarkupContent {
                    kind: MarkupKind::Markdown,
                    value: format!("`lunite\n{}\n```", info),
                }),
                range: None,
            });
        }
        None
    }

    fn handle_definition(&self, params: GotoDefinitionParams) -> Option<Location> {
        let pos = params.text_document_position_params.position;
        let offset = self.offset_at_position(pos.line, pos.character);

        if let Some((span, _)) = self.find_at_pos(offset) {
             if let Some(uri) = &self.current_uri { 
                 let start = self.position_at_offset(span.start);
                 let end = self.position_at_offset(span.end);
                 return Some(Location {
                     uri: uri.clone(),
                     range: Range { start, end }
                 });
            }
        }
        None
    }
}