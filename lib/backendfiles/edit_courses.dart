import 'dart:ui';

import 'package:alusoft_app/adminpages/admincourses.dart';
import 'package:flutter/material.dart';

class EditCourse extends StatefulWidget {
  const EditCourse({Key? key}) : super(key: key);

  @override
  State<EditCourse> createState() => _CoursesState();
}

class _CoursesState extends State<EditCourse> {
  TextEditingController name = TextEditingController();
  //TextEditingController emailController = TextEditingController();

  TextEditingController duration = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController instructorId = TextEditingController();
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
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          elevation: 0,
          title: Text("Edit Course", style: TextStyle(color: Colors.black)),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.pink,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (((context) => AdminCourses()))));
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
                    const SizedBox(
                      height: 70,
                    ),
                    Form(
                        child: TextFormField(
                      maxLength: 25,
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
                      maxLength: 60,
                      controller: description,
                      decoration: InputDecoration(
                          hintText: '',
                          icon: Icon(Icons.description),
                          labelText: 'Description',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.teal)),
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
                              borderSide: const BorderSide(color: Colors.teal)),
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
                      controller: instructorId,
                      maxLength: 2,
                      decoration: InputDecoration(
                          hintText: '',
                          labelText: 'Instructor_Id',
                          icon: Icon(Icons.perm_identity),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.teal)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Colors.purple))),
                    )),
                    SizedBox(
                      height: 60,
                    ),
                    // // textbutton,
                    Center(
                      child: TextButton(
                          onPressed: () async {
                            final snackBar = SnackBar(
                              content: const Text('Course edited'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

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
    );
  }
}
