import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/editable_text.dart';

Future<Response> getHttp(String path, Map<String, dynamic> data) async {
  try {
    var endpoint = 'http://192.168.10.4:3000$path';
    print("Dio test Sending GET request to $endpoint");
    return await Dio().get(endpoint, queryParameters: data);
  } catch (e) {
    print("Dio test $e");
    return Future.error(e);
  }
}

Future<Response> postHttp(String path, int data) async {
  try {
    var endpoint = 'http://192.168.10.4:3000$path';

    print("Dio test Sending GET request to $endpoint");
    return await Dio().get(
      endpoint,
    );
  } catch (e) {
    print("Dio test $e");
    return Future.error(e);
  }
}

Future<Response> deleteHttp(String path, Map<String, dynamic> data) async {
  try {
    var endpoint = 'http://192.168.163.87:3000$path';
    print("Dio test Sending GET request to $endpoint");
    return await Dio().delete(endpoint, queryParameters: data);
  } catch (e) {
    print("Dio test $e");
    return Future.error(e);
  }
}

Future<Response> deleteStudent({required String id}) async {
  try {
    return await Dio().delete('http://192.168.163.87:3000/student/:id/delete');
    print('Student Deleted');
  } catch (e) {
    print("Error");
    return Future.error(e);
  }
}
