import 'package:flutter/material.dart';
import 'package:music_app/screens/music_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key?key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme(brightness: Brightness.light, primary: Colors.blue.shade900, onPrimary: Colors.white, secondary: Colors.blueGrey.shade700, onSecondary: Colors.blueAccent, error: Colors.red, onError: Colors.white, background: Colors.white, onBackground: Colors.black, surface: Colors.black, onSurface: Colors.white),
      ),
      home: const MusicScreen(),

    );
  }

}
