use crate::semantic::*;
use crate::token::TokenKind;
use std::collections::HashMap;

#[derive(Debug, Clone, PartialEq)]
pub enum Value {
    Int(i64),
    Float(f64),
    Bool(bool),
    String(String),
    Void,
}

impl Value {
    fn is_truthy(&self) -> bool {
        match self {
            Value::Bool(b) => *b,
            Value::Int(i) => *i != 0,
            _ => false,
        }
    }
}

pub struct Interpreter {
    variables: Vec<HashMap<String, Value>>, // Stack of scopes
}

impl Interpreter {
    pub fn new() -> Self {
        Self { variables: vec![HashMap::new()] }
    }

    fn enter_scope(&mut self) {
        self.variables.push(HashMap::new());
    }

    fn exit_scope(&mut self) {
        self.variables.pop();
    }

    fn set_var(&mut self, name: &str, val: Value) -> Result<(), String> {
        for scope in self.variables.iter_mut().rev() {
            if scope.contains_key(name) {
                scope.insert(name.to_string(), val);
                return Ok(());
            }
        }
        Err(format!("Variable '{}' not defined", name))
    }

    fn define_var(&mut self, name: &str, val: Value) {
        if let Some(scope) = self.variables.last_mut() {
            scope.insert(name.to_string(), val);
        }
    }

    fn get_var(&self, name: &str) -> Option<Value> {
        for scope in self.variables.iter().rev() {
            if let Some(v) = scope.get(name) {
                return Some(v.clone());
            }
        }
        None
    }

    pub fn eval_block(&mut self, block: &TBlock) -> Result<Option<Value>, String> {
        self.enter_scope();
        let mut result = None;
        for stmt in &block.statements {
            if let Some(ret) = self.eval_statement(stmt)? {
                result = Some(ret);
                break;
            }
        }
        self.exit_scope();
        Ok(result)
    }

    fn eval_statement(&mut self, stmt: &TStatement) -> Result<Option<Value>, String> {
        match &stmt.kind {
            TStatementKind::Expr(expr) => { self.eval_expression(expr)?; Ok(None) }
            TStatementKind::Let { name, value, .. } => {
                let val = if let Some(e) = value { self.eval_expression(e)? } else { Value::Void };
                self.define_var(name, val);
                Ok(None)
            },
            TStatementKind::Assign { lvalue, rvalue } => {
                if let TExpressionKind::Identifier(name) = &lvalue.kind {
                    let val = self.eval_expression(rvalue)?;
                    self.set_var(name, val)?;
                    Ok(None)
                } else {
                    Err("Comptime assign only supports simple identifiers".to_string())
                }
            },
            TStatementKind::Return(opt_expr) => {
                let val = if let Some(e) = opt_expr { self.eval_expression(e)? } else { Value::Void };
                Ok(Some(val))
            }
            TStatementKind::If { condition, then_block, else_block } => {
                let cond_val = self.eval_expression(condition)?;
                if cond_val.is_truthy() {
                    self.eval_block(then_block)
                } else if let Some(else_b) = else_block {
                    self.eval_block(else_b)
                } else {
                    Ok(None)
                }
            }
            TStatementKind::While { condition, body } => {
                while self.eval_expression(condition)?.is_truthy() {
                    if let Some(ret) = self.eval_block(body)? {
                        return Ok(Some(ret));
                    }
                }
                Ok(None)
            }
            TStatementKind::Block(b) => self.eval_block(b),
            _ => Err("Statement not supported in comptime".to_string())
        }
    }

    fn eval_expression(&mut self, expr: &TExpression) -> Result<Value, String> {
        match &expr.kind {
            TExpressionKind::Int(i) => Ok(Value::Int(*i)),
            TExpressionKind::Float(f) => Ok(Value::Float(*f)),
            TExpressionKind::Boolean(b) => Ok(Value::Bool(*b)),
            TExpressionKind::String(s) => Ok(Value::String(s.clone())),
            TExpressionKind::Identifier(name) => {
                self.get_var(name).ok_or(format!("Unknown comptime variable: {}", name))
            },
            TExpressionKind::Binary { left, operator, right } => {
                let l = self.eval_expression(left)?;
                let r = self.eval_expression(right)?;
                self.eval_binary(l, operator, r)
            },
            _ => Err(format!("Expression {:?} not supported in comptime", expr.kind))
        }
    }

    fn eval_binary(&self, left: Value, op: &TokenKind, right: Value) -> Result<Value, String> {
        match (left, right) {
            (Value::Int(l), Value::Int(r)) => match op {
                TokenKind::Plus => Ok(Value::Int(l + r)),
                TokenKind::Minus => Ok(Value::Int(l - r)),
                TokenKind::Star => Ok(Value::Int(l * r)),
                TokenKind::Slash => Ok(Value::Int(l / r)),
                TokenKind::EqualEqual => Ok(Value::Bool(l == r)),
                TokenKind::BangEqual => Ok(Value::Bool(l != r)),
                TokenKind::Less => Ok(Value::Bool(l < r)),
                TokenKind::Greater => Ok(Value::Bool(l > r)),
                TokenKind::LessEqual => Ok(Value::Bool(l <= r)),
                TokenKind::GreaterEqual => Ok(Value::Bool(l >= r)),
                _ => Err(format!("Op {:?} not supported for Int", op))
            },
            (Value::String(l), Value::String(r)) => match op {
                TokenKind::Plus => Ok(Value::String(format!("{}{}", l, r))),
                TokenKind::EqualEqual => Ok(Value::Bool(l == r)),
                _ => Err(format!("Op {:?} not supported for String", op))
            },
            (Value::Bool(l), Value::Bool(r)) => match op {
                TokenKind::EqualEqual => Ok(Value::Bool(l == r)),
                TokenKind::BangEqual => Ok(Value::Bool(l != r)),
                _ => Err(format!("Op {:?} not supported for Bool", op))
            },
            _ => Err("Type mismatch or unsupported types in comptime binary op".to_string())
        }
    }
}
