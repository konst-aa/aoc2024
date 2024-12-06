contents = open("inp.txt").read()
# contents = open("little.txt").read()

rules, e = contents.split("\n\n")

rd = {}
for rule in rules.split():
    a, b = map(int, rule.split("|"))
    if a not in rd:
        rd[a] = []
    rd[a].append(b)

c = 0
others = []

for en in e.split():
    l = list(map(int, en.split(",")))
    t = {}
    for i, n in enumerate(l):
        t[n] = i

    fail = False

    for n, i in t.items():
        if n not in rd:
            continue
        rs = rd[n]
        for r in rs:
            if r in t and t[r] < i:
                fail = True
        if fail:
            break

    if not fail:
        c += l[len(l)//2]
    else:
        others.append(t)

print(c)

c = 0

for o in others:
    acc = []
    while len(o) > 0:
        for n, i in o.items():
            if n not in rd or not any(map(lambda k: k in o, rd[n])):
                acc.append(n)
                del o[n]
                break

    acc.reverse()
    c += acc[len(acc)//2]

print(c)

