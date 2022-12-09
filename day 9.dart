import 'dart:io';
import 'dart:math';

class Knot {
  int x = 0;
  int y = 0;
}

class Instruction {
  String dir = '';
  int val = 0;
  Instruction(dir, val) {
    this.dir = dir;
    this.val = val;
  }
}

int simulate(List<Instruction> input, int ropeLength) {
  var rope = List.generate(ropeLength, (index) => Knot());
  Set<String> visited = Set();
  visited.add('(0,0)');

  for (var i = 0; i < input.length; i++) {
    for (var j = 0; j < input[i].val; j++) {
      if (input[i].dir == 'U') {
        rope[0].y++;
      } else if (input[i].dir == 'D') {
        rope[0].y--;
      } else if (input[i].dir == 'L') {
        rope[0].x--;
      } else if (input[i].dir == 'R') {
        rope[0].x++;
      }

      for (var k = 1; k < rope.length; k++) {
        int dx = (rope[k - 1].x - rope[k].x);
        int dy = (rope[k - 1].y - rope[k].y);

        if (sqrt(dx * dx + dy * dy) > 1.5) {
          if (dx > 0) {
            rope[k].x++;
          } else if (dx < 0) {
            rope[k].x--;
          }

          if (dy > 0) {
            rope[k].y++;
          } else if (dy < 0) {
            rope[k].y--;
          }

          if (k == rope.length - 1) {
            visited.add('(${rope[k].x},${rope[k].y})');
          }
        }
      }
    }
  }
  return visited.length;
}

void main() {
  List<Instruction> input = File('day 9.txt')
      .readAsStringSync()
      .split('\r\n')
      .map<Instruction>(
          (e) => Instruction(e.split(' ')[0], int.tryParse(e.split(' ')[1])))
      .toList();

  print('part 1 : ${simulate(input, 2)}');
  print('part 2 : ${simulate(input, 10)}');
}
