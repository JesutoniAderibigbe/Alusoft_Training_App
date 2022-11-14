import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:alusoft_app/adminpages/courses.dart';
import 'package:alusoft_app/backendfiles/courseclass.dart';
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

class AllCourses extends StatefulWidget {
  const AllCourses({Key? key}) : super(key: key);

  @override
  State<AllCourses> createState() => _CourseState();
}

class _CourseState extends State<AllCourses> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  //TextEditingController emailController = TextEditingController();
  TextEditingController id = TextEditingController();

  TextEditingController duration = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  num top = 1000;
  num left = 1000;

  Future<List<Course>> getCourseList() async {
    var response =
        await http.get(Uri.parse('http://192.168.10.3:6000/courses'));

    var JsonData = json.decode(response.body);
    print(JsonData);
    List<Course> items = [];

    for (var ma in JsonData) {
      Course m = Course(
          ID: ma['ID'],
          NAME: ma['NAME'],
          DESCRIPTION: ma['DESCRIPTION'],
          DURATION: ma['DURATION'],
          INSTRUCTOR_ID: ma['INSTRUCTOR_ID']);
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
                      content: Courses(),
                    ),
                  );
                }),
            body: Container(
              child: FutureBuilder(
                  future: getCourseList(),
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
                                  Text(
                                    snapshot.data[index].DURATION.toString() +
                                        "  weeks",
                                    style: TextStyle(fontSize: 18),
                                  )
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
                                    builder: (_) => AlertDialog(
                                        content: Text(snapshot
                                                .data[index].NAME +
                                            "is a " +
                                            snapshot.data[index].DESCRIPTION +
                                            ". It is taught by" +
                                            snapshot.data[index].INSTRUCTOR_ID
                                                .toString())));
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

  Future makePdf() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(child: pw.Text("Hello World"));
    }));
    return [''];
  }
}
