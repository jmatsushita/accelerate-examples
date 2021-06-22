
module Solver.BarnesHut
  where

-- import Common.Body (pointMassOfBody, massOfPointMass)
-- import Common.Tree
import Common.Type
import Common.Body
import Data.Array.Accelerate                    (Vector, Acc, Exp, constant, Z(..))
import qualified Data.Array.Accelerate                    as A


-- | Calculate accelerations on the particles using the Barnes-Hut algorithm
-- | http://arborjs.org/docs/barnes-hut

calcAccels :: Int -> Exp R -> Acc (Vector PointMass) -> Acc (Vector Accel)
calcAccels = undefined

-- type Width = R -- one dimension of the bounding octant
-- data Tree
--   = Branch -- internal node = an octant
--       Width PointMass
--       Tree Tree Tree Tree Tree Tree Tree Tree
--   | Leaf   -- external node = subdivision containing 1 body
--       Width PointMass 
--   | Empty  --                 subdivision containing 0 bodies

-- assign :: Acc (Vector PointMass) -> Acc ()
-- assign = undefined


-- -- | Calculate accelerations on the particles using the Barnes-Hut algorithm
-- --
-- calcAccels :: Exp R -> Exp R -> Acc (Vector PointMass) -> Acc (Vector Accel)
-- calcAccels size epsilon bodies
--   = let tree = A.sfoldl buildTree
--                         (Leaf (V3 0 0 0,0))
--                         (constant Z)
--                         (A.map tweak bodies)
--           where
--             tweak :: Exp (Vector PointMass) -> Exp (Vector (Width, PointMass))
--             tweak = undefined

--         -- can we buildTree lazily?
--         buildTree :: Tree -> (Width, PointMass) -> Tree
--         buildTree = \acc pm -> case acc of
--           Empty                       -> Leaf pm
--           Branch w pm _ _ _ _ _ _ _ _ -> undefined          -- Internal Node
--           Leaf w pm'                  ->           -- External Node
--              assign [pm, pm'] newBranch (w/8.0)

--         -- totalMass = A.fold (+) (map (massOfPointMass . pointMassOfBody) bodies) 
--         newBranch w = Branch w (V3 0 0 0, 0) Empty Empty Empty Empty Empty Empty Empty Empty

--         calc :: Exp PointMass -> Exp Accel
--         calc body  = A.sfoldl (\acc next -> acc + accel epsilon body next)
--                               0
--                               (constant Z)
--                               bodies

--     in
--     A.map calc treeBodies