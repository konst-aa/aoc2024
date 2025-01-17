contents = open("little.txt").read()
# contents = open("inp.txt").read()

stones = list(map(int, contents.split()))

def rule(s):
    if s == 0:
        return [1]
    t = str(s)
    if len(t) % 2 == 0:
        mid = len(t) // 2
        return [int(t[:mid]), int(t[mid:])]
    return [s * 2024]

def flatmap(f, l):
    res = []
    for item in l:
        for r in f(item):
            res.append(r)
    return res

print(stones)

print("this one times out for part2!")

# for i in range(75):
#     print(i)
#     print(len(stones))
#     stones = flatmap(rule, stones)



# print(len(stones))
