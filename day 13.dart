import 'dart:convert';
import 'dart:io';

compare(p1, p2) {
  if (p1 is int && p2 is int) {
    if (p1 < p2) {
      return -1;
    } else if (p1 == p2) {
      return 0;
    } else {
      return 1;
    }
  } else if (p1 is List && p2 is List) {
    var i = 0;
    while (i < p1.length && i < p2.length) {
      var res = compare(p1[i], p2[i]);

      if (res == -1)
        return -1;
      else if (res == 1)
        return 1;
      else
        i++;
    }
    if (i == p1.length && i < p2.length) {
      return -1;
    } else if (i < p1.length && i == p2.length) {
      return 1;
    } else {
      return 0;
    }
  } else if (p1 is int && p2 is List) {
    return compare([p1], p2);
  } else if (p1 is List && p2 is int) {
    return compare(p1, [p2]);
  }
}

void main() {
  List input = File('day 13.txt')
      .readAsStringSync()
      .split('\r\n\r\n')
      .map((e) => e.split('\r\n').map((e) => json.decode(e)).toList())
      .toList();

  var part1 = 0;
  for (var i = 0; i < input.length; i++) {
    if (compare(input[i][0], input[i][1]) == -1) part1 += i + 1;
  }

  input.add([
    [
      [2]
    ],
    [
      [6]
    ]
  ]);

  input = input.expand((element) => element).toList();
  input.sort(((a, b) => compare(a, b)));

  var div = [0, 0];
  for (var i = 0; i < input.length; i++) {
    if (jsonEncode(input[i]) == '[[2]]') div[0] = i + 1;
    if (jsonEncode(input[i]) == '[[6]]') div[1] = i + 1;
  }

  print('part 1 : $part1');
  print('part 2 : ${div[0] * div[1]}');
}
