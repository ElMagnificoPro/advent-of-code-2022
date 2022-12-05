import 'dart:io';
import 'dart:convert';

String part1(stacks, instructions) {
  for (var i = 0; i < instructions.length; i++) {
    var instr = instructions[i];
    stacks[instr['to']]
        .addAll(stacks[instr['from']].reversed.take(instr['move']));
    stacks[instr['from']] = stacks[instr['from']]
        .sublist(0, (stacks[instr['from']].length - instr['move']).toInt());
  }
  return stacks.map((e) => e.last).reduce((value, element) => value + element);
}

String part2(stacks, instructions) {
  for (var i = 0; i < instructions.length; i++) {
    var instr = instructions[i];
    stacks[instr['to']].addAll(stacks[instr['from']]
        .sublist((stacks[instr['from']].length - instr['move']).toInt()));
    stacks[instr['from']] = stacks[instr['from']]
        .sublist(0, (stacks[instr['from']].length - instr['move']).toInt());
  }
  return stacks.map((e) => e.last).reduce((value, element) => value + element);
}

void main() {
  List<List> stacks = [];
  var input = File('day 5.txt')
      .readAsStringSync()
      .split('\r\n\r\n')[0]
      .split('\r\n')
      .map((e) => e
          .replaceAll('] [', '-')
          .replaceAll('  [', '-')
          .replaceAll(']  ', '-')
          .replaceAll('- ', '-*')
          .replaceAll(' -', '*-')
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('   ', '-')
          .replaceAll('  ', '*')
          .replaceAll(' ', ''))
      .toList();
  input.removeLast();
  stacks =
      new List.generate(input[0].split('-').length, (i) => [], growable: true);
  for (var i = input.length - 1; i >= 0; i--) {
    var line = input[i].split('-');
    for (var j = 0; j < line.length; j++) {
      if (line[j] != '*') {
        stacks[j].add(line[j]);
      }
    }
  }
  var instructions = [];

  File('day 5.txt')
      .readAsStringSync()
      .split('\r\n\r\n')[1]
      .split('\r\n')
      .forEach((e) {
    var instr = e
        .replaceAll('move ', '')
        .replaceAll(' from ', '-')
        .replaceAll(' to', '-')
        .split('-')
        .map((e) => int.tryParse(e))
        .toList();
    instructions
        .add({'move': instr[0], 'from': instr[1]! - 1, 'to': instr[2]! - 1});
  });

  print('part 1 : ${part1(jsonDecode(jsonEncode(stacks)), instructions)}');
  print('part 2 : ${part2(jsonDecode(jsonEncode(stacks)), instructions)}');
}
