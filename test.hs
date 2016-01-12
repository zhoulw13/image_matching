import Codec.BMP
import System.IO
import qualified Data.ByteString as B

main :: IO()
main = do
  Right raw_bmp  <- readBMP "benchmark/img1/img1.bmp"
  Right par_bmp  <- readBMP "benchmark/img1/img1_partial.bmp"
  let raw_rgba = unpackBMPToRGBA32 raw_bmp
      par_rgba = unpackBMPToRGBA32 par_bmp
      (raw_width, raw_height) = bmpDimensions raw_bmp
      (par_width, par_height) = bmpDimensions par_bmp
      par_img = B.unpack par_rgba
      raw_img = B.unpack raw_rgba in do
      -- 4 dims array
        print $ length raw_img
        print raw_width
        print raw_height
        print $ length par_img
        print par_width
        print par_height
