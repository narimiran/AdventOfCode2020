from functools import reduce


bags = dict((line[0], list(map(str.split, line[1].split(", "))))
            for line in (line.strip().split(" bags contain ")
                         for line in (open("inputs/07.txt")).readlines())
            if "no other bag" not in line[1])

part_1 = (lambda looking_in, seen:
          reduce(set.union,
                 (part_1({larger for larger, smaller in bags.items()
                                 for bag in smaller
                                 if ' '.join(bag[1:3]) == wanted},
                         (seen | {wanted}))
                  for wanted in looking_in),
                 seen)
          - {OUR_BAG})

part_2 = (lambda bags, curr:
          0 if curr not in bags.keys()
          else sum(int(bag[0]) * (1 + part_2(bags, ' '.join(bag[1:3])))
                   for bag in bags[curr]))

OUR_BAG = "shiny gold"
print(len(part_1({OUR_BAG}, set())))
print(part_2(bags, OUR_BAG))
