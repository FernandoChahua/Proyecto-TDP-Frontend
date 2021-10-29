import 'package:ayuda_mujer/app/utils/constants/http_constants.dart';
import 'package:dio/dio.dart';

import 'package:logger/logger.dart';

class UserProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> getUserAssigned({
    required String token,
    required String uid,
  }) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.get(
        "/assignments/specialist/$uid",
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

  Future<Response> getDailyTip({
    required String token,
  }) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.get(
        "/tips/of-the-day",
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

  Future<Response> updateAssingment({
    required String token,
    required String uid,
    required String sid,
    required String crit,
    required String stat,
    required String rat,
  }) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.put("/assignments/patient/$uid/specialist/$sid",
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return true;
            },
          ),
          data: {
            "status": stat,
            "rating": rat,
            "criticality": crit,
          });
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }

  Future<Response> getSpecialistAssigned({
    required String token,
    required String uid,
  }) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.get(
        "/assignments/patient/$uid",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
      );
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }

  Future<Response> userAssign(
      {required String token,
      required String uid,
      required String category}) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.post(
        "/assignments/patient/$uid/Violencia $category/${0}",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
      );
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }
}
