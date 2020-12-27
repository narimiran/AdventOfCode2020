from operator import mul
from functools import reduce
from itertools import groupby


combos = [1, 1, 2, 4, 7, 13, 24, 44]

adapters = sorted(int(n) for n in open("inputs/10.txt").readlines())

differences = [b-a for a, b in zip([0]+adapters, adapters+[adapters[-1]+3])]

print(reduce(mul, (len(list(g)) for _, g in groupby(sorted(differences)))))
print(reduce(mul, (combos[len(list(g))] for k, g in groupby(differences) if k == 1)))
