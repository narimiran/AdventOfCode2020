import aoc, strutils, strscans, tables

func findFloatingMasks(mask: string): seq[int] =
  ## There are 2^N (1 shl N) combinations, where N is number of X's.
  ## E.g. for three X's the combinations are 000, 001, 010, 011, 100, 101, 110, 111;
  ## i.e. binary representation of numbers in 0..<2^N range.
  ## For every combination, we replace n-th X with n-th digit of the combination.
  var floatingMask = mask
  let xCount = mask.count 'X'
  for n in 0 ..< 1 shl xCount:
    let binN = n.toBin(xCount)
    var j = 0
    for i, pos in mask:
      if pos == 'X':
        floatingMask[i] = binN[j]
        inc j
    result.add parseBinInt(floatingMask)

proc solve(path: string): IntSolutions =
  var mem1, mem2: Table[int, int]
  var k, v, m1, m2: int
  var mask: string
  var masks: seq[int]
  for line in path.lines:
    if line.scanf("mask = $+$.", mask):
      m1 = parseBinInt mask.replace('X', '0')
      m2 = parseBinInt mask.replace('X', '1')
      masks = findFloatingMasks(mask)
    elif line.scanf("mem[$i] = $i", k, v):
      mem1[k] = (v or m1) and m2
      k = (k or m1) and (not m2)
      for m in masks:
        mem2[k or m] = v
  for v in mem1.values:
    result.first += v
  for v in mem2.values:
    result.second += v

echo solve "inputs/14.txt"
