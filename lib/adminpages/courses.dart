import 'dart:convert';
import 'dart:ui';

import 'package:alusoft_app/adminpages/admincourses.dart';
import 'package:alusoft_app/adminpages/allcourses.dart';
import 'package:alusoft_app/backendfiles/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  dynamic selectedValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  //TextEditingController emailController = TextEditingController();

  TextEditingController duration = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController instructorId = TextEditingController();

  List categoryItemList = <List>[];

  getAllInstructors() async {
    var response =
        await http.get(Uri.parse('http://192.168.240.87:6000/instructors'));
    print(response.body);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemList = jsonData;
      });
      print(categoryItemList);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllInstructors();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          FocusManager.instance.primaryFocus!.unfocus();
        });
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.cancel,
                color: Colors.black,
              )),
          title: Text(
            "Add Courses",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: getAllInstructors,
        //   child: Icon(Icons.add),
        // ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/bb.png'),
          )
              // color: Colors.transparent,
              // image: DecorationImage(
              //     colorFilter: ColorFilter.mode(
              //         Colors.white.withOpacity(0.4), BlendMode.dstATop),
              //     image: AssetImage(
              //       'assets/images/bg6.png',
              //     ),
              //     opacity: 0.6,
              //     fit: BoxFit.cover),
              ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Container(
                      //   width: 350,
                      //   decoration: BoxDecoration(
                      //     // image: DecorationImage(
                      //     //     image: AssetImage('assets/images/bg.png'),
                      //     //     colorFilter: ColorFilter.mode(
                      //     //         Colors.white.withOpacity(0.9), BlendMode.dstATop),
                      //     //     fit: BoxFit.cover),
                      //     borderRadius: BorderRadius.circular(22),
                      //     color: Colors.teal,
                      //   ),
                      //   child: Center(
                      //     child: Text(
                      //       'Plan DB',
                      //       style: TextStyle(color: Colors.white, fontSize: 33),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 70,
                      ),
                      Form(
                          child: TextFormField(
                        maxLength: 40,
                        controller: name,
                        decoration: InputDecoration(
                            hintText: '',
                            labelText: 'Name',
                            icon: Icon(Icons.library_books),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.purple))),
                      )),
                      const SizedBox(
                        height: 50,
                      ),
                      Form(
                          child: TextFormField(
                        maxLength: 120,
                        controller: description,
                        decoration: InputDecoration(
                            hintText: '',
                            icon: Icon(Icons.description),
                            labelText: 'Description',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.teal)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.purple))),
                      )),
                      const SizedBox(
                        height: 50,
                      ),
                      Form(
                          child: TextFormField(
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        maxLength: 25,
                        controller: duration,
                        decoration: InputDecoration(
                            hintText: '',
                            icon: Icon(Icons.access_time),
                            labelText: 'Duration',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.teal)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.purple))),
                      )),

                      const SizedBox(
                        height: 50,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormField(
                          builder: (FormFieldState state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                icon: Icon(Icons.person_rounded),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                                labelText: 'Instructor',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0)),
                              ),
                              child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text("Select Instructors"),
                                  value: selectedValue,
                                  items: categoryItemList.map((category) {
                                    return DropdownMenuItem(
                                        value: category['ID'],
                                        child: Row(
                                          children: [
                                            Text("ID: ${category['ID']} "),
                                            Text(category['FIRST_NAME'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10)),
                                            Text("  "),
                                            Text(
                                              category['SURNAME'],
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ));
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  }),
                            );
                          },
                        ),
                      ),

                      SizedBox(
                        height: 60,
                      ),
                      // // textbutton,
                      Center(
                        child: TextButton(
                            onPressed: () async {
                              final form = _formKey.currentState;

                              var data = {
                                'name': name.text,
                                'description': description.text,
                                'duration': duration.text,
                                'instructor_id': selectedValue
                              };

                              var response =
                                  await getHttp('/save-course', data);
                              print("response = ");
                              print(response);

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              // //         builder: ((context) => SignUp())));
                              // var data = {
                              //   'name': name.text,
                              //   'description': description.text,
                              //   'price': price.text,
                              //   'duration': duration.text
                              // };
                              // var response = await getHttp('/save-plan', data);
                              // print("response = ");
                              // print(response);
                              // ignore:
                              // avoid_print;
                              //insertMethod();
                            },
                            child: Container(
                                width: 350,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.pinkAccent),
                                // color: Colors.purple,

                                child: Center(
                                  child: const Text(
                                    'NEXT',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
