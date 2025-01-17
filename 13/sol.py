contents = open("little.txt").read()


def play(a, b, prize):
    x, y = prize
    if x < 0 or y < 0:
        return None
    if x == 0 or y == 0:
        return 0

    usea = play(a, b, a(prize))
    useb = play(a, b, b(prize))
    if usea is None and useb is None:
        return None
    if usea is None:
        return useb + 3
    if useb is None:
        return usea + 1
    if usea + 1 < useb + 3:
        return usea + 1
    return useb + 3

a = lambda t: (t[0] + 94, t[1] + 34)
b = lambda t: (t[0] + 22, t[1] + 67)

print("THIS ONE I DIDNT FINISH")
# print(play(a, b, (8400, 5400)))

