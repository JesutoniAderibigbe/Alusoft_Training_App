import 'package:alusoft_app/users/adminwelcome.dart';
import 'package:alusoft_app/users/explorepage.dart';
import 'package:alusoft_app/users/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

final _kPages = {
  'home': Icons.home,
  'explore': Icons.explore,
  'Profile': Icons.person
};

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  TabStyle _tabStyle = TabStyle.fixedCircle;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          extendBody: true,
          body: Column(
            children: [
              Expanded(
                  child: TabBarView(children: [
                UserWelcomePage(),
                ExplorePage(),
                UserProfilePage()
              ]))
            ],
          ),
          bottomNavigationBar: ConvexAppBar.badge(
            const <int, dynamic>{3: '99+'},
            backgroundColor: Colors.pink,
            items: <TabItem>[
              for (final entry in _kPages.entries)
                TabItem(icon: entry.value, title: entry.key),
            ],
            onTap: (int i) => print('click index = $i'),
          ),
        ));
  }
}
