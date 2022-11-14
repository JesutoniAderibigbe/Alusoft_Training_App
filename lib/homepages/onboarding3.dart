import 'package:alusoft_app/homepages/first.dart';
import 'package:alusoft_app/homepages/onboarding2.dart';
import 'package:alusoft_app/homepages/screen_1.dart';
import 'package:alusoft_app/users/Usermiddlewares.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:flutter/material.dart';

class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({Key? key}) : super(key: key);

  @override
  State<OnBoarding3> createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 120,
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
            Center(child: Image.asset('assets/images/new.jfif')),
            const SizedBox(
              height: 50,
            ),
            const Text(
              '“We make Coding fun!”',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text('We provide ICT consultancy for businesses',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            const Text('and organisations. We guide you in making ICT'),
            const SizedBox(
              height: 5,
            ),
            const Text("decisions, quality hard-ware procurement,",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 5,
            ),
            const Text("software supports and many more"),
            SizedBox(
              height: 150,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    primary: Colors.pink),
                onPressed: () {
                  Loader.show(context,
                      isAppbarOverlay: true,
                      overlayFromTop: 100,
                      progressIndicator: Center(
                        child: SpinKitDoubleBounce(
                          color: Colors.pink,
                          size: 70.0,
                        ),
                      ),
                      themeData: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.fromSwatch()
                              .copyWith(secondary: Colors.black38)),
                      overlayColor: Color(0x99E8EAF6));

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));

                  Future.delayed(Duration(seconds: 5), () {
                    Loader.hide();
                  });
                },
                child: Text("Get Started",
                    style: TextStyle(fontSize: 20, color: Colors.white))),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    primary: Colors.white,
                    side: BorderSide(
                      width: 5.0,
                      color: Colors.pink,
                    )),
                onPressed: () {
                  Loader.show(context,
                      isAppbarOverlay: true,
                      overlayFromTop: 100,
                      progressIndicator: Center(
                          child: SpinKitFoldingCube(
                        color: Colors.pink,
                        size: 70.0,
                      )),
                      themeData: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.fromSwatch()
                              .copyWith(secondary: Colors.black38)),
                      overlayColor: Color(0x99E8EAF6));

                  ///loader hide after 3 seconds

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserMiddleWares()));

                  Future.delayed(Duration(seconds: 8), () {
                    Loader.hide();
                  });
                },
                child: Text("Login",
                    style: TextStyle(fontSize: 20, color: Colors.black)))
          ],
        ),
      ),
    );
  }
}
