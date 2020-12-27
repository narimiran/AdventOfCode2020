instructions = [int(n) for n in open("inputs/09.txt").readlines()]

part_1 = lambda instr: next(num for i, num in enumerate(instr[25:])
                            if not any (num-m in instr[i:25+i]
                                        for m in instr[i:25+i]))

part_2 = (lambda instr, goal, lo=0, hi=2:
          min(r) + max(r) if sum(r := instr[lo:hi]) == goal
          else part_2(instr, goal, lo, hi+1) if sum(r) < goal
          else part_2(instr, goal, lo+1, hi))

p1 = part_1(instructions)
print(p1)
print(part_2(instructions, p1))
