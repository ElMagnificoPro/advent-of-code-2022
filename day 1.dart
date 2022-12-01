import 'dart:io';

main() {
  List input = [];
  input = File('input 1.txt')
      .readAsStringSync()
      .split('\n')
      .map((e) => int.tryParse(e) ?? (0))
      .toList();

  List elves = [];
  num sum = 0;
  for (var i = 0; i < input.length; i++) {
    if (input[i] == 0) {
      elves.add(sum);
      sum = 0;
    } else {
      sum += input[i];
    }
  }
  elves.add(sum);

  elves.sort((a, b) => b.compareTo(a));
  print("part 1 : " + elves[0].toString());
  print("part 2 : " + (elves[0] + elves[1] + elves[2]).toString());
}
