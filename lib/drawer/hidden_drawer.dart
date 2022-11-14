import 'package:alusoft_app/adminpages/AdminAddplans.dart';
import 'package:alusoft_app/adminpages/AdminInstructors.dart';
import 'package:alusoft_app/adminpages/admincalendar.dart';
import 'package:alusoft_app/adminpages/adminlogout.dart';
import 'package:alusoft_app/adminpages/admincourses.dart';
import 'package:alusoft_app/adminpages/adminsettings.dart';
import 'package:alusoft_app/adminpages/adminstudent.dart';
import 'package:alusoft_app/adminpages/admiEditPlans.dart';
import 'package:alusoft_app/adminpages/admindash.dart';
import 'package:alusoft_app/adminpages/adminstudent.dart';
import 'package:alusoft_app/adminpages/adminuser.dart';
import 'package:alusoft_app/adminpages/allcourses.dart';
import 'package:alusoft_app/adminpages/courses.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: "Dashboard",
            baseStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            selectedStyle: TextStyle(color: Colors.pink),
            colorLineSelected: Colors.black),
        Dashboard(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: "Courses",
            baseStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            selectedStyle: TextStyle(color: Colors.pink),
            colorLineSelected: Colors.black),
        AllCourses(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: "Students Database",
            baseStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            selectedStyle: TextStyle(color: Colors.pink)),
        AdminStudent(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: "Plans",
            baseStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            selectedStyle: TextStyle(color: Colors.pink)),
        AdminPlans(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: "Instructors",
            baseStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            selectedStyle: TextStyle(color: Colors.pink)),
        AdminInstructors(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: "Users",
            baseStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            selectedStyle: TextStyle(color: Colors.pink)),
        Users(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: "Settings",
            baseStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            selectedStyle: TextStyle(color: Colors.pink)),
        AdminSettings(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Log Out",
          baseStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          selectedStyle: TextStyle(color: Colors.pink),
        ),
        AdminLogOut(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      styleAutoTittleName: TextStyle(color: Colors.black),
      leadingAppBar: Icon(Icons.menu, color: Colors.black),

      screens: _pages,
      backgroundColorMenu: Colors.black,
      initPositionSelected: 0,
      slidePercent: 70,
      backgroundColorAppBar: Colors.white,
      actionsAppBar: [
        CircleAvatar(
            backgroundColor: Colors.transparent,
            minRadius: 30,
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/bb.png')),
            )),
      ],
      // tittleAppBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   toolbarHeight: 120,
      //   elevation: 0,
      // ),
    );
  }
}
