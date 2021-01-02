import strutils, strscans, sets, tables

type
  Bag = tuple[amount: int, color: string]
  Bags = seq[Bag]
  Bagushka = Table[string, Bags]
  Bagushkas = tuple[larger, smaller: Bagushka]

proc createConnections(path: string): Bagushkas =
  var
    amount: int
    c1, c2, contents: string
  for line in path.lines:
    if line.scanf("$+ bags contain $+", c1, contents):
      result[1][c1] = @[]
      for bag in contents.split(", "):
        if bag.scanf("$i $+ bag", amount, c2):
          result[0].mgetOrPut(c2, @[]).add (0, c1)
          result[1][c1].add (amount, c2)

proc part1(bagushka: Bagushka, bag: string): int =
  proc aux(bagushka: Bagushka, current: string, seen: var HashSet[string]) =
    if not bagushka.hasKey(current): return
    for bag in bagushka[current]:
      if not seen.containsOrIncl(bag.color):
        aux(bagushka, bag.color, seen)
  var seen: HashSet[string]
  aux(bagushka, bag, seen)
  result = seen.card

func part2(bagushka: Bagushka, current: string): int =
  for bag in bagushka[current]:
    result += bag.amount * (1 + part2(bagushka, bag.color))


let bagushkas = createConnections "inputs/07.txt"
const OurBag = "shiny gold"

echo part1(bagushkas.larger, OurBag)
echo part2(bagushkas.smaller, OurBag)
