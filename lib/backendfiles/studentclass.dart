import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Students {
  int ID;
  String FIRST_NAME;
  String SURNAME;
  String GENDER;
  dynamic E_MAIL_ADDRESS;
  int PLAN_NAME;

  Students(
      {required this.ID,
      required this.FIRST_NAME,
      required this.SURNAME,
      required this.E_MAIL_ADDRESS,
      required this.GENDER,
      required this.PLAN_NAME});

  factory Students.fromJson(Map<String, dynamic> json) {
    return Students(
        ID: json['ID'],
        FIRST_NAME: json['FIRST_NAME'],
        SURNAME: json['SURNAME'],
        E_MAIL_ADDRESS: json['E_MAIL_ADDRESS'],
        GENDER: json['GENDER'],
        PLAN_NAME: json['PLAN_NAME']);
  }
}

class StudentsDataGridSource extends DataGridSource {
  StudentsDataGridSource(this.studentList) {
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Students> studentList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(color: Colors.pinkAccent, cells: [
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
      Container(
        child: Text(
          row.getCells()[5].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
      )
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = studentList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: "ID", value: dataGridRow.ID),
        // DataGridCell<String>(
        //     columnName: "FIRST_NAME", value: dataGridRow.FIRST_NAME),
        // DataGridCell<String>(columnName: "Surname", value: dataGridRow.SURNAME),
        // DataGridCell<String>(
        //     columnName: "E_mail_address", value: dataGridRow.GENDER),
        // DataGridCell<String>(
        //     columnName: "Gender", value: dataGridRow.E_MAIL_ADDRESS),
        // DataGridCell<int>(
        //     columnName: "plan_name", value: dataGridRow.PLAN_NAME),
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
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'ID',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        )),
    GridColumn(
        columnName: 'first_name',
        width: 100,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'first_name',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        )),
    GridColumn(
        columnName: 'surname',
        width: 100,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'surname',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        )),
    GridColumn(
        columnName: 'Gender',
        width: 100,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Gender',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        )),
    GridColumn(
        columnName: 'E_MAIL_ADDRESS',
        width: 200,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'E_MAIL_ADDRESS',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        )),
    GridColumn(
        columnName: 'PLAN_NAME',
        width: 70,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'PLAN_NAME',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ))
  ];
}
