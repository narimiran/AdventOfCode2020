proc solve(input: seq[int], limit: int): int =
  var t = newSeq[int](limit)
  for i, n in input: t[n] = i+1
  for n in input.len+1 ..< limit:
    let diff = n - t[result]
    t[result] = n
    result = if diff == n: 0 else: diff

let input = @[9,3,1,0,8,4]
echo input.solve 2020
echo input.solve 30_000_000
