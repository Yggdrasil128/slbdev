-- BEGIN ...
module Language.BFPL.Interpreter where

import Language.BFPL.Syntax
import Data.Map (Map, (!), empty, fromList)
-- END ...
-- Results of expression evaluation
type Value = Either Int Bool

-- Environments as maps from argument names to values
type Env = Map String Value

-- Evaluation of a program's main expression
eval :: Program -> Value
eval (fs, e) = eval' empty e
  where
    -- Evaluation of expressions
    eval' :: Env -> Expr -> Value
    eval' _ (IntConst x) = Left x
    eval' _ (BoolConst x) = Right x
    eval' env (Arg x) = env!x
    eval' env (If e0 e1 e2)
      = let (Right b) = eval' env e0
        in if b then eval' env e1 else eval' env e2
    eval' env (Binary o e1 e2)
      = case (o, eval' env e1, eval' env e2) of
          (Add, Left x, Left y) -> Left (x+y)
          (Sub, Left x, Left y) -> Left (x-y)
-- BEGIN ...
          -- ...
          (Mul, Left x, Left y) -> Left (x*y)
          (Eq, Left x, Left y) -> Right (x==y)
          _ -> undefined
-- END ...
    eval' env (Apply fn es) = eval' env' body
      where
        (_, (ns, body)) = maybe undefined id (lookup fn fs)
        vs = fmap (eval' env) es
        env' = fromList (zip ns vs)
