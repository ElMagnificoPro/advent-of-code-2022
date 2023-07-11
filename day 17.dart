import 'dart:io';

bool equal(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  if (a.length == 0) return false;

  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }

  return true;
}

int simulate(String input, List<List<String>> rocks, int totalRocks) {
  int currRock = 0;
  var rockPos = [3, 2];
  var currCycle = 0;
  int rocksFallen = 0;
  var chamber = {};
  var maxHeight = 0;
  bool rockIsFalling = true;
  var states = {};
  bool skipped = false;

  while (rocksFallen < totalRocks) {
    if (rockIsFalling) {
      ////move left
      if (input[currCycle % input.length] == '<') {
        bool canMove = true;
        for (var i = 0; i < rocks[currRock].length; i++) {
          var line = int.parse(rocks[currRock][i], radix: 2) <<
              7 - rockPos[1] - rocks[currRock][i].length;
          if (rockPos[1] <= 0 ||
              line << 1 &
                      (chamber[rockPos[0] + rocks[currRock].length - i] ?? 0) !=
                  0) {
            canMove = false;
            break;
          }
        }

        if (canMove) rockPos[1]--;
      }
      ////move right
      if (input[currCycle % input.length] == '>') {
        bool canMove = true;
        for (var i = 0; i < rocks[currRock].length; i++) {
          var line = int.parse(rocks[currRock][i], radix: 2) <<
              7 - rockPos[1] - rocks[currRock][i].length;

          if (rockPos[1] + rocks[currRock][i].length >= 7 ||
              line >> 1 &
                      (chamber[rockPos[0] + rocks[currRock].length - i] ?? 0) !=
                  0) {
            canMove = false;
            break;
          }
        }

        if (canMove) rockPos[1]++;
      }
      //rock fall
      bool canFall = true;
      for (var i = 0; i < rocks[currRock].length; i++) {
        var line = int.parse(rocks[currRock][i], radix: 2) <<
            7 - rockPos[1] - rocks[currRock][i].length;

        if (rockPos[0] <= 0 ||
            (chamber[rockPos[0] + rocks[currRock].length - i - 1] ?? 0) &
                    line !=
                0) {
          canFall = false;
          break;
        }
      }

      if (canFall) {
        rockPos[0]--;
      } else {
        for (var i = 0; i < rocks[currRock].length; i++) {
          var line = int.parse(rocks[currRock][i], radix: 2) <<
              7 - rockPos[1] - rocks[currRock][i].length;
          chamber[rockPos[0] + rocks[currRock].length - i] =
              (chamber[rockPos[0] + rocks[currRock].length - i] ?? 0) | line;
        }
        maxHeight = chamber.keys
            .toList()
            .reduce((curr, next) => curr > next ? curr : next);
        rockIsFalling = false;
        rocksFallen++;
      }
      currCycle++;
    } else {
      //part2
      if (!skipped) {
        var roof = [];
        for (var j = 0; j < 7; j++) {
          for (var i = maxHeight; i > 0; i--) {
            if (chamber[i] & 1 << j != 0) {
              roof.add(maxHeight - i);
              break;
            }
          }
          if (roof.length <= j) {
            roof.add(-1);
          }
        }

        var state = '${roof.toString()},${currCycle % input.length},$currRock';
        if (states.containsKey(state) && states[state][0] != 0) {
          var diffR = rocksFallen - states[state][0];
          var diffH = maxHeight - states[state][1];
          var skips = ((totalRocks - states[state][0]) ~/ diffR) - 1;
          rocksFallen += diffR * skips as int;

          for (var i = 0; i < 7; i++) {
            chamber[maxHeight + (diffH * skips) - roof[i]] = 1 << i;
          }
          maxHeight = chamber.keys
              .toList()
              .reduce((curr, next) => curr > next ? curr : next);
          skipped = true;
        } else {
          states[state] = [rocksFallen, maxHeight];
        }
      }

      rockPos = [3 + maxHeight, 2];
      currRock++;
      currRock = currRock % 5;
      rockIsFalling = true;
    }
  }
  return maxHeight;
}

void main() {
  String input = File('day 17.txt').readAsStringSync().trim();
  //String input = File('day 17 test.txt').readAsStringSync().trim();

  List<List<String>> rocks = [
    ["1111"],
    ["010", "111", "010"],
    ["001", "001", "111"],
    ["1", "1", "1", "1"],
    ["11", "11"]
  ];

/*
  for (var i = chamber.length; i >= 0; i--) {
    print(chamber[i]
        .toRadixString(2)
        .padLeft(7, '0')
        .replaceAll(RegExp(r'0'), '.')
        .replaceAll(RegExp(r'1'), '#'));
  }
*/

  print('part 1 : ${simulate(input, rocks, 2022)}');
  print('part 2 : ${simulate(input, rocks, 1000000000000)}');
}




// 10000   15148
// 100000  151434
// 1000000 1514288
// 10000000 15142861
