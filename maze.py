import sys
from random import randint

# 1 = top, 2 = left, 4 = bottom, 8 = right so 15 = untouched

# constants to make things easier to read
WALLS = 0
VISITED = 1

# global stack for iterative checks of neighbours
stack = []

def create_maze (x, y):
    # create initial arrays with walls = 15 and visited = false
    m = [ [ [0b1111,0] for w in range(x) ] for h in range(y) ]

    # pick a random cell as our start cell and mark it as visited and add to stack
    (sx, sy) = [randint(0, x-1), randint(0, y-1)]
    m[sx][sy][VISITED] = True
    stack.append([sx, sy])

    # keep going through the stack until all cells visited
    while len(stack) > 0:
        # take a cell off stack and get all it's neighbours
        (sx, sy)= stack.pop()
        neighbours = get_neighbours(sx, sy , x, y)

        for (nx, ny) in neighbours:
            if m[nx][ny][VISITED] == False:
                stack.append([sx, sy])

                #pick a random neighbour
                (nx, ny) = neighbours[randint(0, len(neighbours)-1)]

                # remove wall if not visited
                if m[nx][ny][VISITED] == False:
                    m[nx][ny][VISITED] = True
                    if nx > sx: m[ny][nx][WALLS] = m[ny][nx][WALLS] - 2
                    if nx < sx: m[sy][sx][WALLS] = m[sy][sx][WALLS] - 2
                    if ny > sy: m[ny][nx][WALLS] = m[ny][nx][WALLS] - 1
                    if ny < sy: m[sy][sx][WALLS] = m[sy][sx][WALLS] - 1

                stack.append([nx, ny])
                m[nx][ny][VISITED] = True
    return m

def get_neighbours(x, y, mx, my):
    # return a list of valid neighbours (ie nothing outside the maze)
    n = []
    if x > 0: n.append((x-1, y))
    if y > 0: n.append((x, y-1))
    if x < mx-1: n.append((x+1, y))
    if y < my-1: n.append((x, y+1))
    return n
    
def print_maze (m):
    for row in m:
        for cell in row:
            if cell[WALLS] & 0b1 : print ('+--', end='')
            else: print ('+  ', end='')
        if cell[WALLS] & 0b1000: print ('+', end='') # last column
        print('')

        for cell in row:
            if cell[WALLS] & 0b10 : print ('|  ', end ='')
            else: print ('   ', end ='')
        if cell[WALLS] & 0b1000: print ('|', end='') # last column
        print('')

    #last row
    for cell in row:
        if cell[WALLS] & 0b100 : print ('+--',end ='')
    if cell[WALLS] & 0b100: print ('+', end='') # last column
    print('')

m = create_maze(int(sys.argv[1]),int(sys.argv[2]))
print_maze(m)