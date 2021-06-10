
.PHONY: clean build test

test:
	corral run -- ponyc -o bin test && ./bin/test

clean:
	rm bin/*
