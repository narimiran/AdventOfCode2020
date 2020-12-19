from itertools import count
from operator import mul
from functools import reduce

grid = [line.strip() for line in open("inputs/03.txt").readlines()]

traverse = lambda right, down: sum(grid[y][x % len(grid[0])] == '#'
                                   for (x, y) in zip(count(0, right),
                                                     range(0, len(grid), down)))

print(traverse(3, 1))

slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
print(reduce(mul, (traverse(*s) for s in slopes)))
