-- BEGIN ...
module Language.BFPL.TypeChecker where

import Language.BFPL.Syntax
-- END ...
-- Types for types
type Context = [(String, SimpleType)]

-- Well-typedness of programs
okP :: Program -> Bool
okP (fs, e) = okFs && okMain
  where
    okFs = and (map (okF fs) fs)
    okMain = maybe False (const True) (okE fs [] e)

-- Well-typedness of a function
okF :: [Function] -> Function -> Bool
okF fs (_, ((ts, res), (ns, body))) = okLength && maybe False (==res) okBody
  where
    okLength = length ns == length ts
    okBody = okE fs ctx body
    ctx = zip ns ts

-- Well-typedness of expressions
okE :: [Function] -> Context -> Expr -> Maybe SimpleType
okE _ _ (IntConst _) = Just IntType
okE _ _ (BoolConst _) = Just BoolType
okE fs ctx (Name x) = lookup x ctx
okE fs ctx (If e0 e1 e2)
  = do
       t0 <- okE fs ctx e0
       t1 <- okE fs ctx e1
       t2 <- okE fs ctx e2
       if t0 == BoolType && t1 == t2 then Just t1 else Nothing
okE fs ctx (Binary o e1 e2)
  = do
       t1 <- okE fs ctx e1
       t2 <- okE fs ctx e2
       case (o, t1, t2) of
         (Add, IntType, IntType) -> Just IntType
         (Sub, IntType, IntType) -> Just IntType
         (Mul, IntType, IntType) -> Just IntType
         (Eq, IntType, IntType) -> Just BoolType
         (_, _, _) -> Nothing
okE fs ctx (Apply fn es)
  = do
       ((ts, r), _) <- lookup fn fs
       ts' <- mapM (okE fs ctx) es
       if ts == ts' then Just r else Nothing
