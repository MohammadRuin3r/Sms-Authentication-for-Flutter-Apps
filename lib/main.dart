import 'package:auth_app/screens/auth_screen.dart';
import 'package:auth_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

Future<bool> isActive() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isActive') ?? false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: isActive(),
        builder: (_, snapshot) {
          if (snapshot.data == true) {
            return HomeScreen();
          } else {
            return AuthScreen();
          }
        },
      ),
    );
  }
}
