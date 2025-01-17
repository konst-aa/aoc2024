# contents = open("little.txt").read()
# contents = open("little2.txt").read()
contents = open("inp.txt").read()

regs, program = contents.split("\n\n")

regs = [int(r.split(" ")[-1]) for r in regs.split("\n")]
target = program.split(" ")[-1].strip()
program = [int(c) for c in program.split(" ")[-1].split(",")]
pc = [0]
outl = []

def combo(oper):
    if oper <= 3:
        return oper
    if oper == 7:
        raise IndexError()
    return regs[oper - 4]

def adv(oper):
    regs[0] = regs[0] // (2 ** combo(oper))

def bxl(literal):
    regs[1] = literal ^ regs[1]

def bst(oper):
    regs[1] = combo(oper) % 8

def jnz(literal):
    if regs[0] == 0:
        return
    pc[0] = literal - 2

def bxc(_):
    regs[1] = regs[1] ^ regs[2]

def out(oper):
    outl.append(str(combo(oper) % 8))

def bdv(oper):
    regs[1] = regs[0] // (2 ** combo(oper))

def cdv(oper):
    regs[2] = regs[0] // (2 ** combo(oper))

ops = [adv, bxl, bst, jnz, bxc, out, bdv, cdv]


while pc[0]+1 < len(program):
    a, b = program[pc[0]], program[pc[0]+1]
    ops[a](b)
    pc[0] += 2

def part2(n):
    regs[0] = n
    regs[1] = 0
    regs[2] = 0
    pc[0] = 0
    outl[:] = []
    while pc[0]+1 < len(program):
        a, b = program[pc[0]], program[pc[0]+1]
        ops[a](b)
        pc[0] += 2
    return ",".join(outl)

print(",".join(outl))
# n = 0
# while True:
#     o = part2(n)
#     # print(target)
#     if o == target:
#         print(n)
#         break
#     if n % 1000 == 0:
#         print(n)
#     n += 1


