-- BEGIN ...
module Language.BFPL.Syntax where
-- END ...
-- Program = typed functions + main expression
type Program = ([Function], Expr)
type Function = (String, (FunSig, FunDef))
type FunSig = ([SimpleType], SimpleType)
type FunDef = ([String], Expr)

-- Simple types
data SimpleType = IntType | BoolType deriving Eq

-- Expressions
data Expr
  = IntConst Int
  | BoolConst Bool
  | Name String
  | If Expr Expr Expr
  | Binary BinOp Expr Expr
  | Apply String [Expr]

-- Binary operators
data BinOp = Add | Sub | Mul | Eq
