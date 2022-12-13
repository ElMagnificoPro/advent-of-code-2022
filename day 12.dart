import 'dart:io';

extension ListExtensions<T> on List<T> {
  bool containsIndex(int index) {
    return index >= 0 && this.length > index;
  }
}

int part1(List<List> input, start) {
  var visited = Set();
  List<dynamic> queue = [
    [0, start]
  ];
  visited.add('${start}');

  while (queue.isNotEmpty) {
    var q = queue.removeAt(0);
    var steps = q[0];
    List pos = q[1];

    if (input[pos[0]][pos[1]] == 27) {
      return steps;
    }

    if (input.containsIndex(pos[0] + 1) &&
        input[pos[0] + 1][pos[1]] - input[pos[0]][pos[1]] <= 1 &&
        !visited.contains('${[pos[0] + 1, pos[1]]}')) {
      queue.add([
        steps + 1,
        [pos[0] + 1, pos[1]]
      ]);
      visited.add('${[pos[0] + 1, pos[1]]}');
    }

    if (input.containsIndex(pos[0] - 1) &&
        input[pos[0] - 1][pos[1]] - input[pos[0]][pos[1]] <= 1 &&
        !visited.contains('${[pos[0] - 1, pos[1]]}')) {
      queue.add([
        steps + 1,
        [pos[0] - 1, pos[1]]
      ]);
      visited.add('${[pos[0] - 1, pos[1]]}');
    }

    if (input[0].containsIndex(pos[1] + 1) &&
        input[pos[0]][pos[1] + 1] - input[pos[0]][pos[1]] <= 1 &&
        !visited.contains('${[pos[0], pos[1] + 1]}')) {
      queue.add([
        steps + 1,
        [pos[0], pos[1] + 1]
      ]);
      visited.add('${[pos[0], pos[1] + 1]}');
    }

    if (input[0].containsIndex(pos[1] - 1) &&
        input[pos[0]][pos[1] - 1] - input[pos[0]][pos[1]] <= 1 &&
        !visited.contains('${[pos[0], pos[1] - 1]}')) {
      queue.add([
        steps + 1,
        [pos[0], pos[1] - 1]
      ]);
      visited.add('${[pos[0], pos[1] - 1]}');
    }
  }
  return -1;
}

int part2(List<List> input, start) {
  var visited = Set();
  List<dynamic> queue = [
    [0, start]
  ];
  visited.add('${start}');

  while (queue.isNotEmpty) {
    var q = queue.removeAt(0);
    var steps = q[0];
    List pos = q[1];

    if (input[pos[0]][pos[1]] == 1) {
      return steps;
    }

    if (input.containsIndex(pos[0] + 1) &&
        input[pos[0]][pos[1]] - input[pos[0] + 1][pos[1]] <= 1 &&
        !visited.contains('${[pos[0] + 1, pos[1]]}')) {
      queue.add([
        steps + 1,
        [pos[0] + 1, pos[1]]
      ]);
      visited.add('${[pos[0] + 1, pos[1]]}');
    }

    if (input.containsIndex(pos[0] - 1) &&
        input[pos[0]][pos[1]] - input[pos[0] - 1][pos[1]] <= 1 &&
        !visited.contains('${[pos[0] - 1, pos[1]]}')) {
      queue.add([
        steps + 1,
        [pos[0] - 1, pos[1]]
      ]);
      visited.add('${[pos[0] - 1, pos[1]]}');
    }

    if (input[0].containsIndex(pos[1] + 1) &&
        input[pos[0]][pos[1]] - input[pos[0]][pos[1] + 1] <= 1 &&
        !visited.contains('${[pos[0], pos[1] + 1]}')) {
      queue.add([
        steps + 1,
        [pos[0], pos[1] + 1]
      ]);
      visited.add('${[pos[0], pos[1] + 1]}');
    }

    if (input[0].containsIndex(pos[1] - 1) &&
        input[pos[0]][pos[1]] - input[pos[0]][pos[1] - 1] <= 1 &&
        !visited.contains('${[pos[0], pos[1] - 1]}')) {
      queue.add([
        steps + 1,
        [pos[0], pos[1] - 1]
      ]);
      visited.add('${[pos[0], pos[1] - 1]}');
    }
  }
  return -1;
}

void main() {
  var letters = 'SabcdefghijklmnopqrstuvwxyzE';
  var input = File('day 12.txt')
      .readAsStringSync()
      .split('\r\n')
      .map((e) => e.split('').map((e) => letters.indexOf(e)).toList())
      .toList();

  var start, end;
  for (var i = 0; i < input.length; i++) {
    for (var j = 0; j < input[i].length; j++) {
      if (input[i][j] == 0) start = [i, j];
      if (input[i][j] == 27) end = [i, j];
    }
  }

  print(part1(input, start));
  print(part2(input, end));
}
