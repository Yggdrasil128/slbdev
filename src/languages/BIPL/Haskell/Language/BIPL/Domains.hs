-- BEGIN ...
module Language.BIPL.Domains where

import Language.BIPL.Syntax
import Data.Map (Map)
-- END ...
-- Results of expression evaluation
type Value = Either Int Bool

-- Stores as maps from variable ids to values
type Store = Map String Value

-- Store transformers
type StoreT = Store -> Store

-- Interpretation of binary operators
binop :: BinOp -> Value -> Value -> Value
binop Add (Left x) (Left y) = Left (x+y)
binop Sub (Left x) (Left y) = Left (x-y)
binop Mul (Left x) (Left y) = Left (x*y)
binop Geq (Left x) (Left y) = Right (x>=y)
binop _ _ _ = undefined

-- Conditional computation
cond :: (Store -> Value) -> StoreT -> StoreT -> StoreT
cond vt st1 st2 sto = if bv then st1 sto else st2 sto
  where
    bv = either undefined id (vt sto)