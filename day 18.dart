import 'dart:io';

void main() {
  var input = File('day 18.txt')
      .readAsStringSync()
      .split('\r\n')
      .map((e) => e.split(',').map((e) => int.parse(e)).toList())
      .toList();

  var sides = 0;
  var lava = {};
  var steam = {};

  for (var i = 0; i < input.length; i++) {
    lava['${input[i][0]},${input[i][1]},${input[i][2]}'] = 1;
  }

  int checkneighbors(x, y, z, dict) {
    //print('${x},${y},${z}');
    var sides = 0;
    if (!dict.containsKey('${x + 1},${y},${z}')) sides++;
    if (!dict.containsKey('${x - 1},${y},${z}')) sides++;
    if (!dict.containsKey('${x},${y + 1},${z}')) sides++;
    if (!dict.containsKey('${x},${y - 1},${z}')) sides++;
    if (!dict.containsKey('${x},${y},${z + 1}')) sides++;
    if (!dict.containsKey('${x},${y},${z - 1}')) sides++;
    return sides;
  }

  for (var i = 0; i < input.length; i++) {
    //print('${input[i][0]},${input[i][1]},${input[i][2]}');
    sides += checkneighbors(input[i][0], input[i][1], input[i][2], lava);
    //   print('--------------');
  }

  void addSteam(x, y, z) {
    if (!lava.containsKey('${x},${y},${z}')) steam['${x},${y},${z}'] = 1;
  }

  for (var i = 0; i < input.length; i++) {
    var x = input[i][0];
    var y = input[i][1];
    var z = input[i][2];

    addSteam(x + 1, y, z);
    addSteam(x - 1, y, z);
    addSteam(x, y + 1, z);
    addSteam(x, y - 1, z);
    addSteam(x, y, z + 1);
    addSteam(x, y, z - 1);
  }

  //big steam pockets
  for (var i = 0; i < 10; i++) {
    var temp = {};
    for (var key in steam.keys) {
      var x = int.parse(key.toString().split(',')[0]);
      var y = int.parse(key.toString().split(',')[1]);
      var z = int.parse(key.toString().split(',')[2]);

      if (!lava.containsKey('${x + 1},${y},${z}'))
        temp['${x + 1},${y},${z}'] = 1;
      if (!lava.containsKey('${x - 1},${y},${z}'))
        temp['${x - 1},${y},${z}'] = 1;
      if (!lava.containsKey('${x},${y + 1},${z}'))
        temp['${x},${y + 1},${z}'] = 1;
      if (!lava.containsKey('${x},${y - 1},${z}'))
        temp['${x},${y - 1},${z}'] = 1;
      if (!lava.containsKey('${x},${y},${z + 1}'))
        temp['${x},${y},${z + 1}'] = 1;
      if (!lava.containsKey('${x},${y},${z - 1}'))
        temp['${x},${y},${z - 1}'] = 1;
    }
    steam.addAll(temp);
  }

  var exposedLavaSurfaces = 0;
  while (true) {
    var removedCount = 0;
    var temp = {};
    for (var key in steam.keys) {
      var x = int.parse(key.toString().split(',')[0]);
      var y = int.parse(key.toString().split(',')[1]);
      var z = int.parse(key.toString().split(',')[2]);

      var lavaCount = checkneighbors(x, y, z, lava);
      var steamCount = checkneighbors(x, y, z, steam);
      if (lavaCount + steamCount > 6) {
        exposedLavaSurfaces += 6 - lavaCount;
        removedCount++;
        temp[key] = 1;
      }
    }
    for (var key in temp.keys) {
      steam.remove(key);
    }
    if (removedCount == 0) break;
  }

  print('part 1 : $sides');
  print('part 2 : $exposedLavaSurfaces');
}
