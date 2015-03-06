-- BEGIN ...
module Language.BIPL.Interpreter where

import Language.BIPL.Syntax
import Data.Map (Map, (!), empty, fromList, insert)
-- END ...
-- Results of expression evaluation
type Value = Either Int Bool

-- Stores as maps from variable ids to values
type Store = Map String Value

-- Execution of statements
exec :: Stmt -> Store -> Store
exec Skip sto = sto
exec (Assign x e) sto = insert x (eval e sto) sto
exec (If e s1 s2) sto = either undefined cond (eval e sto)
  where cond b = if b then exec s1 sto else exec s2 sto
exec (While e s) sto = exec (If e (Block [s, While e s]) Skip) sto
exec (Block []) sto = sto
exec (Block (s:ss)) sto = exec (Block ss) (exec s sto)

-- Evaluation of expressions
eval :: Expr -> Store -> Value
eval (IntConst i) _ = Left i
eval (Var n) sto = sto!n
eval (Binary o e1 e2) sto
  = case (o, eval e1 sto, eval e2 sto) of
-- BEGIN ...
      -- ...
      (Add, Left x, Left y) -> Left (x+y)
      (Sub, Left x, Left y) -> Left (x-y)
      (Mul, Left x, Left y) -> Left (x*y)
      (Geq, Left x, Left y) -> Right (x>=y)
      _ -> undefined
-- END ...
