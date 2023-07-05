import 'dart:collection';
import 'dart:io';
import 'dart:math';

void main() {
  Map<String, List<String>> tunnels = {};
  Map<String, int> valves = {};

  File('day 16.txt').readAsStringSync().split('\r\n').forEach((e) {
    String valve = e.split(' ')[1];
    int pressure = int.tryParse(e.split('rate=')[1].split(';')[0]) ?? 0;
    List<String> edges =
        e.split(' to ')[1].split(' ').sublist(1).join('').split(',');

    valves[valve] = pressure;
    tunnels[valve] = edges;
  });

  List<String> nonempty = [];
  Map<String, Map<String, int>> dists = {};

  for (var valve in valves.keys) {
    if (valve != 'AA' && valves[valve] == 0) continue;

    if (valve != 'AA') nonempty.add(valve);

    dists[valve] = {valve: 0, "AA": 0};

    var visited = {valve};
    var queue = Queue();
    queue.add([0, valve]);

    while (queue.isNotEmpty) {
      var deque = queue.removeFirst();
      var dist = deque[0];
      var pos = deque[1];
      for (var neighbor in tunnels[pos]!) {
        if (visited.contains(neighbor)) continue;
        visited.add(neighbor);
        if (valves[neighbor]! > 0) {
          dists[valve]![neighbor] = dist + 1;
        }
        queue.add([dist + 1, neighbor]);
      }
    }

    dists[valve]!.remove(valve);
    if (valve != 'AA') {
      dists[valve]!.remove('AA');
    }
  }

  var indexes = {};
  var cache = {};

  for (var i = 0; i < nonempty.length; i++) {
    indexes.addAll({nonempty[i]: i});
  }

  int dfs(time, valve, bitmask) {
    if (cache.containsKey("${time},${valve},${bitmask}"))
      return cache["${time},${valve},${bitmask}"];

    var maxval = 0;

    for (var neighbor in dists[valve]!.keys) {
      var bit = 1 << indexes[neighbor];
      if (bitmask & bit > 0) continue;

      var remtime = time - dists[valve]![neighbor] - 1;
      if (remtime <= 0) continue;

      maxval = max(
          maxval,
          (dfs(remtime, neighbor, bitmask | bit) + valves[neighbor]! * remtime)
              as int);
    }

    cache["${time},${valve},${bitmask}"] = maxval;

    return maxval;
  }

  int b = (1 << nonempty.length) - 1;
  var maxval = 0;

  for (var i = 0; i < b + 1; i++) {
    maxval = max(maxval, dfs(26, 'AA', i) + dfs(26, 'AA', b ^ i));
  }

  print('part 1 : ${dfs(30, 'AA', 0)}');
  print('part 2 : ${maxval}');
}
