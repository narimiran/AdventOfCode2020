import strutils, strscans, tables

type
  Ticket = seq[int]
  Tickets = seq[Ticket]
  Rules = set[0..65535] # ugly Nim limitation
  TicketFields = OrderedTable[string, Rules]
  Information = object
    fields: TicketFields
    myTicket: Ticket
    nearbyTickets: Tickets
    validTickets: Tickets


func extractFields(fields: string): TicketFields =
  var min1, max1, min2, max2: int
  var field: string
  for line in fields.splitlines:
    if line.scanf("$+: $i-$i or $i-$i", field, min1, max1, min2, max2):
      result[field] = {min1..max1, min2..max2}

func extractNumbers(tickets: string): Tickets =
  let lines = tickets.splitLines
  for i in 1 .. lines.high:
    result.add @[]
    for n in lines[i].split(','):
      result[^1].add parseInt(n)

proc parse(path: string): Information =
  let groups = (readFile path).strip.split("\n\n")
  result.fields = groups[0].extractFields
  result.myTicket = groups[1].extractNumbers[0]
  result.nearbyTickets = groups[2].extractNumbers

func part1(input: var Information): int =
  func findValidNumbers(fields: TicketFields): Rules =
    for v in fields.values:
      result.incl v
  let validNumbers = input.fields.findValidNumbers
  for ticket in input.nearbyTickets:
    var isValid = true
    for n in ticket:
      if n notin validNumbers:
        result += n
        isValid = false
    if isValid:
      input.validTickets.add ticket
  input.validTickets.add input.myTicket

func findPossible(input: Information): TicketFields =
  func extractColumn(tickets: Tickets, column: int): Rules =
    for ticket in tickets:
      result.incl ticket[column]
  for column in 0 ..< input.myTicket.len:
    let colValues = input.validTickets.extractColumn(column)
    for k, vals in input.fields.pairs:
      if colValues <= vals:
        result.mgetOrPut(k, {}).incl column

func eliminationProcess(possible: TicketFields): Table[string, int] =
  var possible = possible
  func ascendingLength(a, b: (string, Rules)): int = a[1].card - b[1].card
  possible.sort(ascendingLength)
  var seen: Rules
  for k, vals in possible.pairs:
    let remaining = vals - seen
    for v in remaining: result[k] = v
    seen.incl remaining

func part2(input: Information): int =
  result = 1
  let possible = input.findPossible
  let final = possible.eliminationProcess
  for k, v in final.pairs:
    if k.startsWith "departure":
      result *= input.myTicket[v]


var input = parse "inputs/16.txt"
echo part1(input)
echo part2(input)
