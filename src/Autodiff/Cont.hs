module Autodiff.Cont where

import Prelude hiding (id, (.))

import CategoricDefinitions

-- TODO OUTDATED; I need to update this!
newtype ContType k r a b = Cont ( (b `k` r) -> (a `k` r)) -- a -> b -> r

cont :: (Category k, AllAllowed k [a, b, r]) => (a `k` b) -> ContType k r a b
cont f = Cont (. f)

instance Category k => Category (ContType k r) where
  type Allowed (ContType k r) a = Allowed k a
  id = Cont id
  Cont g . Cont f = Cont (f . g)

--instance Monoidal k => Monoidal (ContType k r) where
--  (Cont f) `x` (Cont g) = Cont $ join . (f `x` g) . unjoin
--
--instance Cartesian k => Cartesian (ContType k r) where
--  type AllowedCarEx (ContType k r) a b = ()
--  type AllowedCarDup (ContType k r) a = (AllowedSeq k a (a, a) r,
--                                         Allowed k a,
--                                         AllowedCoCarIn k a a,
--                                         Cocartesian k
--                                        )
--
--  exl = Cont $ undefined
--  exr = Cont $ undefined
--  dup = Cont $ undefined
--
--instance Cocartesian k => Cocartesian (ContType k r) where
--  type AllowedCoCarIn (ContType k r) a b = ()
--  type AllowedCoCarJam (ContType k r) a = (AllowedSeq k (a, a) (r, r) r,
--                                           Allowed k r,
--                                           AllowedMon k a a r r,
--                                           Allowed k a,
--                                           AllowedCoCarJam k r,
--                                           Monoidal k)
--  inl = Cont $ undefined
--  inr = Cont $ undefined
--  jam = Cont $ join . dup
