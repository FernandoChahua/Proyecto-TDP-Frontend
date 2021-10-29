import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:logger/logger.dart';

class LoginProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> getSession(String username, String password) async {
    final _dio = Dio();
    final Response response;

    _dio.options.headers = {
      HttpHeaders.authorizationHeader:
          "Basic ${base64Encode(utf8.encode('tdp-rest-api:secret'))}"
    };
    _dio.options.baseUrl = "https://stark-basin-96016.herokuapp.com";

    try {
      response = await _dio.post(
        "/oauth/token?username=$username&password=$password&grant_type=password",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      logger.i(response);
    } on DioError catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }
}
