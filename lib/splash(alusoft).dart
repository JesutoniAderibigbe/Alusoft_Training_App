import 'dart:ui';

import 'package:alusoft_app/homepages/onboarding1.dart';
import 'package:alusoft_app/homepages/pagebuilder.dart';

import 'package:flutter/material.dart';

class Alusoft extends StatefulWidget {
  const Alusoft({Key? key}) : super(key: key);

  @override
  State<Alusoft> createState() => _AlusoftState();
}

class _AlusoftState extends State<Alusoft> {
  @override
  void initState() {
    super.initState();
    const delay = Duration(seconds: 7);
    Future.delayed(delay, () => onTimer());
  }

  void onTimer() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) {
        return const PageBuilder();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: splashscreenIcon(),
      ),
    );
  }
}

Widget splashscreenIcon() {
  return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/bb.png')),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Center(
          child: Text(
            "Alusoft Technologies Ltd",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ));
}
