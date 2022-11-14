import 'dart:convert';

import 'package:alusoft_app/backendfiles/studentclass.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AdminClass extends ChangeNotifier {
  Future getData(BuildContext context) async {
    var response =
        await http.get(Uri.parse('http://192.168.196.87:6000/students'));
    print(response.body);
    var mJson = json.decode(response.body);
  }
}

// var decodedStudents = json.decode(response.body).cast<Map<String, dynamic>>();
