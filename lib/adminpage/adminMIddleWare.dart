import 'package:alusoft_app/adminpage/admin.dart';
import 'package:alusoft_app/adminpage/newadmin.dart';
import 'package:alusoft_app/drawer/hidden_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminMiddleWare extends StatefulWidget {
  const AdminMiddleWare({Key? key}) : super(key: key);

  @override
  State<AdminMiddleWare> createState() => _AdminMiddleWareState();
}

class _AdminMiddleWareState extends State<AdminMiddleWare> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return HiddenDrawer();
          } else {
            return NewAdmin();
          }
        });
  }
}
