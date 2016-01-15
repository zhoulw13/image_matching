module Taint where
import GHC.Word as W


taint :: [W.Word8] -> [W.Word8] -> Int -> Int -> Int -> Int
taint raw par rw pw offset =
  if black $ take 4 par then
    taint raw (drop 4 par) rw pw (offset+1)
  else
    calculate raw par rw pw offset 0

calculate :: [W.Word8] -> [W.Word8] -> Int -> Int -> Int -> Int -> Int
calculate raw par rw pw offset index =
  if (take 4 raw) == (take 4 par) then
    if compareArr ((take (4*(pw - mod offset pw)) raw)++(take (4*pw) $ drop (4*(rw - mod offset pw)) raw)) (take (4*(2*pw - mod offset pw)) par) 0 0 then
      index -((div offset pw)*rw)-(mod offset pw)
    else
      calculate (drop 4 raw) par rw pw offset (index+1)
  else
    calculate (drop 4 raw) par rw pw offset (index+1)

compareArr :: [W.Word8] -> [W.Word8] -> Int -> Int -> Bool
compareArr [] _ acc count =
  if (fromIntegral acc)/(fromIntegral count) > 0.9 then
    True
  else
    False
compareArr raw par acc count =
  if black $ take 4 par then
    compareArr (drop 4 raw) (drop 4 par) acc count
  else if take 4 raw == take 4 par then
    compareArr (drop 4 raw) (drop 4 par) (acc+1) (count+1)
  else
    compareArr (drop 4 raw) (drop 4 par) (acc) (count+1)

black :: [W.Word8] -> Bool
black (r:g:b:a) =
  if r < 30 && g < 30 && b < 30 && abs (r-g) < 10 && abs (r-b) < 10 then
    True
  else
    False
