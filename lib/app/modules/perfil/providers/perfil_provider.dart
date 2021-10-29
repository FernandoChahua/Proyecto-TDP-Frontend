import 'package:ayuda_mujer/app/utils/constants/http_constants.dart';
import 'package:dio/dio.dart';

import 'package:logger/logger.dart';

class PerfilProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> getPatientInfo({
    required String token,
    required String uid,
  }) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.get(
        "/user/patient-profile/$uid",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }

  Future<Response> getSpecialistInfo({
    required String token,
    required String uid,
  }) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.get(
        "/user/specialist-profile/$uid",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }

  Future<Response> updatePatientInfo({
    required String token,
    required String uid,
    required String firstName,
    required String lastName,
    required String bornDate,
  }) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.put("/user/patient-edit/$uid",
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return true;
            },
          ),
          data: {
            "firstName": firstName,
            "lastName": lastName,
            "bornDate": bornDate,
          });
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }

  Future<Response> updateSpecialistInfo({
    required String token,
    required String uid,
    required String firstName,
    required String lastName,
    required String bornDate,
  }) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.put("/user/specialist-edit/$uid",
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return true;
            },
          ),
          data: {
            "firstName": firstName,
            "lastName": lastName,
            "bornDate": bornDate,
          });
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }
}
