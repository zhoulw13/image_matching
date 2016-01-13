module Main where
import Codec.BMP
import System.IO
import qualified Data.ByteString as B
import Origin

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
        let index = 10 calculate raw_img par_img 0
            height = raw_height - par_height - (div index raw_width)
            width = mod index raw_width in do
              print (width, height)
