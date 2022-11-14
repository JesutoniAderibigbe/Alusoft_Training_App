import 'dart:ui';

import 'package:alusoft_app/adminpages/admiEditPlans.dart';
import 'package:alusoft_app/backendfiles/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddPlans extends StatefulWidget {
  const AddPlans({Key? key}) : super(key: key);

  @override
  State<AddPlans> createState() => _AddPlansState();
}

class _AddPlansState extends State<AddPlans> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  //TextEditingController emailController = TextEditingController();

  TextEditingController duration = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

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
                      const SizedBox(
                        height: 70,
                      ),
                      Container(
                          child: TextFormField(
                        maxLength: 40,
                        controller: name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the plan name';
                          }
                          return null;
                        },
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
                      Container(
                          child: TextFormField(
                        maxLength: 60,
                        controller: description,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the plan description';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.always,
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
                      Container(
                          child: TextFormField(
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        maxLength: 25,
                        controller: price,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Price can\'t be null';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: '',
                            icon: Icon(EvaIcons.pricetags),
                            labelText: 'Price',
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
                      Container(
                          child: TextFormField(
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        controller: duration,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the duration';
                          }
                          return null;
                        },
                        maxLength: 2,
                        decoration: InputDecoration(
                            hintText: '',
                            labelText: 'Duration',
                            icon: Icon(Icons.access_time),
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
                                'price': price.text,
                                'duration': duration.text
                              };

                              var response = await getHttp('/save-plan', data);
                              print("response = ");
                              print(response);

                              if (response.statusCode == 200 &&
                                  form!.validate()) {
                                Loader.show(context,
                                    isAppbarOverlay: true,
                                    overlayFromTop: 100,
                                    progressIndicator: Center(
                                        child: SpinKitChasingDots(
                                      color: Colors.green,
                                      size: 70.0,
                                    )),
                                    themeData: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.fromSwatch()
                                            .copyWith(
                                                secondary: Colors.black38)),
                                    overlayColor: Color(0x99E8EAF6));

                                // showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       return Center(
                                //           child: CircularProgressIndicator());
                                //     });

                                Future.delayed(Duration(seconds: 8), () {
                                  final snackBar = SnackBar(
                                    duration:
                                        Duration(seconds: 1, milliseconds: 10),
                                    backgroundColor: Colors.green,
                                    content: const Text(
                                        'Plans added to the database'),
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

                                  Loader.hide();

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (((context) =>
                                              AdminPlans()))));
                                });
                              } else if (!form!.validate()) {
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

                              // ignore:
                              // avoid_print;
                              // insertMethod();
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
