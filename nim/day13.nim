import strutils, math

proc parse(path: string): (int, seq[(int, int)]) =
  let file = open path
  result[0] = parseInt readLine(file)
  let buses = readLine(file).split(',')
  for i, bus in buses:
    if bus != "x":
      result[1].add (i, parseInt(bus))

func part1(timestamp: int, buses: seq[(int, int)]): int =
  var earliest = int.high
  for (_, bus) in buses:
    let wait = bus - (timestamp mod bus)
    if wait < earliest:
      earliest = wait
      result = bus * wait

func part2(buses: seq[(int, int)]): int =
  var prime = 1
  for (i, bus) in buses:
    let delay = floorMod(bus-i, bus)
    let newPrime = prime * bus
    for n in countup(result, newPrime, prime):
      if n mod bus == delay:
        result = n
        prime = newPrime
        break

let (timestamp, buses) = parse "inputs/13.txt"
echo part1(timestamp, buses)
echo part2(buses)
