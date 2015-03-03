-- BEGIN ...
module Language.BFPL.Sample where

import Language.BFPL.Syntax
-- END ...
sample :: Program
sample = ([(
  "factorial",
  (([IntType], IntType),
   (["x"],
     If (BinOp Eq (Name "x") (IntConst 0))
        (IntConst 1)
        (BinOp Mul
            (Name "x")
            (Apply "factorial" [BinOp Sub (Name "x") (IntConst 1)])))))],
  (Apply "factorial" [IntConst 5]))
