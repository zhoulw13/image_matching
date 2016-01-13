# **Image Match**
A haskell project for image Matching
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
  * 1: linear smooth fuzzy
  * 2: color enhancement
  * 3: impulse noise
  * 4: black pollution
