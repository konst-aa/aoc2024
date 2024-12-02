# I lowkey should do this in prolog someday

lines = open("inp.txt").readlines()

def part_1(l):
    is_inc = l[0] < l[-1]
    if l[0] < l[-1]:
        comp = lambda a, b: a < b
    else:
        comp = lambda a, b: a > b

    for i in range(1, len(l)):
        d = abs(l[i-1]-l[i])
        if comp(l[i-1], l[i]) and d >= 1 and d <= 3:
            continue
        else:
            return False

    return True

def part_2(l):
    if part_1(l):
        return True
    for i in range(len(l)):
        temp = [n for n in l]
        del temp[i]
        if part_1(temp):
            return True
    return False


c1 = 0
c2 = 0

for l in lines:
    reports = list(map(int, l.split()))
    c1 += int(part_1(reports))
    c2 += int(part_2(reports))

print(c1)
print(c2)

