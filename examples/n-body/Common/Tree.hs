--
-- A Barnes-Hut tree
--

module Common.Tree
  where

import Common.Type

type Width = R -- one dimension of the bounding octant
data Tree 
  = Branch 
      Width PointMass
      Tree Tree Tree Tree Tree Tree Tree Tree
  | Leaf 
      Width PointMass
  | Empty