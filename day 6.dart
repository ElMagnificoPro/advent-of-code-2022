import 'dart:io';

bool isValidMarker(String marker) {
  for (var i = 0; i < marker.length; i++) {
    if (marker.lastIndexOf(marker[i]) != i) {
      return false;
    }
  }
  return true;
}

bool isValidMessage(String message) {
  for (var i = 0; i < message.length; i++) {
    if (message.lastIndexOf(message[i]) != i) {
      return false;
    }
  }
  return true;
}

int part1(String input) {
  for (var i = 0; i < input.length - 4; i++) {
    var marker = input.substring(i, i + 4);
    if (isValidMarker(marker)) {
      return i + 4;
    }
  }
  return -1;
}

int part2(String input) {
  for (var i = 0; i < input.length - 14; i++) {
    var message = input.substring(i, i + 14);
    if (isValidMessage(message)) {
      return i + 14;
    }
  }
  return -1;
}

main() {
  var input = File('day 6.txt').readAsStringSync();

  print("part 1 : ${part1(input)}");
  print("part 2 : ${part2(input)}");
}
