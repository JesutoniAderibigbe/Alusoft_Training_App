import 'package:alusoft_app/homepages/onboarding1.dart';
import 'package:alusoft_app/homepages/onboarding3.dart';
import 'package:alusoft_app/homepages/screen_1.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Onboarding2 extends StatefulWidget {
  const Onboarding2({Key? key}) : super(key: key);

  @override
  State<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
  bool _enabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        elevation: 0,

        // title: Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Text("Already have an account?"),
        //     Text(
        //       "Sign in",
        //       style: TextStyle(color: Colors.pink.shade200),
        //     ),
        //   ],
        // ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(child: Image.asset('assets/images/white3.jfif')),
            const SizedBox(
              height: 100,
            ),
            const Text(
              'ICT TRAINING',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text('We offer ICT trainings for both corporate',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            const Text('organization and individuals who are willing to',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            const Text('take their ICT skill to the next level so as to',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            const Text('meet up with technological advancement',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
            ),
            Row(
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
            )
          ],
        ),
      ),
    );
  }
}
