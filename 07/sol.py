# contents = open("little.txt").read()
contents = open("inp.txt").read()

def help(target, nums, p2=False):
    if len(nums) <= 1:
        return nums
    
    out = []
    for ans in help(target, nums[1:], p2=p2):
        if ans * nums[0] <= target:
            out.append(ans * nums[0])
        if ans + nums[0] <= target:
            out.append(ans + nums[0])
        cn = int(str(ans) + str(nums[0]))
        if p2 and cn <= target:
            out.append(cn)
    return out

c1 = 0
c2 = 0
for l in contents.splitlines(keepends=False):
    a, b = l.split(":")
    a = int(a)
    lst = list(reversed(list(map(int, b.split()))))
    if a in help(a, lst):
        c1 += a
    if a in help(a, lst, p2=True):
        c2 += a

print(c1)
print(c2)
