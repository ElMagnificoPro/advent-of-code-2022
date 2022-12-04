import 'dart:io';

main() {
  var input = File('day 4.txt')
      .readAsStringSync()
      .split('\r\n')
      .toList()
      .map((e) => e
          .split(',')
          .map((e) => e.split('-').map((e) => int.tryParse(e)).toList())
          .toList())
      .toList();

  int part1 = 0, part2 = 0;
  input.forEach((e) => {
        if (e[0][0]! <= e[1][0]! && e[0][1]! >= e[1][1]! ||
            e[1][0]! <= e[0][0]! && e[1][1]! >= e[0][1]!)
          {part1++},
        if (e[0][1]! >= e[1][0]! && e[0][0]! <= e[1][1]! ||
            e[1][1]! >= e[0][0]! && e[1][1]! <= e[0][1]!)
          {part2++}
      });

  print('part 1 : ${part1}');
  print('part 2 : ${part2}');
}
