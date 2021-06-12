
.PHONY: clean build test

test:
	corral run -- ponyc -o bin test && ./bin/test --sequential

clean:
	rm bin/*

build:
	corral run -- ponyc -o bin mazegen
