table = str.maketrans("FBLR", "0101")

content = sorted(int(line.translate(table), 2)
                 for line in open("inputs/05.txt").readlines())

print(content[-1])
print(next(x+1 for x, y in zip(content, content[1:]) if x+1 != y))
