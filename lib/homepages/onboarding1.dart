import 'package:alusoft_app/homepages/onboarding2.dart';
import 'package:alusoft_app/homepages/screen_1.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({Key? key}) : super(key: key);

  @override
  State<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
  bool _enabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 120,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Image.asset(
              'assets/images/alusoft white.jfif',
            )),
            const SizedBox(
              height: 100,
            ),
            const Text(
              'Software Development',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.pink),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text('We develop excellent and cost-effective'),
            const SizedBox(
              height: 5,
            ),
            const Text('software solutions for government,'),
            const SizedBox(
              height: 5,
            ),
            Text('businesses, corporate enterprise, and personal use.'),
            SizedBox(
              height: 200,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (((context) => LoginPage()))));
                    },
                    style: TextButton.styleFrom(primary: Colors.black),
                    child: Text(
                      'Skip',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(width: 70),
                  Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.pink.shade100,
                      enabled: _enabled,
                      direction: ShimmerDirection.ltr,
                      child: Text(
                        "Slide Up",
                        style: TextStyle(fontSize: 24),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
