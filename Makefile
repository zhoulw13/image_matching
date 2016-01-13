Main: Main.hs
	ghc -o Main Main.hs
Partial: Partial.hs
	ghc -o Partial Partial.hs
clean:
	rm -rf *.o ~* *.hi Main Partial
