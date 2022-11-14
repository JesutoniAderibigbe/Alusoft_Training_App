import 'package:alusoft_app/adminpage/admin.dart';
import 'package:alusoft_app/drawer/hidden_drawer.dart';
import 'package:alusoft_app/homepages/screen_1.dart';
import 'package:alusoft_app/users/userhomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserMiddleWares extends StatefulWidget {
  const UserMiddleWares({Key? key}) : super(key: key);

  @override
  State<UserMiddleWares> createState() => _UserMiddleWaresState();
}

class _UserMiddleWaresState extends State<UserMiddleWares> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return UserHomePage();
          } else {
            return LoginPage();
          }
        });
  }
}
