module Cheat where

cheat :: Int -> Int -> Int -> Int -> Int
cheat rw rh pw ph = (+) (rw * div (rh-ph) 2) (div (rw-pw) 2)
