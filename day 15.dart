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

int distance(Point a, Point b) {
  return (a.x - b.x).abs() + (a.y - b.y).abs();
}

void main() {
  var input = [];
  var part2 = 0;
  var row = 2000000;
  var maxXY = 4000000;

  File('day 15.txt').readAsStringSync().split('\r\n').forEach((line) {
    var sx =
        int.tryParse(line.substring(line.indexOf('x=') + 2, line.indexOf(',')));
    var sy =
        int.tryParse(line.substring(line.indexOf('y=') + 2, line.indexOf(':')));
    var bx = int.tryParse(
        line.substring(line.lastIndexOf('x=') + 2, line.lastIndexOf(',')));
    var by = int.tryParse(line.substring(line.lastIndexOf('y=') + 2));

    input.add({'S': Point(sx, sy), 'B': Point(bx, by)});
  });

// part 1
  var part1 = Set();
  for (var i = 0; i < input.length; i++) {
    var d1 = distance(input[i]['S'], input[i]['B']);
    var d2 = (input[i]['S'].y - row).abs();
    for (var j = 0; j <= d1 - d2; j++) {
      part1.add(input[i]['S'].x + j);
      part1.add(input[i]['S'].x - j);
    }
  }

  for (var i = 0; i < input.length; i++) {
    if (input[i]['B'].y == row) part1.remove(input[i]['B'].x);
  }

//part 2

  for (var line = 0; line <= maxXY; line++) {
    var ranges = [];
    input.forEach((e) {
      int d1 = distance(e['S']!, e['B']!);
      int d2 = (e['S']!.y - line).abs();
      if (d2 <= d1) {
        var minX = max(0, e['S']!.x - (d1 - d2) as int);
        var maxX = min(maxXY, e['S']!.x + (d1 - d2) as int);

        if (ranges.length == 0)
          ranges.add([minX, maxX]);
        else {
          var currentRange = [minX, maxX];
          for (var i = ranges.length - 1; i >= 0; i--) {
            if (currentRange[0] <= ranges[i][1] &&
                ranges[i][0] <= currentRange[1]) {
              currentRange[0] = min(currentRange[0], ranges[i][0]);
              currentRange[1] = max(currentRange[1], ranges[i][1]);
              ranges.removeAt(i);
            }
          }
          ranges.add(currentRange);
        }
      }
    });
    if (!(ranges[0][0] == 0 && ranges[0][1] == maxXY)) {
      part2 = (ranges[0][1] + 1) * 4000000 + line;
      break;
    }
  }

  print('part 1 : ${part1.length}');
  print('part 2 : $part2');
}
