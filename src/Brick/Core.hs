{-# LANGUAGE TemplateHaskell #-}
module Brick.Core
  ( Location(Location)
  , loc
  , CursorLocation(..)
  , HandleEvent(..)
  , Name(..)
  )
where

import Control.Lens
import Data.String
import Data.Monoid (Monoid(..))
import Graphics.Vty (Event)

data Location = Location { _loc :: (Int, Int)
                         }
                deriving Show

makeLenses ''Location

newtype Name = Name String
             deriving (Eq, Show, Ord)

instance IsString Name where
    fromString = Name

origin :: Location
origin = Location (0, 0)

instance Monoid Location where
    mempty = origin
    mappend (Location (w1, h1)) (Location (w2, h2)) = Location (w1+w2, h1+h2)

data CursorLocation =
    CursorLocation { cursorLocation :: !Location
                   , cursorLocationName :: !(Maybe Name)
                   }
                   deriving Show

class HandleEvent a where
    handleEvent :: Event -> a -> a
