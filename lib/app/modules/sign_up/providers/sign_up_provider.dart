import 'package:ayuda_mujer/app/utils/constants/http_constants.dart';
import 'package:dio/dio.dart';

import 'package:logger/logger.dart';

class SignUpProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> signUpUser(
      {required String username,
      required String password,
      required String bornDate,
      String firstName = "",
      String lastName = ""}) async {
    final _dio = Dio();
    final Response response;

    _dio.options.headers = {};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.post("/user/register-patient",
          data: {
            "email": username,
            "password": password,
            "firstName": firstName,
            "lastName": lastName,
            "bornDate": bornDate
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
          ));
      logger.i(response);
    } on DioError catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }

  Future<Response> signUpSpecialist(
      {required String username,
      required String password,
      required String bornDate,
      required String category,
      required String certificade,
      required String firstName,
      required String lastName}) async {
    final _dio = Dio();
    final Response response;

    _dio.options.headers = {};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.post(
        "/specialist-request",
        data: {
          "email": username,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
          "bornDate": bornDate,
          "urlCertificate": certificade,
          "category": category
        },
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
