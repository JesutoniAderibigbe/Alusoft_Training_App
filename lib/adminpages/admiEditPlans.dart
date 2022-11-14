import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:alusoft_app/adminpages/AdminAddplans.dart';
import 'package:alusoft_app/backendfiles/dio.dart';
import 'package:alusoft_app/backendfiles/planclass.dart';
import 'package:alusoft_app/drawer/hidden_drawer.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;

class AdminPlans extends StatefulWidget {
  const AdminPlans({Key? key}) : super(key: key);

  @override
  State<AdminPlans> createState() => _CourseState();
}

class _CourseState extends State<AdminPlans> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  //TextEditingController emailController = TextEditingController();
  TextEditingController id = TextEditingController();

  TextEditingController duration = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  num top = 1000;
  num left = 1000;

  Future<List<Plans>> getPlansList() async {
    var response = await http.get(Uri.parse('http://192.168.10.4:3000/plans'));

    var JsonData = json.decode(response.body);
    print(JsonData);
    List<Plans> items = [];

    for (var ma in JsonData) {
      Plans m = Plans(
        NAME: ma['NAME'],
        ID: ma['ID'],
        DESCRIPTION: ma['DESCRIPTION'],
        PRICE: ma['PRICE'],
        DURATION: ma['DURATION'],
      );

      items.add(m);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.pink,
                child: Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      content: Builder(builder: (context) {
                        var height = MediaQuery.of(context).size.height;
                        var width = MediaQuery.of(context).size.width;
                        return Stack(children: [
                          Container(
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 70,
                                      ),
                                      Container(
                                          child: TextFormField(
                                        //  initialValue: "Robotics",
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
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors.purple))),
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
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        decoration: InputDecoration(
                                            hintText: '',
                                            icon: Icon(Icons.description),
                                            labelText: 'Description',
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors.teal)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors.purple))),
                                      )),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Container(
                                          child: TextFormField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(
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
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors.teal)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors.purple))),
                                      )),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Container(
                                          child: TextFormField(
                                        keyboardType:
                                            TextInputType.numberWithOptions(
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
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors.teal)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors.purple))),
                                      )),
                                      SizedBox(
                                        height: 60,
                                      ),
                                      // // textbutton,
                                      Center(
                                        child: TextButton(
                                            onPressed: () async {
                                              final form =
                                                  _formKey.currentState;

                                              var data = {
                                                'name': name.text,
                                                'description': description.text,
                                                'price': price.text,
                                                'duration': duration.text
                                              };

                                              var response = await getHttp(
                                                  '/save-plan', data);
                                              print("response = ");
                                              print(response);

                                              if (response.statusCode == 200 &&
                                                  form!.validate()) {
                                                Loader.show(context,
                                                    isAppbarOverlay: true,
                                                    overlayFromTop: 100,
                                                    progressIndicator: Center(
                                                        child:
                                                            SpinKitChasingDots(
                                                      color: Colors.green,
                                                      size: 70.0,
                                                    )),
                                                    themeData: Theme.of(context).copyWith(
                                                        colorScheme: ColorScheme
                                                                .fromSwatch()
                                                            .copyWith(
                                                                secondary: Colors
                                                                    .black38)),
                                                    overlayColor:
                                                        Color(0x99E8EAF6));

                                                Future.delayed(
                                                    Duration(seconds: 8), () {
                                                  final snackBar = SnackBar(
                                                    duration: Duration(
                                                        seconds: 1,
                                                        milliseconds: 10),
                                                    backgroundColor:
                                                        Colors.green,
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

                                                  Navigator.pop(context);
                                                });
                                              } else if (!form!.validate()) {
                                                Loader.show(context,
                                                    isAppbarOverlay: true,
                                                    overlayFromTop: 100,
                                                    progressIndicator: Center(
                                                        child:
                                                            SpinKitFadingCircle(
                                                      color: Colors.red,
                                                      size: 70.0,
                                                    )),
                                                    themeData: Theme.of(context).copyWith(
                                                        colorScheme: ColorScheme
                                                                .fromSwatch()
                                                            .copyWith(
                                                                secondary: Colors
                                                                    .black38)),
                                                    overlayColor:
                                                        Color(0x99E8EAF6));

                                                final snackBar = SnackBar(
                                                  duration:
                                                      Duration(seconds: 14),
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

                                                Future.delayed(
                                                    Duration(seconds: 15), () {
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.pinkAccent),
                                                // color: Colors.purple,

                                                child: Center(
                                                  child: const Text(
                                                    'NEXT',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.cancel)))
                        ]);
                      }),

                      // actions: [
                      //   TextButton(
                      //     onPressed: () => Navigator.pop(context, 'Cancel'),
                      //     child: const Text('Cancel'),
                      //   ),
                      //   TextButton(
                      //       onPressed: () {
                      //         FirebaseAuth.instance.signOut();
                      //         Navigator.pop(context);
                      //       },
                      //       child: const Text('OK')),
                      // ],
                    ),
                  );
                }),
            body: Container(
              child: FutureBuilder(
                  future: getPlansList(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("Loading...."),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              title: Text(snapshot.data[index].NAME,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              leading: Container(
                                padding: EdgeInsets.only(right: 20.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                        width: 1.0, color: Colors.pink),
                                  ),
                                ),
                                child: Icon(MdiIcons.floorPlan),
                              ),
                              subtitle: Row(
                                children: [
                                  Icon(Icons.price_change_outlined),
                                  Text("#" +
                                      snapshot.data[index].PRICE.toString())
                                ],
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                size: 30.0,
                                color: Colors.black,
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          elevation: 0,
                                          // title: const Text('You sure of this?'),
                                          title:
                                              Text(snapshot.data[index].NAME),
                                          content: GestureDetector(
                                            onPanUpdate: (details) {
                                              top = max(
                                                  0, top + details.delta.dy);
                                              left = max(
                                                  0, left + details.delta.dx);
                                              setState(() {
                                                print("Hold");
                                              });
                                            },
                                            child: Stack(children: [
                                              Text("The Plan," " " +
                                                  snapshot.data[index].NAME +
                                                  " " +
                                                  "is a " +
                                                  snapshot
                                                      .data[index].DESCRIPTION +
                                                  " " +
                                                  "with a price of #" +
                                                  snapshot.data[index].PRICE
                                                      .toString() +
                                                  "." +
                                                  "It runs for " +
                                                  snapshot.data[index].DURATION
                                                      .toString() +
                                                  "weeks"),
                                              // Positioned(
                                              //     left: 20,
                                              //     right: 20,
                                              //     top: 20,
                                              //     bottom: 20,
                                              //     child: CircleAvatar(
                                              //       radius: 20,
                                              //       child: ClipRRect(
                                              //         borderRadius:
                                              //             BorderRadius.all(
                                              //                 Radius.zero),
                                              //         child: Image.asset(
                                              //             'assets/images/bb.png'),
                                              //       ),
                                              //     )),

                                              Positioned.fill(
                                                  child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: GestureDetector(
                                                          behavior:
                                                              HitTestBehavior
                                                                  .deferToChild,
                                                          excludeFromSemantics:
                                                              true,
                                                          onTap: () {
                                                            //updatePlans();
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          "Update Plans"),
                                                                      content:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Container(
                                                                                child: TextFormField(
                                                                              // initialValue: snapshot.data[index].NAME,
                                                                              maxLength: 40,
                                                                              controller: id,
                                                                              validator: (value) {
                                                                                if (value == null || value.isEmpty) {
                                                                                  return 'Please enter the plan name';
                                                                                }
                                                                                return null;
                                                                              },
                                                                              decoration: InputDecoration(hintText: '', labelText: 'ID', icon: Icon(Icons.library_books), floatingLabelBehavior: FloatingLabelBehavior.always, border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.white)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.purple))),
                                                                            )),

                                                                            Container(
                                                                                child: TextFormField(
                                                                              // initialValue: snapshot.data[index].NAME,
                                                                              maxLength: 40,
                                                                              controller: name,
                                                                              validator: (value) {
                                                                                if (value == null || value.isEmpty) {
                                                                                  return 'Please enter the plan name';
                                                                                }
                                                                                return null;
                                                                              },
                                                                              decoration: InputDecoration(hintText: '', labelText: 'Name', icon: Icon(Icons.library_books), floatingLabelBehavior: FloatingLabelBehavior.always, border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.white)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.purple))),
                                                                            )),
                                                                            const SizedBox(
                                                                              height: 50,
                                                                            ),
                                                                            Container(
                                                                                child: TextFormField(
                                                                              maxLength: 60,
                                                                              // initialValue: snapshot.data[index].DESCRIPTION,
                                                                              controller: description,
                                                                              validator: (value) {
                                                                                if (value == null || value.isEmpty) {
                                                                                  return 'Please enter the plan description';
                                                                                }
                                                                                return null;
                                                                              },
                                                                              autovalidateMode: AutovalidateMode.always,
                                                                              decoration: InputDecoration(hintText: '', icon: Icon(Icons.description), labelText: 'Description', floatingLabelBehavior: FloatingLabelBehavior.always, border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.teal)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.purple))),
                                                                            )),
                                                                            const SizedBox(
                                                                              height: 50,
                                                                            ),
                                                                            Container(
                                                                                child: TextFormField(
                                                                              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                                              maxLength: 25,
                                                                              // initialValue: snapshot.data[index].PRICE.toString(),
                                                                              controller: price,
                                                                              validator: (value) {
                                                                                if (value == null || value.isEmpty) {
                                                                                  return 'Price can\'t be null';
                                                                                }
                                                                                return null;
                                                                              },
                                                                              decoration: InputDecoration(hintText: '', icon: Icon(EvaIcons.pricetags), labelText: 'Price', floatingLabelBehavior: FloatingLabelBehavior.always, border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.teal)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.purple))),
                                                                            )),
                                                                            const SizedBox(
                                                                              height: 50,
                                                                            ),
                                                                            Container(
                                                                                child: TextFormField(
                                                                              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                                                              controller: duration,
                                                                              // initialValue: snapshot.data[index].DURATION.toString(),
                                                                              validator: (value) {
                                                                                if (value == null || value.isEmpty) {
                                                                                  return 'Please enter the duration';
                                                                                }
                                                                                return null;
                                                                              },
                                                                              maxLength: 2,
                                                                              decoration: InputDecoration(hintText: '', labelText: 'Duration', icon: Icon(Icons.access_time), floatingLabelBehavior: FloatingLabelBehavior.always, border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.teal)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.purple))),
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
                                                                                      'duration': duration.text,
                                                                                      'id': id.text,
                                                                                    };

                                                                                    var response = await getHttp('/plan/:id/update', data);
                                                                                    print("response = ");
                                                                                    print(response);

                                                                                    if (response.statusCode == 200 && form!.validate()) {
                                                                                      Loader.show(context,
                                                                                          isAppbarOverlay: true,
                                                                                          overlayFromTop: 100,
                                                                                          progressIndicator: Center(
                                                                                              child: SpinKitChasingDots(
                                                                                            color: Colors.green,
                                                                                            size: 70.0,
                                                                                          )),
                                                                                          themeData: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
                                                                                          overlayColor: Color(0x99E8EAF6));

                                                                                      // showDialog(
                                                                                      //     context: context,
                                                                                      //     builder: (context) {
                                                                                      //       return Center(
                                                                                      //           child: CircularProgressIndicator());
                                                                                      //     });

                                                                                      Future.delayed(Duration(seconds: 8), () {
                                                                                        final snackBar = SnackBar(
                                                                                          duration: Duration(seconds: 1, milliseconds: 10),
                                                                                          backgroundColor: Colors.green,
                                                                                          content: const Text('Plans added to the database'),
                                                                                          action: SnackBarAction(
                                                                                            textColor: Colors.black,
                                                                                            label: 'Undo',
                                                                                            onPressed: () {
                                                                                              // Some code to undo the change.
                                                                                            },
                                                                                          ),
                                                                                        );
                                                                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                                                        makePdf();

                                                                                        Loader.hide();

                                                                                        Navigator.pop(context);
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
                                                                                          themeData: Theme.of(context).copyWith(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black38)),
                                                                                          overlayColor: Color(0x99E8EAF6));

                                                                                      final snackBar = SnackBar(
                                                                                        duration: Duration(seconds: 14),
                                                                                        backgroundColor: Colors.red,
                                                                                        content: const Text('Fill all details to continue.Server Error 404'),
                                                                                        action: SnackBarAction(
                                                                                          textColor: Colors.black,
                                                                                          label: 'Undo',
                                                                                          onPressed: () {
                                                                                            // Some code to undo the change.
                                                                                          },
                                                                                        ),
                                                                                      );
                                                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

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
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.pinkAccent),
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
                                                                    ));

                                                            print(
                                                                "Plans clicked");
                                                            // var response = postHttp(
                                                            //     '/plan/:id/update');
                                                            // print(response);
                                                            // print(
                                                            //     "Button Tapped");
                                                          },
                                                          child: Icon(MdiIcons
                                                              .pencil))))
                                            ]),
                                          )
                                          // actions: [
                                          //   TextButton(
                                          //     onPressed: () =>
                                          //         Navigator.pop(context, 'Cancel'),
                                          //     child: const Text('Cancel'),
                                          //   ),
                                          //   TextButton(
                                          //       onPressed: () {
                                          //         FirebaseAuth.instance.signOut();
                                          //         Navigator.pop(context);
                                          //       },
                                          //       child: const Text('OK')),
                                          // ],
                                          ),
                                );
                              },
                              // subtitle: Text(snapshot.data[index].ID),
                            );
                          });
                    }
                  }),
            )

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: FutureBuilder<List<User>>(
            //       future: getPlans,
            //       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //         return snapshot.hasData
            //             ? SfDataGrid(
            //                 allowPullToRefresh: true,
            //                 source: snapshot.data,
            //                 allowColumnsResizing: true,

            //                 // onCellTap: (DataGridCellTapDetails details){
            //                 //   showDialog(
            //                 //     context: context,
            //                 //     builder: (BuildContext context) => AlertDialog(
            //                 //       title: Text("Tapped Content"),
            //                 //       actions: [
            //                 //         TextButton(
            //                 //           onPressed: ()=> Navigator.pop(context),
            //                 //           child: Text('OK'))
            //                 //       ],
            //                 //       content: Text(PlansDataGridSource.effectiveRows[details.rowColumnIndex.rowIndex -1]
            //                 //       .get),
            //                 //     ))
            //                 // },
            //                 columns: getColumns())
            //             : Center(
            //                 child: CircularProgressIndicator(),
            //               );
            //       }),
            // ),
            ));
  }

  updatePlans() {
    return Container(
      child: FutureBuilder(
          future: getPlansList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data == null) {
              return Text("Loading");
            } else {
              return ListView(
                children: [Text("HI")],
              );

              // return AlertDialog(
              //   title: Text("Update Plans"),
              //   content: SingleChildScrollView(
              //     child: Column(
              //       children: [
              //         Container(
              //             child: TextFormField(
              //           initialValue: snapshot.data,
              //           maxLength: 40,
              //           //controller: name,
              //           validator: (value) {
              //             if (value == null || value.isEmpty) {
              //               return 'Please enter the plan name';
              //             }
              //             return null;
              //           },
              //           decoration: InputDecoration(
              //               hintText: '',
              //               labelText: 'Name',
              //               icon: Icon(Icons.library_books),
              //               floatingLabelBehavior: FloatingLabelBehavior.always,
              //               border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(20),
              //                   borderSide:
              //                       const BorderSide(color: Colors.white)),
              //               focusedBorder: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(20),
              //                   borderSide:
              //                       const BorderSide(color: Colors.purple))),
              //         )),
              //         const SizedBox(
              //           height: 50,
              //         ),
              //         Container(
              //             child: TextFormField(
              //           maxLength: 60,
              //           controller: description,
              //           validator: (value) {
              //             if (value == null || value.isEmpty) {
              //               return 'Please enter the plan description';
              //             }
              //             return null;
              //           },
              //           autovalidateMode: AutovalidateMode.always,
              //           decoration: InputDecoration(
              //               hintText: '',
              //               icon: Icon(Icons.description),
              //               labelText: 'Description',
              //               floatingLabelBehavior: FloatingLabelBehavior.always,
              //               border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(20),
              //                   borderSide:
              //                       const BorderSide(color: Colors.teal)),
              //               focusedBorder: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(20),
              //                   borderSide:
              //                       const BorderSide(color: Colors.purple))),
              //         )),
              //         const SizedBox(
              //           height: 50,
              //         ),
              //         Container(
              //             child: TextFormField(
              //           keyboardType: TextInputType.numberWithOptions(
              //               signed: true, decimal: true),
              //           maxLength: 25,
              //           controller: price,
              //           validator: (value) {
              //             if (value == null || value.isEmpty) {
              //               return 'Price can\'t be null';
              //             }
              //             return null;
              //           },
              //           decoration: InputDecoration(
              //               hintText: '',
              //               icon: Icon(EvaIcons.pricetags),
              //               labelText: 'Price',
              //               floatingLabelBehavior: FloatingLabelBehavior.always,
              //               border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(20),
              //                   borderSide:
              //                       const BorderSide(color: Colors.teal)),
              //               focusedBorder: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(20),
              //                   borderSide:
              //                       const BorderSide(color: Colors.purple))),
              //         )),
              //         const SizedBox(
              //           height: 50,
              //         ),
              //         Container(
              //             child: TextFormField(
              //           keyboardType: TextInputType.numberWithOptions(
              //               signed: true, decimal: true),
              //           controller: duration,
              //           validator: (value) {
              //             if (value == null || value.isEmpty) {
              //               return 'Please enter the duration';
              //             }
              //             return null;
              //           },
              //           maxLength: 2,
              //           decoration: InputDecoration(
              //               hintText: '',
              //               labelText: 'Duration',
              //               icon: Icon(Icons.access_time),
              //               floatingLabelBehavior: FloatingLabelBehavior.always,
              //               border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(20),
              //                   borderSide:
              //                       const BorderSide(color: Colors.teal)),
              //               focusedBorder: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(20),
              //                   borderSide:
              //                       const BorderSide(color: Colors.purple))),
              //         )),
              //         SizedBox(
              //           height: 60,
              //         ),
              //         // // textbutton,
              //         Center(
              //           child: TextButton(
              //               onPressed: () async {
              //                 final form = _formKey.currentState;

              //                 var data = {
              //                   'name': name.text,
              //                   'description': description.text,
              //                   'price': price.text,
              //                   'duration': duration.text
              //                 };

              //                 var response = await getHttp('/save-plan', data);
              //                 print("response = ");
              //                 print(response);

              //                 if (response.statusCode == 200 &&
              //                     form!.validate()) {
              //                   Loader.show(context,
              //                       isAppbarOverlay: true,
              //                       overlayFromTop: 100,
              //                       progressIndicator: Center(
              //                           child: SpinKitChasingDots(
              //                         color: Colors.green,
              //                         size: 70.0,
              //                       )),
              //                       themeData: Theme.of(context).copyWith(
              //                           colorScheme: ColorScheme.fromSwatch()
              //                               .copyWith(
              //                                   secondary: Colors.black38)),
              //                       overlayColor: Color(0x99E8EAF6));

              //                   // showDialog(
              //                   //     context: context,
              //                   //     builder: (context) {
              //                   //       return Center(
              //                   //           child: CircularProgressIndicator());
              //                   //     });

              //                   Future.delayed(Duration(seconds: 8), () {
              //                     final snackBar = SnackBar(
              //                       duration:
              //                           Duration(seconds: 1, milliseconds: 10),
              //                       backgroundColor: Colors.green,
              //                       content: const Text(
              //                           'Plans added to the database'),
              //                       action: SnackBarAction(
              //                         textColor: Colors.black,
              //                         label: 'Undo',
              //                         onPressed: () {
              //                           // Some code to undo the change.
              //                         },
              //                       ),
              //                     );
              //                     ScaffoldMessenger.of(context)
              //                         .showSnackBar(snackBar);

              //                     Loader.hide();

              //                     Navigator.pop(context);
              //                   });
              //                 } else if (!form!.validate()) {
              //                   Loader.show(context,
              //                       isAppbarOverlay: true,
              //                       overlayFromTop: 100,
              //                       progressIndicator: Center(
              //                           child: SpinKitFadingCircle(
              //                         color: Colors.red,
              //                         size: 70.0,
              //                       )),
              //                       themeData: Theme.of(context).copyWith(
              //                           colorScheme: ColorScheme.fromSwatch()
              //                               .copyWith(
              //                                   secondary: Colors.black38)),
              //                       overlayColor: Color(0x99E8EAF6));

              //                   final snackBar = SnackBar(
              //                     duration: Duration(seconds: 14),
              //                     backgroundColor: Colors.red,
              //                     content: const Text(
              //                         'Fill all details to continue.Server Error 404'),
              //                     action: SnackBarAction(
              //                       textColor: Colors.black,
              //                       label: 'Undo',
              //                       onPressed: () {
              //                         // Some code to undo the change.
              //                       },
              //                     ),
              //                   );
              //                   ScaffoldMessenger.of(context)
              //                       .showSnackBar(snackBar);

              //                   Future.delayed(Duration(seconds: 15), () {
              //                     Loader.hide();
              //                   });
              //                 }

              //                 // Navigator.push(
              //                 //     context,
              //                 //     MaterialPageRoute(
              //                 // //         builder: ((context) => SignUp())));

              //                 // ignore:
              //                 // avoid_print;
              //                 // insertMethod();
              //               },
              //               child: Container(
              //                   width: 350,
              //                   height: 40,
              //                   decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(12),
              //                       color: Colors.pinkAccent),
              //                   // color: Colors.purple,

              //                   child: Center(
              //                     child: const Text(
              //                       'NEXT',
              //                       style: TextStyle(color: Colors.white),
              //                     ),
              //                   ))),
              //         ),
              //       ],
              //     ),
              //   ),
              // );
            }
          }),
    );
  }

  Future makePdf() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(child: pw.Text("Hello World"));
    }));
    return [''];
  }
}
