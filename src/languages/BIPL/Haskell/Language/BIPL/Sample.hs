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
  Assign "r" (Name "x"),
  While
    (BinOp Geq (Name "r") (Name "y"))
    (Block [
      Assign "r" (BinOp Sub (Name "r") (Name "y")),
      Assign "q" (BinOp Add (Name "q") (IntConst 1))])]