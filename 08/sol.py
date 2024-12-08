# contents = open("little.txt").read()
contents = open("inp.txt").read()

lines = contents.split()

freqs = {}
for i in range(len(lines)):
    for j in range(len(lines[i])):
        c = lines[i][j]
        if c == ".":
            continue
        if c not in freqs:
            freqs[c] = []
        freqs[c].append((i, j))

mi, mj = len(lines), len(lines[0])

def in_bounds(p):
    i, j = p
    return i >= 0 and i < mi and j >= 0 and j < mj


locs1 = set()
locs2 = set()
for c, l in freqs.items():
    for i in range(len(l)):
        for j in range(i+1, len(l)):
            ai, aj = l[i]
            bi, bj = l[j]
            di = ai - bi
            dj = aj - bj
            if in_bounds((ai + di, aj + dj)):
                locs1 |= set([(ai + di, aj + dj)])
            if in_bounds((bi - di, bj - dj)):
                locs1 |= set([(bi - di, bj - dj)])

            while in_bounds((ai, aj)):
                locs2 |= set([(ai, aj)])
                ai += di
                aj += dj
            while in_bounds((bi, bj)):
                locs2 |= set([(bi, bj)])
                bi -= di
                bj -= dj


print(len(locs1))
print(len(locs2))
