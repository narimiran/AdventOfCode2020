func buildQuasiLinkedList(input: string, length: int): seq[int] =
  result = newSeq[int](length+1)
  var prev =
    if length == input.len: ord(input[^1]) - ord('0')
    else: length
  for c in input:
    let n = ord(c) - ord('0')
    result[prev] = n
    prev = n
  for n in 10..length:
    result[prev] = n
    prev = n

func playRound(next: var seq[int], head: var int, size: int) =
  let pickedUp = [next[head],
             next[next[head]],
        next[next[next[head]]]]
  var lookingFor = head - 1
  if lookingFor == 0: lookingFor = size
  while lookingFor in pickedUp:
    dec lookingFor
    if lookingFor == 0: lookingFor = size
  next[head] = next[pickedUp[^1]]
  next[pickedUp[^1]] = next[lookingFor]
  next[lookingFor] = pickedUp[0]
  head = next[head]

func part1(input: string): string =
  let size = input.len
  var next = input.buildQuasiLinkedList size
  var head = ord(input[0]) - ord('0')
  for _ in 1 .. 100:
    playRound(next, head, size)
  head = 1
  for _ in 1 ..< size:
    head = next[head]
    result.add $head

func part2(input: string): int =
  let size = 1_000_000
  var next = input.buildQuasiLinkedList size
  var head = ord(input[0]) - ord('0')
  for _ in 1 .. 10*size:
    playRound(next, head, size)
  result = next[1] * next[next[1]]


let input = "784235916"
echo input.part1
echo input.part2
