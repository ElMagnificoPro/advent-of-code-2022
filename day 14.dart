import 'dart:io';
import 'dart:math';

class Point {
  int x = 0;
  int y = 0;
  Point(x, y) {
    this.x = x;
    this.y = y;
  }
}

Point point(String txt) {
  return Point(
      int.tryParse(txt.split(',')[0]), int.tryParse(txt.split(',')[1]));
}

int part1(Map input, int maxY) {
  var sand = '500,0';
  var next = false;
  var err = 0;

  while (point(sand).y < maxY && err < 100000) {
    if (next) {
      sand = '500,0';
      next = false;
    }
    if (!input.containsKey('${point(sand).x},${point(sand).y + 1}')) {
      sand = '${point(sand).x},${point(sand).y + 1}';
    } else if (!input
        .containsKey('${point(sand).x - 1},${point(sand).y + 1}')) {
      sand = '${point(sand).x - 1},${point(sand).y + 1}';
    } else if (!input
        .containsKey('${point(sand).x + 1},${point(sand).y + 1}')) {
      sand = '${point(sand).x + 1},${point(sand).y + 1}';
    } else {
      input[sand] = 'o';
      next = true;
    }
  }
  return input.values.where((e) => e == 'o').length;
}

int part2(Map input, int maxY) {
  var sand = '500,0';
  var next = false;
  var err = 0;

  while (err < 100000) {
    if (next) {
      if (sand == '500,0') break;
      sand = '500,0';
      next = false;
    }
    if (point(sand).y == maxY + 1) {
      input[sand] = 'o';
      next = true;
    } else if (!input.containsKey('${point(sand).x},${point(sand).y + 1}')) {
      sand = '${point(sand).x},${point(sand).y + 1}';
    } else if (!input
        .containsKey('${point(sand).x - 1},${point(sand).y + 1}')) {
      sand = '${point(sand).x - 1},${point(sand).y + 1}';
    } else if (!input
        .containsKey('${point(sand).x + 1},${point(sand).y + 1}')) {
      sand = '${point(sand).x + 1},${point(sand).y + 1}';
    } else {
      input[sand] = 'o';
      next = true;
    }
  }
  return input.values.where((e) => e == 'o').length;
}

void main() {
  var input = Map();
  var maxY = 0;
  var err = 0;
  File('./day 14.txt')
      .readAsStringSync()
      .split('\r\n')
      .map((e) => e
          .split(' -> ')
          .map((e) => e.split(',').map((e) => int.tryParse(e)).toList())
          .toList())
      .forEach((List<List> line) {
    for (var i = 0; i < line.length - 1; i++) {
      int x1 = min(line[i][0]!, line[i + 1][0]!);
      int x2 = max(line[i][0]!, line[i + 1][0]!);
      int y1 = min(line[i][1]!, line[i + 1][1]!);
      int y2 = max(line[i][1]!, line[i + 1][1]!);

      for (var x = line[i][0], y = line[i][1];
          x != line[i + 1][0] || y != line[i + 1][1];
          x += (line[i + 1][0] - line[i][0]).sign,
          y += (line[i + 1][1] - line[i][1]).sign) {
        input['$x,$y'] = '#';
        maxY = max(maxY, y);
      }
    }
    input['${line.last[0]},${line.last[1]}'] = '#';
  });

  print('part 1 : ${part1(input, maxY)}');
  print('part 2 : ${part2(input, maxY)}');
}
