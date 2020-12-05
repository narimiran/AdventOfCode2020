import algorithm

proc generateIDs(boardingPasses: string): seq[int] =
  for pass in boardingPasses.lines:
    var
      lo, mid: int
      hi = 128*8
    for c in pass:
      mid = (lo + hi) div 2
      if c in {'F', 'L'}: hi = mid
      else: lo = mid
    result.add lo
  sort result

func findYourSeat(allIDs: seq[int]): int =
  for i, x in allIDs:
    if x+1 != allIDs[i+1]:
      return x+1

let allIDs = generateIDs "inputs/05.txt"

echo allIDs[^1]
echo findYourSeat(allIDs)
