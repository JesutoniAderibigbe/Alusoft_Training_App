import 'package:flutter/material.dart';

class Nunu extends StatelessWidget {
  const Nunu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Container(child: Image.asset("assets/images/future.jfif")));
  }
}
