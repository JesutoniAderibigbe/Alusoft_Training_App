import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';

class ApiProvider {
  ApiProvider();

  Future<http.Response> doLogin(
      String email, String password, String path) async {
    String _url = 'http://192.168.231.87:6000$path';

    var body = {"email": email, "password": password};

    return http.post(
        Uri.parse(
          _url,
        ),
        body: body);
  }
}
