module Robot
  ( Bearing(East, North, South, West)
  , bearing
  , coordinates
  , mkRobot
  , move
  ) where

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Show)

data Robot = Robot
  { facing   :: Bearing
  , location :: (Integer, Integer)
  }
  deriving (Eq, Show)

bearing :: Robot -> Bearing
bearing = facing

coordinates :: Robot -> (Integer, Integer)
coordinates = location

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot = Robot

move :: Robot -> String -> Robot
move robot []                   = robot
move robot ('A' : instructions) = move (advance robot) instructions
move robot ('R' : instructions) = move (turnRight robot) instructions
move robot ('L' : instructions) = move (turnLeft robot) instructions
move robot (_   : instructions) = move (doNothing robot) instructions

doNothing :: Robot -> Robot
doNothing (Robot _ (_, _)) = Robot North (0, 0)

advance :: Robot -> Robot
advance (Robot North (x, y)) = Robot North (x, y + 1)
advance (Robot West  (x, y)) = Robot West (x - 1, y)
advance (Robot South (x, y)) = Robot South (x, y - 1)
advance (Robot East  (x, y)) = Robot East (x + 1, y)

turnRight :: Robot -> Robot
turnRight (Robot North (x, y)) = Robot East (x, y)
turnRight (Robot East  (x, y)) = Robot South (x, y)
turnRight (Robot South (x, y)) = Robot West (x, y)
turnRight (Robot West  (x, y)) = Robot North (x, y)

turnLeft :: Robot -> Robot
turnLeft (Robot North (x, y)) = Robot West (x, y)
turnLeft (Robot West  (x, y)) = Robot South (x, y)
turnLeft (Robot South (x, y)) = Robot East (x, y)
turnLeft (Robot East  (x, y)) = Robot North (x, y)
