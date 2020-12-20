from functools import reduce


groups = open('inputs/06.txt').read().split('\n\n')

yes = (lambda group, func:
       len(reduce(func, (set(person) for person in group.split()))))

print(sum(yes(group, set.union) for group in groups))
print(sum(yes(group, set.intersection) for group in groups))
