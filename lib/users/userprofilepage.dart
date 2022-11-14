import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 100,
          title: Image.asset(
            'assets/images/bb.png',
            height: 50,
          ),
          centerTitle: true,
          leading: Icon(
            Icons.search,
            color: Colors.black,
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(radius: 20),
              title: Text(
                "Welcome",
                style: TextStyle(color: Colors.grey),
              ),
              subtitle: Text(
                "Mr.Aderibigbe Jesutoni",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black),
              ),
              trailing: Icon(LineAwesomeIcons.door_open),
            ),
          ),
          Divider(),
          SizedBox(height: 30),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.book),
                    SizedBox(width: 5),
                    Text("Course"),
                    SizedBox(width: 40),
                    Icon(Icons.arrow_forward)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
