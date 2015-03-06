-- BEGIN ...
module Language.BFPL.Sample where

import Language.BFPL.Syntax
-- END ...
sample :: Program
sample = ([(
  "factorial",
  (([IntType], IntType),
   (["x"],
     If (Binary Eq (Name "x") (IntConst 0))
        (IntConst 1)
        (Binary Mul
            (Name "x")
            (Apply "factorial" [Binary Sub (Name "x") (IntConst 1)])))))],
  (Apply "factorial" [IntConst 5]))
