import 'package:ayuda_mujer/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:ayuda_mujer/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:ayuda_mujer/app/modules/location/controllers/location_controller.dart';
import 'package:ayuda_mujer/app/modules/login/provider/login_provider.dart';
import 'package:ayuda_mujer/app/modules/news/controllers/news_controller.dart';
import 'package:ayuda_mujer/app/modules/perfil/controllers/perfil_controller.dart';
import 'package:ayuda_mujer/app/utils/constants/enums.dart';
import 'package:ayuda_mujer/app/utils/constants/profile_image.dart';
import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';
import 'package:ayuda_mujer/app/utils/stream_api.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:logger/logger.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final RxBool loading = false.obs;

  final Rx<String> token = "".obs;
  late Map<String, dynamic> payload;

  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future getSesion() async {
    loading.value = true;
    final ctrl = Get.find<SessionController>();
    late String uid;
    Future initSesion(Role role, String refreshToken, String chatId) async {
      ctrl.setSesion(
          token: token.value,
          uid: uid,
          refreshToken: refreshToken,
          role: role,
          chatid: chatId);
      if (role != Role.ADMIN) {
        await Get.find<PerfilController>().getInfo();
        final user = Get.find<PerfilController>().user;
        await StreamUserApi.createUser(
          idUser: chatId,
          username: role == Role.SPECIALIST
              ? "${user["firstName"]} ${user["lastName"]}"
              : user["firstName"].toString() == ""
                  ? user["firstName"].toString()
                  : usernameController.text,
          urlImage: ImageGeneratonr.getImage(usernameController.text),
        );
      }
      Get.offAndToNamed("/home");
    }

    dio.Response response;
    try {
      response = await LoginProvider()
          .getSession(usernameController.text, passwordController.text);

      if (response.statusCode == 201 || response.statusCode == 200) {
        logger.i(response.data);

        token.value = response.data["access_token"].toString();
        payload = Jwt.parseJwt(token.value);

        final Role role = Role.values.firstWhere((e) =>
            e.toString() == 'Role.${payload["authorities"][0] as String}');

        if (role == Role.ADMIN) {
          uid = "1";
          initSesion(role, response.data["refresh_token"].toString(), "SP$uid");
          await Get.find<HomepageController>().getPendingRequests();
          await Get.find<FeedbackController>().getFeeds();
        } else if (role == Role.PATIENT) {
          uid = payload["patientId"].toString();
          await initSesion(
              role, response.data["refresh_token"].toString(), "PC$uid");
          await Get.find<HomepageController>().getSpecialistAssigned();
          await Get.find<HomepageController>().getDailyTip();
          await Get.find<UbicacionController>().initMap();
          await Get.find<NewsController>().getNews();
        } else if (role == Role.SPECIALIST) {
          uid = payload["specialistId"].toString();
          await initSesion(
              role, response.data["refresh_token"].toString(), "SP$uid");
          await Get.find<HomepageController>().getPacientsAssinged();
          await Get.find<HomepageController>().getDailyTip();
          await Get.find<NewsController>().getNews();
          await Get.find<UbicacionController>().initMap();
        }

        loading.value = false;
      } else {
        logger.i(response.statusCode);
        loading.value = false;
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
    loading.value = false;
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
