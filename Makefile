Main: Main.hs
	ghc -rtsopts Main.hs
clean:
	rm -rf *.o ~* *.hi Main
