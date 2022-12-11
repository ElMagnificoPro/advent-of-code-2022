import 'dart:convert';
import 'dart:io';

int operation(String op, int old) {
  var vals = op.split(' ');
  if (vals[1] == '+') {
    return old + ((vals[2] == 'old') ? old : int.tryParse(vals[2]) as int);
  } else {
    return old * ((vals[2] == 'old') ? old : int.tryParse(vals[2]) as int);
  }
}

int part1(items, operations, tests, throws) {
  var active = List.filled(items.length, 0);

  for (var round = 0; round < 20; round++) {
    for (var monkey = 0; monkey < items.length; monkey++) {
      for (var item in items[monkey]) {
        int worry = (operation(operations[monkey], item as int) ~/ 3);

        if (worry % tests[monkey] == 0) {
          items[throws[monkey][0]].add(worry);
        } else {
          items[throws[monkey][1]].add(worry);
        }
        active[monkey]++;
      }
      items[monkey] = [];
    }
  }
  active.sort();
  return active
      .sublist(active.length - 2)
      .reduce((value, element) => value * element);
}

int part2(items, operations, tests, throws) {
  var active = List.filled(items.length, 0);
  var lcm = tests.reduce((value, element) => value * element);

  for (var round = 0; round < 10000; round++) {
    for (var monkey = 0; monkey < items.length; monkey++) {
      for (var item in items[monkey]) {
        int worry = (operation(operations[monkey], item as int));

        if (worry % tests[monkey] == 0) {
          items[throws[monkey][0]].add(worry % lcm);
        } else {
          items[throws[monkey][1]].add(worry % lcm);
        }
        active[monkey]++;
      }
      items[monkey] = [];
    }
  }
  active.sort();
  return active
      .sublist(active.length - 2)
      .reduce((value, element) => value * element);
}

void main() {
  // implied monkeys
  List<List> items = [];
  var operations = [];
  var tests = [];
  var throws = [];

  File('day 11 test.txt')
      .readAsStringSync()
      .split('\r\n\r\n')
      .forEach((element) {
    var lines = element.split('\r\n');
    items.add(lines[1]
        .substring(18)
        .split(', ')
        .map((e) => int.tryParse(e))
        .toList());

    operations.add(lines[2].substring(19));
    tests.add(int.tryParse(lines[3].substring(21)));
    throws.add([
      int.tryParse(lines[4].substring(29)),
      int.tryParse(lines[5].substring(29))
    ]);
  });

/*
  print(active);
  active.sort();
  print(active
      .sublist(active.length - 2)
      .reduce((value, element) => value * element));
      */
  print(
      'part 1 : ${part1(jsonDecode(jsonEncode(items)), operations, tests, throws)}');
  print(
      'part 2 : ${part2(jsonDecode(jsonEncode(items)), operations, tests, throws)}');
}
