module Main where
import System.IO
import System.Environment
import Data.Char
import Codec.BMP
import qualified Data.ByteString as B
import Partial

match :: String -> String -> Int -> IO()
match img1 img2 mode = do
  Right raw_bmp  <- readBMP img1 --"benchmark/img1/img1.bmp"
  Right par_bmp  <- readBMP img2 --"benchmark/img1/img1_partial.bmp"
  let raw_rgba = unpackBMPToRGBA32 raw_bmp
      par_rgba = unpackBMPToRGBA32 par_bmp
      (raw_width, raw_height) = bmpDimensions raw_bmp
      (par_width, par_height) = bmpDimensions par_bmp
      par_img = B.unpack par_rgba
      raw_img = B.unpack raw_rgba in do
      -- 4 dims array
        let index =  case mode of
              0 -> partial raw_img par_img 0
              _ -> 1
            height = raw_height - par_height - (div index raw_width)
            width = mod index raw_width in do
              print (width, height)
