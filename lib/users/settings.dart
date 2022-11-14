// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:alusoft_app/users/UserchangePassword.dart';
import 'package:alusoft_app/users/profile_page.dart';
import 'package:flutter/material.dart';

class UserSettingsPage extends StatefulWidget {
  UserSettingsPage({Key? key}) : super(key: key);

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
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

class _UserSettingsPageState extends State<UserSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _iconBool ? _darkTheme : _lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          toolbarHeight: 120,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.pink,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (((context) => UserProfilePage()))));
            },
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (((context) => UserChange()))));
                          },
                          child: Text('Change Password',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text('Update Profile',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text('Switch Mode',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black))),
                      SizedBox(
                        width: 50,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _iconBool = !_iconBool;
                            });
                          },
                          icon: Icon(_iconBool ? _iconDark : _iconLight))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
