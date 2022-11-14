import 'package:flutter/material.dart';

class UserThemes extends StatefulWidget {
  const UserThemes({Key? key}) : super(key: key);

  @override
  State<UserThemes> createState() => _UserThemesState();
}

bool _iconBool = false;
IconData _iconLight = Icons.wb_sunny;
IconData _iconDark = Icons.nights_stay;

ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.amber,
    brightness: Brightness.light,
    buttonTheme: ButtonThemeData(buttonColor: Colors.pink));

ThemeData _darkTheme =
    ThemeData(primarySwatch: Colors.red, brightness: Brightness.dark);

class _UserThemesState extends State<UserThemes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _iconBool ? _darkTheme : _lightTheme,
      home: Scaffold(
          appBar: AppBar(
        title: Text("Dark and Light Theme"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _iconBool = !_iconBool;
                });
              },
              icon: Icon(_iconBool ? _iconDark : _iconLight))
        ],
      )),
    );
  }
}
