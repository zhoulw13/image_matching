match: match.hs 
	ghc -o match match.hs
origin: origin.hs
	ghc -o origin origin.hs
clean: 
	rm -rf *.o ~* *.hi match origin
