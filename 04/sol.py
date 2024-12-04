contents = open("inp.txt").read()
# contents = open("little.txt").read()

l = contents.split()

def pred1(s):
    return s == "XMAS" or s == "SAMX"

counter = 0
for i in range(len(l)):
    for j in range(len(l[i])):
        if j < len(l[i]) - 3:
            if pred1(l[i][j:j+4]):
                counter += 1
        if i < len(l) - 3:
            if pred1(l[i][j] + l[i+1][j] + l[i+2][j] + l[i+3][j]):
                counter += 1
        if i < len(l) - 3 and j < len(l[i]) - 3:
            if pred1(l[i][j] + l[i+1][j+1] + l[i+2][j+2] + l[i+3][j+3]):
                counter += 1
        if i < len(l) - 3 and j >= 3:
            if pred1(l[i][j] + l[i+1][j-1] + l[i+2][j-2] + l[i+3][j-3]):
                counter += 1


print(counter)

counter = 0

def pred2(s):
    return s == "MS" or s == "SM"

for i in range(1, len(l)-1):
    for j in range(1, len(l[i])-1):
        if l[i][j] != "A":
            continue
        p1 = l[i-1][j-1] + l[i+1][j+1]
        p2 = l[i+1][j-1] + l[i-1][j+1]
        if pred2(p1) and pred2(p2):
            counter += 1

print(counter)
