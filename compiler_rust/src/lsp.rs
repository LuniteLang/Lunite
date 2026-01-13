use lsp_server::{Connection, Message, Notification};
use lsp_types::{
    Diagnostic, DiagnosticSeverity, DidChangeTextDocumentParams, DidOpenTextDocumentParams,
    PublishDiagnosticsParams, Range, Position, ServerCapabilities, TextDocumentSyncCapability,
    TextDocumentSyncKind, Url,
};
use std::error::Error;
use crate::parser::Parser;
use crate::lexer::Lexer;

pub fn start_lsp() -> Result<(), Box<dyn Error + Send + Sync>> {
    eprintln!("[LSP] Starting Lunite Language Server...");

    let (connection, io_threads) = Connection::stdio();

    let server_capabilities = serde_json::to_value(&ServerCapabilities {
        text_document_sync: Some(TextDocumentSyncCapability::Kind(TextDocumentSyncKind::FULL)),
        ..Default::default()
    })
    .unwrap();

    let _initialization_params = connection.initialize(server_capabilities)?;
    
    for msg in &connection.receiver {
        match msg {
            Message::Request(req) => {
                if connection.handle_shutdown(&req)? {
                    return Ok(());
                }
            }
            Message::Notification(not) => {
                if not.method == "textDocument/didOpen" {
                    if let Ok(params) = serde_json::from_value::<DidOpenTextDocumentParams>(not.params) {
                        let text = params.text_document.text;
                        let uri = params.text_document.uri;
                        check_document(&connection, uri, &text)?;
                    }
                } else if not.method == "textDocument/didChange" {
                    if let Ok(params) = serde_json::from_value::<DidChangeTextDocumentParams>(not.params) {
                        if let Some(change) = params.content_changes.into_iter().last() {
                            let text = change.text;
                            let uri = params.text_document.uri;
                            check_document(&connection, uri, &text)?;
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

fn check_document(connection: &Connection, uri: Url, text: &str) -> Result<(), Box<dyn Error + Send + Sync>> {
    let mut diagnostics = Vec::new();
    
    // 1. Lexer & Parser Check
    let mut lexer = Lexer::new(text);
    let mut parser = Parser::new(&mut lexer);
    
    match parser.parse_program() {
        Ok(_) => {
            // TODO: Semantic Analysis (requires complex Virtual File System)
        },
        Err(e) => {
            let line = (e.line as u32).saturating_sub(1);
            let char_start = (e.column as u32).saturating_sub(1);
            let diag = Diagnostic {
                range: Range {
                    start: Position { line, character: char_start },
                    end: Position { line, character: char_start + 5 }, // heuristic length
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
