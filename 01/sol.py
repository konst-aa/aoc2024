from collections import Counter

t = [map(int, l.split()) for l in open("inp.txt").readlines()]

a, b = zip(*t)
a = sorted(list(a))
b = sorted(list(b))

print(sum(abs(p1 - p2) for p1, p2 in zip(a, b)))

temp = Counter(b)

print(sum(n * temp[n] for n in a))
