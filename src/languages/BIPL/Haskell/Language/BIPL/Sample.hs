-- BEGIN ...
module Language.BIPL.Sample where

import Language.BIPL.Syntax
-- END ...
sample :: Stmt
sample = Block [

  -- Sample operands for Euclidian division
  Assign "x" (IntConst 14),
  Assign "y" (IntConst 4),

  -- Compute quotient q=3 and remainder r=2
  Assign "q" (IntConst 0),
  Assign "r" (Var "x"),
  While
    (Binary Geq (Var "r") (Var "y"))
    (Block [
      Assign "r" (Binary Sub (Var "r") (Var "y")),
      Assign "q" (Binary Add (Var "q") (IntConst 1))])]
