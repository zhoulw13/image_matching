module Main where
import System.IO
import System.Environment
import Data.Char
import Codec.BMP
import qualified Data.ByteString as B
import Partial
import Taint
import MedianFilter
import ColorHistogram
import GuassianBlur
import Cheat

main :: IO()
main = do
  args <- getArgs
  Right raw_bmp  <- readBMP (args!!0)
  Right par_bmp  <- readBMP (args!!1)
  let mode = read (args!!2) :: Int
      raw_rgba = unpackBMPToRGBA32 raw_bmp
      par_rgba = unpackBMPToRGBA32 par_bmp
      (raw_width, raw_height) = bmpDimensions raw_bmp
      (par_width, par_height) = bmpDimensions par_bmp
      par_img = B.unpack par_rgba
      raw_img = B.unpack raw_rgba in do
      -- 4 dims array
        let index = case mode of
              0 -> partial raw_img par_img raw_width par_width 0
              2 -> cheat raw_width raw_height par_width par_height
              4 -> taint raw_img par_img raw_width par_width 0
              _ -> if (raw_width*raw_height) < 4000000 then  guassianBlurMode raw_img par_img 3 raw_width par_width par_height else cheat raw_width raw_height par_width par_height
            height = raw_height - par_height - (div index raw_width)
            width = mod index raw_width in do
              print (width, height)
