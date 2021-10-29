import 'package:ayuda_mujer/app/modules/perfil/providers/perfil_provider.dart';
import 'package:ayuda_mujer/app/utils/constants/enums.dart';
import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart' as dio;

class PerfilController extends GetxController {
  //TODO: Implement PerfilController
  final RxBool loading = true.obs;

  final Rx<String> token = "".obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  dynamic user = {
    "firstName": "",
    "lastName": "",
    "email": "",
    "bornDate": "",
    "urlCertificate": "",
    "category": ""
  };

  final logger = Logger(
    printer: PrettyPrinter(),
  );
  Future updatePatientInfo() async {
    loading.value = true;
    final ctr = Get.find<SessionController>();

    dio.Response response;
    try {
      response = await PerfilProvider().updatePatientInfo(
          token: ctr.token.value,
          uid: ctr.uid.value,
          firstName: nameController.text,
          lastName: lastNameController.text,
          bornDate: fechaController.text);
      user["firstName"] = nameController.text;
      user["lastName"] = lastNameController.text;
      user["bornDate"] = fechaController.text;
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

  Future updateSpecialistInfo() async {
    loading.value = true;
    final ctr = Get.find<SessionController>();

    dio.Response response;
    try {
      response = await PerfilProvider().updateSpecialistInfo(
          token: ctr.token.value,
          uid: ctr.uid.value,
          firstName: nameController.text,
          lastName: lastNameController.text,
          bornDate: fechaController.text);
      user["firstName"] = nameController.text;
      user["lastName"] = lastNameController.text;
      user["bornDate"] = fechaController.text;
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

  Future getInfo() async {
    final ctr = Get.find<SessionController>();
    if (ctr.role.value == Role.PATIENT) {
      await getPatientInfo();
    } else if (ctr.role.value == Role.SPECIALIST) {
      await getSpecialistInfo();
    }
  }

  Future getPatientInfo() async {
    loading.value = true;
    final ctr = Get.find<SessionController>();
    final String token = ctr.token.value;
    dio.Response response;
    try {
      response = await PerfilProvider()
          .getPatientInfo(token: token, uid: ctr.uid.value);
      if (response.statusCode == 201 || response.statusCode == 200) {
        user = response.data;
        logger.i(user);
      } else {
        logger.i(response.statusCode);
      }
      loading.value = false;
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  Future getSpecialistInfo() async {
    loading.value = true;
    final ctr = Get.find<SessionController>();
    final String token = ctr.token.value;
    dio.Response response;
    try {
      response = await PerfilProvider()
          .getSpecialistInfo(token: token, uid: ctr.uid.value);
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        user = response.data;
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
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
