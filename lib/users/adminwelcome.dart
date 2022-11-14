import 'dart:ui';

import 'package:alusoft_app/images/nunu.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserWelcomePage extends StatefulWidget {
  const UserWelcomePage({Key? key}) : super(key: key);

  @override
  State<UserWelcomePage> createState() => _UserWelcomePageState();
}

class _UserWelcomePageState extends State<UserWelcomePage> {
  String _selectedMenu = '';
  final user = FirebaseAuth.instance.currentUser!;
  int activeIndex = 0;

  final urlImages = [
    'https://web.facebook.com/photo.php?fbid=794737301918071&set=pb.100041454266467.-2207520000..&type=3.jpg'
  ];

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            toolbarHeight: 120,
            elevation: 0,
            actions: [
              PopupMenuButton(
                icon: Icon(Icons.more_vert, color: Colors.black),
                onSelected: (result) {
                  if (result == 0) {
                    Loader.show(context,
                        isAppbarOverlay: true,
                        overlayFromTop: 100,
                        progressIndicator: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: SpinKitWave(
                              color: Colors.pink,
                              size: 70.0,
                            )),
                            Text("Please Wait.....",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 12,
                                    color: Colors.black))
                          ],
                        ),
                        themeData: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.fromSwatch()
                                .copyWith(secondary: Colors.black38)),
                        overlayColor: Color(0x99E8EAF6));

                    FirebaseAuth.instance.signOut();

                    Future.delayed(Duration(seconds: 8), () {
                      Loader.hide();
                    });
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        Text('Sign Out'),
                        SizedBox(width: 5),
                        Icon(Icons.logout, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            title: Text("Hello, " + user.displayName! + "!",
                style: TextStyle(color: Colors.black))),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/bb.png'),
          )),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: 100,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(children: [
                    Text("Welcome to Alusoft!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Text(
                      "Your mail is" + " " + user.email!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ]),
                ),

                // CarouselSlider(
                //     items: [
                //       GestureDetector(
                //         onTap: () {},
                //         child: Container(
                //           margin: EdgeInsets.all(6.0),
                //           child: Column(
                //             children: [
                //               Image.asset(
                //                 'assets/images/mark.jfif',
                //                 height: 200,
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {},
                //         child: Container(
                //           margin: EdgeInsets.all(6.0),
                //           child: Column(
                //             children: [
                //               Image.asset(
                //                 'assets/images/alu.jfif',
                //                 height: 200,
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //       GestureDetector(
                //         onTap: () {
                //           Navigator.of(context).push(MaterialPageRoute(
                //               builder: (((context) => Nunu()))));
                //         },
                //         child: Container(
                //           margin: EdgeInsets.all(6.0),
                //           child: Column(
                //             children: [
                //               Image.asset(
                //                 'assets/images/future.jfif',
                //                 height: 200,
                //               )
                //             ],
                //           ),
                //         ),
                //       )
                //     ],
                //     options: CarouselOptions(
                //         height: 500.0,
                //         enlargeCenterPage: true,
                //         autoPlay: true,
                //         aspectRatio: 16 / 9,
                //         autoPlayCurve: Curves.fastOutSlowIn,
                //         enableInfiniteScroll: true,
                //         autoPlayAnimationDuration: Duration(milliseconds: 1000),
                //         viewportFraction: 0.8))
              ],
            ),
          ),
        ));
  }

  Widget buildImage(String urlImage, int index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.network(urlImage, fit: BoxFit.cover));

  Widget buildIndicator() => AnimatedSmoothIndicator(
      activeIndex: activeIndex, count: urlImages.length);
}
