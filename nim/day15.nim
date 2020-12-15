import tables

proc solve(input: seq[int], limit: int): int =
  var t: Table[int, int]
  for i, n in input: t[n] = i+1
  for n in input.len+1 ..< limit:
    let next = n - t.getOrDefault(result, n)
    t[result] = n
    result = next

let input = @[9,3,1,0,8,4]
echo input.solve 2020
echo input.solve 30000000
