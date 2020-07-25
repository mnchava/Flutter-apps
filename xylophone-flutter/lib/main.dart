import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';


void main() => runApp(XylophoneApp());

void playSound(int note){
  final player = AudioCache();
  player.play('note$note.wav');
}

Expanded buildKey(int s, Color c){
  return Expanded(
    child: FlatButton(
      onPressed: () {
        playSound(s);
      },
      color: c,
    ),
  );
}

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildKey(1, Colors.red.shade900),
            buildKey(2, Colors.red.shade700),
            buildKey(3, Colors.red.shade500),
            buildKey(4, Colors.purple.shade400),
            buildKey(5, Colors.blue.shade500),
            buildKey(6, Colors.blue.shade700),
            buildKey(7, Colors.blue.shade900),

          ],
        ),
      ),
    );
  }
}
