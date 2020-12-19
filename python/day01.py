from itertools import combinations
from functools import reduce
from operator import mul


numbers = [int(n) for n in open("inputs/01.txt").readlines()]

solve = lambda part: next(reduce(mul, c)
        for c in combinations(numbers, part+1)
        if sum(c) == 2020)

print(solve(1))
print(solve(2))
