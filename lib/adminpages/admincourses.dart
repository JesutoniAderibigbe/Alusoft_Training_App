import 'dart:ui';

import 'package:alusoft_app/adminpages/courses.dart';

import 'package:alusoft_app/backendfiles/edit_courses.dart';
import 'package:alusoft_app/drawer/hidden_drawer.dart';
import 'package:flutter/material.dart';

class AdminCourses extends StatefulWidget {
  const AdminCourses({Key? key}) : super(key: key);

  @override
  State<AdminCourses> createState() => _AdminCoursesState();
}

class _AdminCoursesState extends State<AdminCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (((context) => HiddenDrawer()))));
            },
          ),
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
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bb.png'),
          )),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (((context) => Courses()))));
                      },
                      child: Text('Add Courses')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (((context) => EditCourse()))));
                      },
                      child: Text('Edit Courses')),
                ],
              ),
            ),
          ),
        ));
  }
}
