import 'dart:ui';

import 'package:alusoft_app/backendfiles/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdminInstructors extends StatefulWidget {
  const AdminInstructors({Key? key}) : super(key: key);

  @override
  State<AdminInstructors> createState() => _AdminInstructorsState();
}

class _AdminInstructorsState extends State<AdminInstructors> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController surname = TextEditingController();
  //TextEditingController emailController = TextEditingController();

  TextEditingController firstname = TextEditingController();
  TextEditingController othernames = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController Date_Of_Birth = TextEditingController();
  TextEditingController Marital_Status = TextEditingController();
  TextEditingController Employment_Date = TextEditingController();

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
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
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

                      Form(
                          child: TextFormField(
                        maxLength: 25,
                        controller: surname,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: '',
                            labelText: 'Surname',
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
                        height: 20,
                      ),
                      Form(
                          child: TextFormField(
                        maxLength: 60,
                        controller: firstname,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: '',
                            icon: Icon(Icons.description),
                            labelText: 'First-Name',
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
                        height: 20,
                      ),
                      Form(
                          child: TextFormField(
                        controller: othernames,
                        maxLength: 20,
                        decoration: InputDecoration(
                            hintText: '',
                            labelText: 'Other-Names',
                            icon: Icon(Icons.perm_identity),
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
                        height: 20,
                      ),
                      Form(
                          child: TextFormField(
                        controller: gender,
                        maxLength: 20,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select either male or female';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Male/Female',
                            labelText: 'Gender',
                            icon: Icon(Icons.perm_identity),
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
                        height: 20,
                      ),
                      Form(
                          child: TextFormField(
                        controller: Date_Of_Birth,
                        maxLength: 20,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'for example; 2000-01-11';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'YYYY-MM-DD',
                            labelText: 'DateOfBirth',
                            icon: Icon(Icons.perm_identity),
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
                        height: 20,
                      ),
                      Form(
                          child: TextFormField(
                        controller: Marital_Status,
                        maxLength: 20,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select either single or married';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Single/Married',
                            labelText: 'Marital Status',
                            icon: Icon(Icons.perm_identity),
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
                        height: 20,
                      ),
                      Form(
                          child: TextFormField(
                        controller: Employment_Date,
                        maxLength: 20,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'for example; 2000-01-11';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'YYYY-MM-DD',
                            labelText: 'Employment Date',
                            icon: Icon(Icons.perm_identity),
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

                      SizedBox(
                        height: 20,
                      ),
                      // // textbutton,
                      Center(
                        child: TextButton(
                            onPressed: () async {
                              final form = _formKey.currentState;

                              var data = {
                                'surname': surname.text,
                                'first_Name': firstname.text,
                                'other-Names': othernames.text,
                                'gender': gender.text,
                                'DateofBirth': Date_Of_Birth.text,
                                'MaritalStatus': Marital_Status.text,
                                'EmploymentDate': Employment_Date.text
                              };
                              var response =
                                  await getHttp('/save-instructors', data);
                              print("response = ${response.statusCode} ");
                              print(response.statusCode);

                              if (response.statusCode == 200 &&
                                  form!.validate()) {
                                final snackBar = SnackBar(
                                  content: const Text(
                                      'Instructors added to the database'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                Loader.show(context,
                                    isAppbarOverlay: true,
                                    overlayFromTop: 100,
                                    progressIndicator: Center(
                                        child: SpinKitFadingCircle(
                                      color: Colors.red,
                                      size: 70.0,
                                    )),
                                    themeData: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.fromSwatch()
                                            .copyWith(
                                                secondary: Colors.black38)),
                                    overlayColor: Color(0x99E8EAF6));

                                final snackBar = SnackBar(
                                  duration: Duration(seconds: 14),
                                  backgroundColor: Colors.red,
                                  content: const Text(
                                      'Fill all details to continue.Server Error 404'),
                                  action: SnackBarAction(
                                    textColor: Colors.black,
                                    label: 'Undo',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                Future.delayed(Duration(seconds: 15), () {
                                  Loader.hide();
                                });
                              }

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
