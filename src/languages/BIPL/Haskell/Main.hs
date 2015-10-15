import Language.BIPL.Syntax
import Language.BIPL.Sample
-- import Language.BIPL.TypeChecker
import Language.BIPL.Interpreter
import Language.BIPL.Fixpoint
import Data.Map (empty)

main = do
  -- print $ okP sample
  print $ execute sample empty
  print $ execute' sample empty
