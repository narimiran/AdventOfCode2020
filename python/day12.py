from functools import reduce


instructions = [(line[0], int(line[1:])) for line in open("inputs/12.txt").readlines()]

actions = {
        'N': lambda v: 1j * v,
        'E': lambda v: v,
        'S': lambda v: -1j * v,
        'W': lambda v: -v,
        'L': lambda v: 1j**(v // 90),
        'R': lambda v: (-1j)**(v // 90),
}

manhattan = lambda pos: int(abs(pos.real) + abs(pos.imag))

move = (lambda accum, element:
        (lambda part, pos, d, action, value:
         (part, pos, d * actions[action](value))   if action in 'LR' else
         (part, pos + d * value, d)                if action == 'F' else
         (part, pos + actions[action](value),  d)  if part == 1 else
         (part, pos,  actions[action](value) + d))
        (*accum, *element))

solve = lambda part, starting_dir: manhattan(reduce(move,
                                                    instructions,
                                                    (part, 0+0j, starting_dir)
                                                   )[1])

print(solve(1,  1+0j))
print(solve(2, 10+1j))
