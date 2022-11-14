import 'dart:convert';
import 'package:alusoft_app/backendfiles/planclass.dart';
import 'package:http/http.dart' as http;
import 'package:alusoft_app/backendfiles/dio.dart';
import 'package:alusoft_app/backendfiles/studentclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AdminStudent extends StatefulWidget {
  const AdminStudent({Key? key}) : super(key: key);

  @override
  State<AdminStudent> createState() => _AdminStudentState();
}

class _AdminStudentState extends State<AdminStudent> {
  String _response = 'No data yet';

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  Future<List<Students>> getStudentList() async {
    var response =
        await http.get(Uri.parse('http://192.168.10.4:6000/students'));
    //var response = await postHttp('/students');
    // print(response.data.toString());
    var JsonData = json.decode(response.body);
    print(JsonData);
    List<Students> items = [];

    for (var ma in JsonData) {
      Students m = Students(
        E_MAIL_ADDRESS: ma['E_MAIL_ADDRESS'],
        FIRST_NAME: ma['FIRST_NAME'],
        ID: ma['ID'],
        GENDER: ma['GENDER'],
        SURNAME: ma['SURNAME'],
        PLAN_NAME: ma['PLAN_NAME'],
      );

      items.add(m);
    }
    return items;
  }

  // Future<List<Plans>> getPlansList() async {
  //   var response = await http.get(Uri.parse('http://192.168.82.87:6000/plans'));

  //   var JsonData = json.decode(response.body);
  //   print(JsonData);
  //   List<Plans> items = [];

  //   for (var ma in JsonData) {
  //     Plans m = Plans(
  //       NAME: ma['NAME'],
  //       ID: ma['ID'],
  //       DESCRIPTION: ma['DESCRIPTION'],
  //       PRICE: ma['PRICE'],
  //       DURATION: ma['DURATION'],
  //     );

  //     items.add(m);
  //   }
  //   return items;
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      child: FutureBuilder(
          future: getStudentList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                      leading: Container(
                        padding: EdgeInsets.only(right: 20.0),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(width: 1.0, color: Colors.pink),
                          ),
                        ),
                        child: Icon(Icons.person),
                      ),
                      title: Row(
                        children: [
                          Text(snapshot.data[index].SURNAME,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 5),
                          Text(snapshot.data[index].FIRST_NAME,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      subtitle: Row(
                        children: [Text(snapshot.data[index].E_MAIL_ADDRESS)],
                      ),
                      trailing: InkWell(
                        onTap: () {},
                        child: Icon(Icons.keyboard_arrow_right,
                            size: 30.0, color: Colors.black),
                      ),
                    );
                  });
            }
          }),
    )
            //         body: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: FutureBuilder(
            //       future: getProductDataSource(),
            //       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //         return snapshot.hasData
            //             ? SfDataGrid(
            //                 allowPullToRefresh: true,
            //                 source: snapshot.data,
            //                 columns: getColumns(),
            //                 gridLinesVisibility: GridLinesVisibility.both,
            //                 headerGridLinesVisibility: GridLinesVisibility.both)
            //             : Center(
            //                 child: CircularProgressIndicator(),
            //               );
            //         // future: getProductDataSource(),
            //         // builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //         //   return snapshot.hasData
            //         //       ? SfDataGrid(source: snapshot.data, columns: getColumns())
            //         //       : Center(
            //         //           child: CircularProgressIndicator(
            //         //             strokeWidth: 3,
            //         //           ),
            //         //         );
            //         // },
            //       }),
            // )
            //     body: SingleChildScrollView(
            //   child: Center(
            //     child: Column(
            //       children: [
            //         ElevatedButton(
            //           onPressed: () async {
            //             var response = await postHttp('/students');
            //             print(response);
            //             _response = response.data.toString();
            //           },
            //           child: Text("Get Data"),
            //         ),
            //         Text(_response),
            //       ],
            //     ),
            //   ),
            // )),
            ));
  }

  Future<List<Students>> generateStudentList() async {
    var response =
        await http.get(Uri.parse('http://192.168.158.87:6000/students'));
    //var response = await postHttp('/students');
    // print(response.data.toString());
    print(response.body.toString());
    var decodedStudents =
        json.decode(response.body).cast<Map<String, dynamic>>();

    List<Students> studentList = await decodedStudents
        .map<Students>((json) => Students.fromJson(json))
        .toList();

    return studentList;
  }

  Future<StudentsDataGridSource> getProductDataSource() async {
    var studentList = await generateStudentList();
    return StudentsDataGridSource(studentList);
  }
}
