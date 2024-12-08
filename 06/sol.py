# contents = open("little.txt").read()
contents = open("inp.txt").read()


lines = contents.split()
lines = list(map(list, lines))

start = None

for i in range(len(lines)):
    for j in range(len(lines[i])):
        if lines[i][j] == "^":
            start = (i, j)
turtle = start

grid = []
for i in range(len(lines)):
    grid.append([0]*len(lines[i]))

def move(dr, p):
    i, j = p
    if dr == "N":
        i -= 1
    if dr == "E":
        j += 1
    if dr == "S":
        i += 1
    if dr == "W":
        j -= 1
    return (i, j)

def in_bounds(i, j):
    return not (i < 0 or i >= len(lines) or j < 0 or j >= len(lines[i]))

def change(d):
    return {"N":"E", "E":"S", "S":"W", "W":"N"}[d]

direction = "N"


def runthrough(d, p):
    visited = set()
    ai, aj = p
    ifnext = d
    while (i, j) != start:
        if (ifnext, (ai, aj)) in visited:
            return True
        visited |= set([(ifnext, (ai, aj))])
        bi, bj = move(ifnext, (ai, aj))
        if not in_bounds(bi, bj):
            return False
        if lines[bi][bj] == "#":
            ifnext = change(ifnext)
        else:
            ai, aj = bi, bj

counter = 0
steps = 0
previous = None

dupes = set()
print("this will take a while (~15s)")

while True:
    i, j = turtle
    grid[i][j] = 1
    i, j = move(direction, (i, j))

    ifnext = change(direction)

    if not in_bounds(i, j):
        break

    if lines[i][j] == "#":
        previous = (turtle, direction)
        direction = change(direction)
        continue

    lines[i][j] = "#"

    ai, aj = turtle
    ifnext = direction
    if runthrough("N", start) and (i, j) not in dupes:
        counter += 1
        dupes |= set([(i, j)])

    lines[i][j] = "."

    turtle = (i, j)
    steps += 1


print(sum(map(sum, grid)))
print(counter)

