import 'package:ayuda_mujer/app/utils/constants/http_constants.dart';
import 'package:dio/dio.dart';

import 'package:logger/logger.dart';

class FeedbackProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> getFeeds(String token) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.get(
        "/feedback",
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

  Future<Response> sendFeed(
      {required String token,
      required String uid,
      required dynamic data}) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpConstants.URL;

    try {
      response = await _dio.post(
        "/feedback/$uid",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return true;
          },
        ),
        data: data,
      );
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }
}
