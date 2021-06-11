# Maze Generation Kata
_Generate and show a maze, using the simple depth-first search algorithm._

Start at a random cell 
Mark the current cell as visited, and get a list of its neighbours 
For each neighbour, starting with a randomly selected neighbour: 
If that neighbour hasn't been visited, remove the wall between this cell and that neighbour, and then recurse with that neighbor as the current cell 
Credit: RosettaCode.org

![Maze](/images/maze.png)

## Running
```
go run . -width=n -height=n > output.png
```
...where `n` are integers

## Building and Running Binary

### With Go installed [https://golang.org/doc/install]:
```
go build -o maze .
./maze -width=n -height=n > output.png
```

## Running Tests
```
go test .
```
