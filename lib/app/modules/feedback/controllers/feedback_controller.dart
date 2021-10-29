import 'package:ayuda_mujer/app/modules/feedback/providers/feedback_provider.dart';
import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class FeddbackItemObject {
  FeddbackItemObject({
    this.titulo,
    this.autor,
    this.fecha,
    this.descripcion,
  });

  final String? titulo;
  final String? autor;
  final DateTime? fecha;
  final String? descripcion;
  final Rx<bool> revisado = false.obs;
}

String text =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer laoreet eros id ligula semper, et viverra massa imperdiet. Maecenas commodo vestibulum ante, in ultricies diam mattis quis. Cras et purus at justo vestibulum interdum. Nunc dignissim blandit libero, sollicitudin fermentum libero feugiat eget. Aliquam erat volutpat. Fusce maximus nisi quis urna porttitor auctor. Donec feugiat elementum velit eu ornare. Quisque faucibus orci vitae nisi eleifend, at blandit ipsum condimentum";

class FeedbackController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final feeds = [].obs;
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  final RxList<dynamic> feedsList = [].obs;
  final RxBool loading = false.obs;
  final Rx<int> selectedFeed = 0.obs;

  final listKey = GlobalKey<AnimatedListState>();

  Future getFeeds() async {
    feedsList.clear();
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    try {
      response = await FeedbackProvider().getFeeds(token);
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        feedsList.value = response.data as List;
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  Future sendFeed() async {
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    final String uid = Get.find<SessionController>().uid.value;
    dio.Response response;
    final data = {
      "title": titleController.text,
      "description": descriptionController.text,
      "state": true
    };
    try {
      response =
          await FeedbackProvider().sendFeed(token: token, uid: uid, data: data);
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        descriptionController.text = "";
        titleController.text = "";
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
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
