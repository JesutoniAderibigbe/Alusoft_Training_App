import 'dart:ui';

import 'package:alusoft_app/users/settings.dart';
import 'package:alusoft_app/users/user_check_mail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

class UserChange extends StatefulWidget {
  const UserChange({Key? key}) : super(key: key);

  @override
  State<UserChange> createState() => _UserChangeState();
}

class _UserChangeState extends State<UserChange> {
  final emailController = TextEditingController();
  int _counter = 0;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future changePassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showNotification();
      Loader.show(context,
          isAppbarOverlay: true,
          overlayFromTop: 100,
          progressIndicator: Center(
              child: SpinKitRipple(
            color: Colors.pink,
            size: 70.0,
          )),
          themeData: Theme.of(context).copyWith(
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
          overlayColor: Color(0x99E8EAF6));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CheckMail()));

      Future.delayed(Duration(seconds: 8), () {
        Loader.hide();
      });
    } catch (e) {
      Loader.show(context,
          isAppbarOverlay: true,
          overlayFromTop: 100,
          progressIndicator: Center(
              child: SpinKitFadingCircle(
            color: Colors.red,
            size: 70.0,
          )),
          themeData: Theme.of(context).copyWith(
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
          overlayColor: Color(0x99E8EAF6));

      Future.delayed(Duration(seconds: 10), () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text(e.toString()),
                ));
        Loader.hide();
      });
    }
  }

  showNotification() async {
    setState(() {
      _counter++;
    });

    flutterLocalNotificationsPlugin.show(
        0,
        "Alusoft App",
        "E-mail sent! Check your mail.",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.pink,
                playSound: true,
                icon: '@mipmap/launcher_icon')));

    print("Hey");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserSettingsPage()));
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Back",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.questionCircle,
                color: Colors.black,
              ))
        ],
        elevation: 0,
        toolbarHeight: 60,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Reset password",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black)),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Enter the email associated with your account and we'll send an email with instructions to reset your password.",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'E-mail Address',
                  hintText: "example@abc.com",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Write a valid email';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              changePassword();

              print("You tapped me");
            },
            child: Center(
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                    child: Text(
                  "Send Instructions",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
