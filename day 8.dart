import 'dart:io';

int part1(List<List<int?>> input) {
  var count = (input.length - 1) * 4;
  for (var i = 1; i < input.length - 1; i++) {
    for (var j = 1; j < input.length - 1; j++) {
      var tree = input[i][j];
      var top = [];
      var left = [];
      var bottom = [];
      var right = [];

      left = input[i].sublist(0, j);
      right = input[i].sublist(j + 1);
      for (var k = 0; k < i; k++) {
        top.add(input[k][j]);
      }
      for (var k = i + 1; k < input[i].length; k++) {
        bottom.add(input[k][j]);
      }

      if (top.where((e) => e >= tree).length == 0) {
        count++;
      } else if (left.where((e) => e >= tree).length == 0) {
        count++;
      } else if (bottom.where((e) => e >= tree).length == 0) {
        count++;
      } else if (right.where((e) => e >= tree).length == 0) {
        count++;
      }
    }
  }
  return count;
}

int part2(List<List<int?>> input) {
  var scores = [];
  for (var i = 1; i < input.length - 1; i++) {
    for (var j = 1; j < input.length - 1; j++) {
      var sTop = 0, sBottom = 0, sLeft = 0, sRight = 0;
      var tree = input[i][j];
      var top = [];
      var left = [];
      var bottom = [];
      var right = [];

      left = input[i].sublist(0, j).reversed.toList();
      right = input[i].sublist(j + 1);
      for (var k = 0; k < i; k++) {
        top.add(input[k][j]);
      }
      top = top.reversed.toList();
      for (var k = i + 1; k < input[i].length; k++) {
        bottom.add(input[k][j]);
      }

      for (var k = 0; k < top.length; k++) {
        sTop += 1;
        if (tree! <= top[k]) {
          break;
        }
      }
      for (var k = 0; k < left.length; k++) {
        sLeft++;
        if (tree! <= left[k]) {
          break;
        }
      }
      for (var k = 0; k < bottom.length; k++) {
        sBottom++;
        if (tree! <= bottom[k]) {
          break;
        }
      }
      for (var k = 0; k < right.length; k++) {
        sRight++;
        if (tree! <= right[k]) {
          break;
        }
      }

      scores.add(sTop * sLeft * sBottom * sRight);
    }
  }
  scores.sort();
  return scores.reversed.toList()[0];
}

void main() {
  var input = File('day 8.txt')
      .readAsStringSync()
      .split('\r\n')
      .map((e) => e.split('').map((e) => int.tryParse(e)).toList())
      .toList();

  print('part 1 : ${part1(input)}');
  print('part 2 : ${part2(input)}');
}
