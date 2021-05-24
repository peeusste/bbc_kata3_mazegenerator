# Generate and show a maze, using the simple depth-first search algorithm.

Start at a random cell 
Mark the current cell as visited, and get a list of its neighbours 
For each neighbour, starting with a randomly selected neighbour: 
If that neighbour hasn't been visited, remove the wall between this cell and that neighbour, and then recurse with that neighbor as the current cell 
Credit: RosettaCode.org

Thoughts

Can you do this in an object-oriented style? 
Or a functional programming one?
