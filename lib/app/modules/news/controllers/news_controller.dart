import 'package:ayuda_mujer/app/modules/news/providers/news_provider.dart';
import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:logger/logger.dart';

class NewsController extends GetxController {
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  final RxBool loading = true.obs;

  final RxList<dynamic> newsList = [].obs;

  Future getNews() async {
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    try {
      response = await NewsProvider().getNews(token);
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        newsList.value = response.data as List;

        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
