-- BEGIN ...
module Language.BIPL.Interpreter where

import Language.BIPL.Syntax
import Language.BIPL.Domains
import Data.Map ((!), insert)
-- END ...
-- Execution of statements
execute :: Stmt -> StoreT
execute Skip sto = sto
execute (Assign x e) sto = insert x (evaluate e sto) sto
execute (Block []) sto = sto
execute (Block (s:ss)) sto = execute (Block ss) (execute s sto)
execute (If e s1 s2) sto = cond (evaluate e) (execute s1) (execute s2) sto
execute (While e s) sto = execute (If e (Block [s, While e s]) Skip) sto

-- Evaluation of expressions
evaluate :: Expr -> Store -> Value
evaluate (IntConst i) _ = Left i
evaluate (Var n) sto = sto!n
evaluate (Binary o e1 e2) sto = binop o (evaluate e1 sto) (evaluate e2 sto)
