import 'package:ayuda_mujer/app/modules/sign_up/providers/sign_up_provider.dart';
import 'package:ayuda_mujer/app/utils/constants/profile_image.dart';
import 'package:ayuda_mujer/app/utils/file_uploader.dart';
import 'package:ayuda_mujer/app/utils/stream_api.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SignUpController extends GetxController {
  //TODO: Implement SignInController

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController nombreController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController adjuntoController = TextEditingController();

  final fileUrl = "".obs;
  final anonimo = false.obs;
  final fileName = "".obs;
  final RxBool loading = false.obs;
  final FileUploader fileUploader = FileUploader();
  final category = "Violencia Fisica".obs;
  final items = [
    "Violencia Fisica",
    "Violencia Psicologica",
    "Violencia Sexual"
  ];

  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future pickFile() async {
    fileName.value = await fileUploader.selectFile();
  }

  Future signUpUser() async {
    loading.value = true;
    dio.Response response;

    try {
      response = await SignUpProvider().signUpUser(
        username: usernameController.text,
        password: passwordController.text,
        bornDate: fechaController.text,
        firstName: nombreController.text,
        lastName: apellidoController.text,
      );
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.back();
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }

    loading.value = false;
  }

  Future signUpSpecialist() async {
    loading.value = true;
    dio.Response response;
    fileUrl.value = await fileUploader.uploadFileOnCloudinary();
    if (fileUrl.value != "error") {
      try {
        response = await SignUpProvider().signUpSpecialist(
            username: usernameController.text,
            password: passwordController.text,
            bornDate: fechaController.text,
            firstName: nombreController.text,
            lastName: apellidoController.text,
            certificade: fileUrl.value,
            category: category.value);
        loading.value = false;
        if (response.statusCode == 201 || response.statusCode == 200) {
          Get.back();
          logger.i(response.data);
        } else {
          logger.i(response.statusCode);
        }
      } on Exception catch (e) {
        loading.value = false;
        logger.e(e);
      }
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
