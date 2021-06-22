
module Solver.BarnesHut
  where

-- import Common.Body (pointMassOfBody, massOfPointMass)
-- import Common.Tree
import Common.Type
import Data.Array.Accelerate                    as A


-- | Calculate accelerations on the particles using the Barns-Hut algorithm
--
calcAccels :: Exp R -> Acc (Vector PointMass) -> Acc (Vector Accel)
calcAccels = error "BarnsHut.calcAccels: not implemented yet!"

-- -- type Width = R -- one dimension of the bounding octant
-- -- data Tree 
-- --   = Branch 
-- --       Width PointMass
-- --       Tree Tree Tree Tree Tree Tree Tree Tree
-- --   | Leaf 
-- --       Width PointMass

-- calcAccels  :: Exp R -> Exp R -> Acc (Vector PointMass) -> Acc (Vector Accel)
-- calcAccels size epsilon bodies = undefined

-- -- assign :: Acc (Vector PointMass) -> Acc ()
-- -- assign 


-- -- -- | Calculate accelerations on the particles using the Barns-Hut algorithm
-- -- --
-- -- calcAccels :: Exp R -> Exp R -> Acc (Vector PointMass) -> Acc (Vector Accel)
-- -- calcAccels size epsilon bodies
-- --   = let tree = A.sfoldl buildTree
-- --                         (Leaf ((V3 0 0 0),0))
-- --                         (constant Z)
-- --                         (map (massOfPointMass . pointMassOfBody) bodies)

-- --         buildTree = \acc pm -> case acc of
-- --           Empty                           -> Leaf pm
-- --           Branch w pm _ _ _ _ _ _ _ _ _ _ ->           -- Internal Node
-- --           Leaf w pm'                      ->           -- External Node
-- --              assign [pm, pm'] newBranch (w/8.0)


-- --         -- totalMass = A.fold (+) (map (massOfPointMass . pointMassOfBody) bodies) 
-- --         newBranch w = Branch w ((V3 0 0 0)) Empty Empty Empty Empty Empty Empty Empty Empty 
-- --         calc body  = A.sfoldl (\acc next -> acc + accel epsilon body next)
-- --                               0
-- --                               (constant Z)
-- --                               bodies

-- --     in
-- --     A.map calc tree 