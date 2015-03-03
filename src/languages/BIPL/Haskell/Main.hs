import Language.BIPL.Syntax
import Language.BIPL.Sample
-- import Language.BIPL.TypeChecker
import Language.BIPL.Interpreter
import Data.Map (empty)

main = do
  -- print $ okP sample
  print $ exec sample empty
