# Advent of Code 2020

All my Advent of Code repos:

* [AoC 2015 in Nim](https://github.com/narimiran/advent_of_code_2015)
* [AoC 2016 in Python](https://github.com/narimiran/advent_of_code_2016)
* [AoC 2017 in Nim, OCaml, Python](https://github.com/narimiran/AdventOfCode2017)
* [AoC 2018 in Nim](https://github.com/narimiran/AdventOfCode2018)
* [AoC 2019 in OCaml](https://github.com/narimiran/AdventOfCode2019)
* [AoC 2020 in Nim](https://github.com/narimiran/AdventOfCode2020) (this repo)


&nbsp;


## Solutions



Task                                                              | Solution                   | Comment
---                                                               | ---                        | ---
[Day 1: Report Repair](https://adventofcode.com/2020/day/1)       | [day01.nim](nim/day01.nim) | Small check `elif s[i] + s[j] < 2020:` makes the whole program ~4x faster.
[Day 2: Password Philosophy](https://adventofcode.com/2020/day/2) | [day02.nim](nim/day02.nim) | `scanf` useful as always.
[Day 3: Toboggan Trajectory](https://adventofcode.com/2020/day/3) | [day03.nim](nim/day03.nim) | Keeping it below 20 lines :)
[Day 4: Passport Processing](https://adventofcode.com/2020/day/4) | [day04.nim](nim/day04.nim) | Had a nasty early morning bug with `if not v.len == 9`. Argh.
[Day 5: Binary Boarding](https://adventofcode.com/2020/day/5)     | [day05.nim](nim/day05.nim) | Traversing a sorted list is more eficient than looking for every number in unsorted one.
[Day 6: Custom Customs](https://adventofcode.com/2020/day/6)      | [day06.nim](nim/day06.nim) | Classic AoC-use-sets tasks.
[Day 7: Handy Haversacks](https://adventofcode.com/2020/day/7)    | [day07.nim](nim/day07.nim) | Babushka bag = Bagushka.
[Day 8: Handheld Halting](https://adventofcode.com/2020/day/8)    | [day08.nim](nim/day08.nim) | Faster than it looks.
[Day 9: Encoding Error](https://adventofcode.com/2020/day/9)      | [day09.nim](nim/day09.nim) | Sliding slice sum.
[Day 10: Adapter Array](https://adventofcode.com/2020/day/10)     | [day10.nim](nim/day10.nim) | `CountTable` to the rescue.
[Day 11: Seating System](https://adventofcode.com/2020/day/11)    | [day11.nim](nim/day11.nim) | The ugliest and the slowest solution so far.
[Day 12: Rain Risk](https://adventofcode.com/2020/day/12)         | [day12.nim](nim/day12.nim) | Using complex numbers is s[o][1][o][2][o][3][o][4] last Tuesday. No `Complex` this time.
[Day 13: Shuttle Search](https://adventofcode.com/2020/day/13)    | [day13.nim](nim/day13.nim) | Yeah yeah, [CRT](https://en.wikipedia.org/wiki/Chinese_remainder_theorem), but it took me way too long to implement it correctly.



[1]: https://github.com/narimiran/advent_of_code_2016/blob/master/python/day_01.py)
[2]: https://github.com/narimiran/advent_of_code_2016/blob/master/python/day_02.py)
[3]: https://github.com/narimiran/AdventOfCode2017/blob/master/nim/day19.nim)
[4]: https://github.com/narimiran/AdventOfCode2017/blob/master/python/day22.py)
