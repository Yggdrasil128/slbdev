-- BEGIN ...
module Language.BIPL.Syntax where
-- END ...
-- Statements
data Stmt
  = Skip
  | Assign String Expr
  | If Expr Stmt Stmt
  | While Expr Stmt
  | Block [Stmt]

-- Expressions
data Expr
  = IntConst Int
  | Var String
  | Binary BinOp Expr Expr

-- Binary operators
data BinOp = Add | Sub | Mul | Geq