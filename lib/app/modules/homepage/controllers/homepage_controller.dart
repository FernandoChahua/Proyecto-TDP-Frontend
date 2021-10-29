import 'package:ayuda_mujer/app/modules/chat/controllers/chat_controller.dart';
import 'package:ayuda_mujer/app/modules/homepage/providers/users_provider.dart';
import 'package:ayuda_mujer/app/modules/homepage/providers/homepage_admin_provider.dart';

import 'package:get/get.dart';

import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';

import 'package:dio/dio.dart' as dio;

import 'package:logger/logger.dart';

class HomepageController extends GetxController {
  //TODO: Implement HomepageController

  final RxBool loading = true.obs;

  final RxList<dynamic> specialistRequestList = [].obs;
  final RxList<dynamic> specialistPendingList = [].obs;
  final RxList<dynamic> specialistNonPendingList = [].obs;

  final RxList<dynamic> specialistAssinged = [].obs;
  final RxList<dynamic> pacientsAssinged = [].obs;

  final RxDouble rating = 0.0.obs;
  final tipDay = "".obs;

  final logger = Logger(
    printer: PrettyPrinter(),
  );

  void refreshList() {
    specialistPendingList.clear();
    specialistNonPendingList.clear();
    for (final request in specialistRequestList) {
      if (request["state"] == "CREATED") {
        specialistPendingList.add(request);
      } else {
        specialistNonPendingList.add(request);
      }
    }
    update();
  }

  Future getPacientsAssinged() async {
    pacientsAssinged.clear();
    loading.value = true;
    final ctr = Get.find<SessionController>();

    dio.Response response;
    try {
      response = await UserProvider()
          .getUserAssigned(token: ctr.token.value, uid: ctr.uid.value);
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        pacientsAssinged.value = response.data as List;
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  Future getDailyTip() async {
    loading.value = true;
    final ctr = Get.find<SessionController>();

    dio.Response response;
    try {
      response = await UserProvider().getDailyTip(token: ctr.token.value);
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        tipDay.value = response.data["description"].toString();
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  Future updateAssingment() async {
    loading.value = true;
    final ctr = Get.find<SessionController>();

    dio.Response response;
    try {
      response = await UserProvider().updateAssingment(
        token: ctr.token.value,
        uid: specialistAssinged[0]["id"]["patientId"].toString(),
        sid: specialistAssinged[0]["id"]["specialistId"].toString(),
        crit: specialistAssinged[0]["criticality"].toString(),
        stat: specialistAssinged[0]["status"].toString(),
        rat: rating.value.toString(),
      );
      specialistAssinged[0]["rating"] = rating.value;
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }
  Future setBotScore(String crit) async {
    loading.value = true;
    final ctr = Get.find<SessionController>();

    dio.Response response;
    try {
      response = await UserProvider().updateAssingment(
        token: ctr.token.value,
        uid: specialistAssinged[0]["id"]["patientId"].toString(),
        sid: specialistAssinged[0]["id"]["specialistId"].toString(),
        crit: crit,
        stat: specialistAssinged[0]["status"].toString(),
        rat: specialistAssinged[0]["rating"].toString(),
      );
      specialistAssinged[0]["rating"] = rating.value;
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  Future updatePatientCriticality(int index, String crit) async {
    loading.value = true;
    final ctr = Get.find<SessionController>();
    dio.Response response;
    try {
      response = await UserProvider().updateAssingment(
        token: ctr.token.value,
        uid: pacientsAssinged[index]["id"]["patientId"].toString(),
        sid: pacientsAssinged[index]["id"]["specialistId"].toString(),
        crit: crit,
        stat: pacientsAssinged[index]["status"].toString(),
        rat: pacientsAssinged[index]["rating"].toString(),
      );
      pacientsAssinged[index]["criticality"] = crit;
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  Future getSpecialistAssigned() async {
    specialistAssinged.clear();
    loading.value = true;
    final ctr = Get.find<SessionController>();

    dio.Response response;
    try {
      response = await UserProvider()
          .getSpecialistAssigned(token: ctr.token.value, uid: ctr.uid.value);
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        specialistAssinged.value = response.data as List;
        if (specialistAssinged.value.length > 0) {
          Get.find<ChatController>().asigned.value = "assigned";
        }
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  Future getPendingRequests() async {
    specialistRequestList.clear();
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    try {
      response = await HomepageAdminProvider().getPendingRequests(token);
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        specialistRequestList.value = response.data as List;
        refreshList();
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  Future setRequest({required String rid, required String status}) async {
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    try {
      response = await HomepageAdminProvider()
          .setRequest(token: token, rid: rid, status: status);
      loading.value = false;
      if (response.statusCode == 200) {
        await getPendingRequests();
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
