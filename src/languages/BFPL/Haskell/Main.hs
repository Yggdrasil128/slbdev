import Language.BFPL.Sample
import Language.BFPL.TypeChecker
import Language.BFPL.Interpreter

main = do
  print $ okP sample
  print $ eval sample
