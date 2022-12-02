import 'dart:io';

main() {
  List input = <int>[];
  input = File('day 1.txt')
      .readAsStringSync()
      .split('\r\n\r\n')
      .map((block) => block.split('\n').map((e) => int.tryParse(e) ?? (0)))
      .map((e) => e.reduce((v, e) => v + e))
      .toList();

  //print(input);
  input.sort((a, b) => b.compareTo(a));
  print("part 1 : " + input[0].toString());
  print("part 2 : " +
      input.take(3).cast<int>().reduce((v, e) => v + e).toString());
}
