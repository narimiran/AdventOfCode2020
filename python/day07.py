from functools import reduce


bags = {k: [(int(amount), ' '.join(color))
            for (amount, *color, _) in map(str.split, vals.split(", "))]
        for (k, vals) in (line.strip().split(" bags contain ")
                          for line in open("inputs/07.txt").readlines())
        if "no other bag" not in vals}

contains_ours = (lambda looking_in:
                 any(OUR_BAG in color or contains_ours(color)
                     for (_, color) in bags[looking_in] if color in bags.keys()))

inside_of = (lambda curr:
             0 if curr not in bags.keys()
             else sum(amount * (1 + inside_of(color))
                      for (amount, color) in bags[curr]))


OUR_BAG = "shiny gold"
print(sum(contains_ours(bag) for bag in bags.keys()))
print(inside_of(OUR_BAG))
