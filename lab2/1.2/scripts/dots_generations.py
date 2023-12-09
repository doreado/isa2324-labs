#!/usr/bin/env python3

layers = 4
dadda_width = 12
dots_width = 22
row_num = 6
width = 21

# initialize with zeros
dots = [[0 for _ in range(dots_width)] for _ in range(row_num)]

for i in range(0, row_num):
    for j in range(0, i * 2):
        if j == (i - 1) * 2:
            dots[i][dots_width - 1 - j] = 1
    for j in range(dadda_width):
        dots[i][dots_width - 1 - (j + (i * 2))] = 1

# add sign extension
for i in range(row_num):
    for j in range(2):
        dots[i][dots_width - 1 - (dadda_width + j + (i * 2))] = 1
dots[0][dots_width - 1 - (dadda_width + 2)] = 1

for i in range(row_num):
    print(dots[i])


# count elements
dots_heights = [0 for _ in range(dots_width)]
for j in range(dots_width):
    acc = 0
    for i in range(row_num):
        acc = acc + dots[i][j]

    dots_heights[j] = acc

print()
print(dots_heights)

level_heights = [[0 for _ in range(dots_width)] for _ in range(3)]
maximum = [4, 3, 2]
for r, i in enumerate(maximum):
    carries = 0
    print(dots_heights)
    print()
    for j in range(dots_width):
        dots_heights[dots_width - 1 - j] += carries
        level_heights[r][dots_width - 1 - j] = dots_heights[dots_width - 1 - j] #  = dots_heights[dots_width - 1 - j]

        match dots_heights[dots_width - 1 - j] - i:
            case 1:
                print("HA")
                dots_heights[dots_width - 1 - j] -= 1
                carries = 1
            case 2:
                print("FA")
                dots_heights[dots_width - 1 - j] -= 2
                carries = 1
            case 3:
                print("HA FA")
                dots_heights[dots_width - 1 - j] -= 3
                carries = 2
            case 4:
                print("FA FA")
                carries = 2
                dots_heights[dots_width - 1 - j] -= 4
            case _:
                carries = 0
                print("Nothing")


elements = ["{" + ", ".join(map(str, row)) + "}" for row in level_heights]

# Concatenate the strings with curly braces to form the SystemVerilog array syntax
sv_array = "int heights[0:2][dots_width - 1:0] = {" + ", ".join(elements) + "};"
print(sv_array)
