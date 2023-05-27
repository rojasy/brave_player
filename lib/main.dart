
import 'package:brave_player/screen.dart';
//import 'package:brave_player/screenplay.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';

//import 'musics.dart';
//import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primaryColor: Color(0X1AA7EC),
      ),
      home: Home(),
    );
  }
}
