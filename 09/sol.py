# contents = open("little.txt").read().strip()
contents = open("inp.txt").read().strip()
l = []
l2 = []
idd = 0
file = True
for char in contents:
    for i in range(int(char)):
        if file:
            l.append(idd)
        else:
            l.append('.')
    if file:
        l2.append((int(char) ,idd))
        idd += 1
    else:
        l2.append((int(char), '.'))
    file = not file


j = len(l2) - 1

# print(l2)

while j >= 0:
    i = 0
    size, c = l2[j]
    if c == '.':
        j -= 1
        continue

    while i < len(l2) and i < j:
        size2, c2 = l2[i]
        if c2 == '.' and size <= size2:
            if size == size2:
                l2[i], l2[j] = l2[j], l2[i]
            else:
                l2[j] = (size, '.')
                l2[i] = (size2 - size, '.')
                l2.insert(i, (size, c))
                j += 1
            break
        i += 1

    j -= 1


i = 0
j = len(l) - 1

while i < j:
    while l[i] != '.' and i < j:
        i += 1
    while l[j] == '.' and i < j:
        j -= 1

    l[i], l[j] = l[j], l[i]




s = 0
s2 = 0
for i, c in enumerate(l):
    if c != ".":
        s += i * int(c)

print(s)
i = 0
for s, c in l2:
    if c == ".":
        i += s
        continue
    for _ in range(s):
        s2 += i * int(c)
        i += 1

print(s2)
