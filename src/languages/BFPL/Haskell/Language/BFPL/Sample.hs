-- BEGIN ...
module Language.BFPL.Sample where

import Language.BFPL.Syntax
-- END ...
sample :: Program
sample = ([(
  "factorial",
  (([IntType], IntType),
   (["x"],
     If (Binary Eq (Arg "x") (IntConst 0))
        (IntConst 1)
        (Binary Mul
            (Arg "x")
            (Apply "factorial" [Binary Sub (Arg "x") (IntConst 1)])))))],
  (Apply "factorial" [IntConst 5]))
