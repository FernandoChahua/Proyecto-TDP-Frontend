import 'package:ayuda_mujer/app/utils/constants/http_constants.dart';
import 'package:dio/dio.dart';

import 'package:logger/logger.dart';

class HomepageAdminProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> getPendingRequests(String token) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.get(
        "/specialist-request",
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

  Future<Response> setRequest(
      {required String token,
      required String rid,
      required String status}) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.put(
        "/specialist-request/changeState/$status/$rid",
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
}
