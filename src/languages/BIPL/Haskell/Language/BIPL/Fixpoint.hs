-- BEGIN ...
module Language.BIPL.Fixpoint where

import Language.BIPL.Syntax
import Language.BIPL.Domains
import Language.BIPL.Interpreter(evaluate)
import Data.Map ((!), insert)

-- Execution of statements
execute' :: Stmt -> StoreT
execute' Skip sto = sto
execute' (Assign x e) sto = insert x (evaluate e sto) sto
execute' (Block []) sto = sto
execute' (Block (s:ss)) sto = execute' (Block ss) (execute' s sto)
execute' (If e s1 s2) sto = cond (evaluate e) (execute' s1) (execute' s2) sto
-- END ...
-- The meaning of a loop in terms of a fixed point
execute' (While e s) sto = fix f sto
  where
    f x = cond (evaluate e) (x . execute' s) id

-- Fixpoint computation
fix :: (a -> a) -> a
fix f = f (fix f)