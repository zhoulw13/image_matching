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
        let index =  case mode of
              --0 -> partial raw_img par_img raw_width par_width 0
              1 -> guassianBlurMode raw_img par_img 3 raw_width par_width par_height
              --4 -> taint raw_img par_img raw_width par_width 0
              --5 -> colorHistogram par_img [] 3 par_width
              --_ -> medianFilter par_img par_width mode
            {-first = head index in do
              print $ length index
              print $ length first
              print $ sum $ last index -- 10 (drop 881 index)-}
            --filter_img = B.pack index
            --filter_bmp = packRGBA32ToBMP par_width par_height filter_img in do
            height = raw_height - par_height - (div index raw_width)
            width = mod index raw_width in do
              print index
              print (width, height)
              --writeBMP "test.bmp" filter_bmp
