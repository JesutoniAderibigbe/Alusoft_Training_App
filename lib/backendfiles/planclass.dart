import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Plans {
  int ID;
  String NAME;
  String DESCRIPTION;
  int PRICE;
  int DURATION;

  Plans(
      {required this.ID,
      required this.NAME,
      required this.DESCRIPTION,
      required this.PRICE,
      required this.DURATION});

  // factory Plans.fromJson(Map<String, dynamic> json) {
  //   return Plans(
  //       ID: json['ID'],
  //       NAME: json['NAME'],
  //       DESCRIPTION: json['DESCRIPTION'],
  //       PRICE: json['PRICE'],
  //       DURATION: json['DURATION']);
  // }
}

// Future<List<Plans>> generatePlansList() async {
//   var response = await http.get(Uri.parse('http://192.168.70.87:6000/plans'));
//   var decodedPlans = json.decode(response.body).cast<Map<String, dynamic>>();
//   List<Plans> plansList =
//       await decodedPlans.map<Plans>((json) => Plans.fromJson(json)).toList();

//   return plansList;
// }

class PlansDataGridSource extends DataGridSource {
  PlansDataGridSource(this.plansList) {
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Plans> plansList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
      ),
    ]);
  }

  @override
  // TODO: implement rows
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = plansList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'ID', value: dataGridRow.ID),
        //  DataGridCell<String>(columnName: 'NAME', value: dataGridRow.NAME),
        //   DataGridCell<String>(
        //     columnName: 'DESCRIPTION', value: dataGridRow.DESCRIPTION),
        //   DataGridCell<int>(columnName: 'PRICE', value: dataGridRow.PRICE),
        // DataGridCell<int>(columnName: 'DURATION', value: dataGridRow.DURATION),
      ]);
    }).toList(growable: false);
  }
}

List<GridColumn> getColumns() {
  return <GridColumn>[
    GridColumn(
        columnName: 'ID',
        width: 70,
        label: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "ID",
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        )),
    GridColumn(
        columnName: 'NAME',
        width: 200,
        label: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "NAME",
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        )),
    GridColumn(
        columnName: 'DESCRIPTION',
        width: 200,
        label: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "DESCRIPTION",
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        )),
    GridColumn(
        columnName: 'PRICE',
        width: 70,
        label: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "PRICE",
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        )),
    GridColumn(
        columnName: 'DURATION',
        width: 100,
        label: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "DURATION",
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        )),
  ];
}

// Future<PlansDataGridSource> getPlansDataGridSource() async {
//   var plansList = await generatePlansList();
//   return PlansDataGridSource(plansList);
// }
