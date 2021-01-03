import strutils, tables, sequtils, streams
import npeg


type
  RuleKind = enum
    rkLetter, rkList, rkChoice
  Rule = object
    case kind: RuleKind
    of rkLetter:
      letter: char
    of rkList:
      rules: seq[int]
    of rkChoice:
      left: seq[int]
      right: seq[int]
  Rules = Table[int, Rule]
  Messages = seq[string]


proc parse(path: string): (Rules, Messages) =
  ##[ created with -d:npegGraph

input o─┬─[rule]─┬»─'\n'─»┬─[message]─┬─o
        ╰───«────╯        ╰─────«─────╯

        ╭╶╶╶╶╶╶╶╶╶╶╶╮
rule o───┬─[Digit]─┬──»─": "─»─┬─[letter]─┬─»─'\n'──o
        ┆╰────«────╯┆          ├─[choice]─┤
        ╰╶╶╶╶╶╶╶╶╶╶╶╯          ╰─[list]───╯

                ╭╶╶╶╶╶╶╶╶╶╮
letter o──'"'─»───[Alpha]───»─'"'──o
                ╰╶╶╶╶╶╶╶╶╶╯

          ╭╶╶╶╶╶╶╶╶╮           ╭╶╶╶╶╶╶╶╶╮
choice o────[list]───»─" | "─»───[list]────o
          ╰╶╶╶╶╶╶╶╶╯           ╰╶╶╶╶╶╶╶╶╯

                   ╭─────────»─────────╮
list o─┬─[Digit]─┬»┴┬─' '─»┬─[Digit]─┬┬┴─o
       ╰────«────╯  │      ╰────«────╯│
                    ╰────────«────────╯

           ╭╶╶╶╶╶╶╶╶╶╶╶╮
message o───┬─[Alpha]─┬──»─'\n'──o
           ┆╰────«────╯┆
           ╰╶╶╶╶╶╶╶╶╶╶╶╯
]##
  var rules: Rules
  var currentRule: Rule
  var messages: Messages

  let parser = peg input:
    input <- +rule * '\n' * +message
    rule <- >+Digit * ": " * (letter | choice | list) * '\n':
      rules[parseInt($1)] = currentRule
    letter <- '"' * >Alpha * '"':
      currentRule = Rule(kind: rkLetter, letter: ($1)[0])
    choice <- >list * " | " * >list:
      currentRule = Rule(kind: rkChoice,
                         left: ($1).split.map(parseInt),
                         right: ($2).split.map(parseInt))
    list <- +Digit * *(' ' * +Digit):
      currentRule = Rule(kind: rkList, rules: ($0).split.map(parseInt))
    message <- >+Alpha * '\n':
      messages.add $1

  discard parser.matchFile(path)
  return (rules, messages)


proc isValid(s: Stream, rules: Rules, ruleNr: int): bool =
  result = true
  let rule = rules[ruleNr]
  case rule.kind
  of rkLetter:
    return s.readChar == rule.letter
  of rkList:
    for r in rule.rules:
      if not s.isValid(rules, r):
        return false
  of rkChoice:
    let currentPos = s.getPosition
    for r in rule.left:
      if not s.isValid(rules, r):
        result = false
        break
    if not result:
      s.setPosition(currentPos)
      for r in rule.right:
        if not s.isValid(rules, r):
          return false
      return true

proc part1(messages: seq[string], rules: Rules): int =
  for message in messages:
    let s = newStringStream message
    if s.isValid(rules, 0) and s.atEnd:
      inc result

proc part2(messages: seq[string], rules: Rules): int =
  for message in messages:
    let s = newStringStream message
    var count42, count31, currentPos: int
    while s.isValid(rules, 42):
      currentPos = s.getPosition
      inc count42
    if count42 > 0:
      s.setPosition currentPos
      while s.isValid(rules, 31):
        inc count31
      if s.atEnd and count42 > count31 and count31 > 0:
        inc result


let (rules, messages) = parse "inputs/19.txt"
echo part1(messages, rules)
echo part2(messages, rules)
