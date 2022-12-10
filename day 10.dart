import 'dart:io';

/*
String draw(sprite){

}
*/
void main() {
  var input = File('day 10.txt').readAsStringSync().split('\r\n');
  var cycle = 1;
  var X = 1;
  var sigStr = [];
  var crt = '';
  var sprite = [0, 1, 2];
  for (var i = 0; i < input.length; i++) {
    if (input[i].split(' ')[0] == 'noop') {
      cycle++;
      crt += ((sprite.contains((crt.length + 1) % 40))) ? '#' : '.';
    } else if (input[i].split(' ')[0] == 'addx') {
      cycle++;
      crt += ((sprite.contains((crt.length + 1) % 40))) ? '#' : '.';

      if ((cycle - 20) % 40 == 0) {
        sigStr.add(X * cycle);
      }

      X += int.tryParse(input[i].split(' ')[1]) ?? 0;
      sprite = [X - 1, X, X + 1];

      cycle++;
      crt += ((sprite.contains((crt.length + 1) % 40))) ? '#' : '.';
    }
    if ((cycle - 20) % 40 == 0) {
      sigStr.add(X * cycle);
    }
  }
  crt = '#' + crt.substring(0, crt.length - 1).replaceAll('.', ' ');
  print('part 1 : ${sigStr.reduce((value, element) => value + element)}');
  print('part 2 : ');

  for (var i = 0; i < (crt.length / 40.toInt()); i++) {
    print(crt.substring(i * 40, (i + 1) * 40));
  }
}
