instructions = [(l[0], int(l[1])) for l in
                (line.strip().split() for line in open("inputs/08.txt").readlines())]

part_1 = (lambda instr, i=0, seen=set(), accum=0:
          (False, accum) if i in seen else
          (True, accum) if i >= len(instr)
          else part_1(instr,
                      i + (instr[i][1] if instr[i][0] == 'jmp' else 1),
                      seen | {i},
                      accum + (instr[i][1] if instr[i][0] == 'acc' else 0)))

def change_instruction(instr, i):
    new_instr = instr.copy()
    new_instr[i] = ('nop' if instr[i][0] == 'jmp' else 'jmp', instr[i][1])
    return new_instr

part_2 = lambda instr: next(result for finished, result in (part_1(change_instruction(instr, i))
                                                            for i in range(len(instr))
                                                            if instr[i][0] in {'jmp', 'nop'})
                            if finished)

print(part_1(instructions)[1])
print(part_2(instructions))
