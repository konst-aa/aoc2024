contents = open("inp.txt").read()

import re

c = 0
for a, b in re.findall(r"mul\((\d+),(\d+)\)", contents):
    c += int(a) * int(b)

# world 477 on part 1! < 3 min
print(c)

dos = list(reversed(list(re.finditer(r"(do\(\)|don't\(\))", contents))))

on = True

c = 0
for m in re.finditer(r"mul\((\d+),(\d+)\)", contents):
    a, _ = m.span()
    while len(dos) > 0 and dos[-1].span()[0] < a:
        if dos[-1].group(1) == 'do()':
            on = True
        else:
            on = False
        dos.pop()
    n, m = m.groups()
    if on:
        c += int(n) * int(m)

print(c)
