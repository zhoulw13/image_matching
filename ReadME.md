# **Image Match**
A haskell project for image Matching
***
## **Dependencies**
+ [Codec.BMP](http://hackage.haskell.org/package/bmp-1.2.5.2)
  * `cabal install bmp.cabal`

***
## **Compile**
`ghc --make -rtsopts Main.hs`
***
## **Run**
`./Main [input image 1] [input image 2] mode +RTS -K100000000 -RTS`
* input image 1: original image
* input image 2: partial image of original image with noise
+ mode: type of noise
  * 0: no noise
  * 1: linear smooth filter (not finished yet)
  * 2: color enhancement (not finished yet)
  * 3: salt and pepper noise (not finished yet)
  * 4: black pollution

## **Output**
`(width, height)`
* position of partial image in the original image
