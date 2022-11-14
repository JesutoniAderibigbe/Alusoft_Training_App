import 'dart:ui';

import 'package:alusoft_app/homepages/screen_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminLogOut extends StatefulWidget {
  const AdminLogOut({Key? key}) : super(key: key);

  @override
  State<AdminLogOut> createState() => _AdminLogOutState();
}

class _AdminLogOutState extends State<AdminLogOut> {
  final ThemeData specialThemeData = ThemeData(
    brightness: Brightness.dark,

    // and so on...
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/bb.png'),
        )),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  onTap: <Widget>() {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('You sure of this?'),
                        content: const Text(''),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.pop(context);
                              },
                              child: const Text('OK')),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Click to SignOut',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
