import 'package:ayuda_mujer/app/utils/constants/http_constants.dart';
import 'package:dio/dio.dart';

import 'package:logger/logger.dart';

class LocationProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> getMarkers(
      {required String latitude, required String longitude}) async {
    final _dio = Dio();
    final Response response;

    _dio.options.baseUrl = HttpConstants.MAPURL;

    try {
      response = await _dio.get(
        "/json?keyword=Centro Emergencia Mujer&location=$latitude%2C$longitude&radius=10000&type=health&key=${HttpConstants.MAPTOKEN}",
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
