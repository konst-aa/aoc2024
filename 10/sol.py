# contents = open("little.txt").read()
contents = open("inp.txt").read()

grid = [[int(c) for c in l] for l in contents.split()]

def from_zero(i, j, part2=False):
    visited = set()
    q = [(i, j)]

    adj = 0

    while q:
        a, b = q.pop()
        if not part2 and (a, b) in visited:
            continue
        visited |= set([(a, b)])
        if grid[a][b] == 9:
            adj += 1
            continue

        for ci, cj in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
            na = a + ci
            nb = b + cj
            if na < 0 or na >= len(grid):
                continue

            if nb < 0 or nb >= len(grid[0]):
                continue
            if grid[na][nb] == grid[a][b] + 1:
                q.append((na, nb))

    return adj


s = 0
s2 = 0

for i in range(len(grid)):
    for j in range(len(grid[i])):
        if grid[i][j] == 0:
            s += from_zero(i, j, part2=False)
            s2 += from_zero(i, j, part2=True)

print(s)
print(s2)
