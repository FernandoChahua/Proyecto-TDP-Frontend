import 'dart:convert';

import 'package:ayuda_mujer/app/modules/homepage/providers/users_provider.dart';
import 'package:ayuda_mujer/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:ayuda_mujer/app/modules/perfil/controllers/perfil_controller.dart';
import 'package:ayuda_mujer/app/utils/chatbot_api.dart';
import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';
import 'package:ayuda_mujer/app/utils/stream_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:dio/dio.dart' as dio;
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final RxBool loading = false.obs;

  final RxString asigned = "not yet".obs;

  RxList<types.Message> messages = <types.Message>[].obs;
  final user = const types.User(id: '1234556');
  final bot = const types.User(id: "123");
  final BotService _botService = BotService();

  dynamic map = {};

  final logger = Logger(
    printer: PrettyPrinter(),
  );

  void addDefaultMessage() {
    messages.insert(0, botMessageReply("El chatbot ha finalizado."));
    messages.insert(
        0,
        botMessageReply(
            "Recuerde que siempre puede contactar al servicio telefónico de la línea 100, o visitar el Centro de Emergencia Mujer, ubicado en el 1er Piso del MIMP, Jirón Camaná 616, Cercado de Lima, para cualquier ayuda adicional que necesite."));
  }

  Future addMessage(types.Message message) async {
    messages.insert(0, message);
    final textSending = message.toJson()["text"].toString();
    if (asigned.value == "assigned" &&
        textSending != "no" &&
        textSending != "si") {
      addDefaultMessage();
    } else {
      final data = await _botService.callBot(textSending);

      List<String> msg = [];
      logger.wtf(data);
      String men = data["message"].toString();
      if (men.contains("//")) {
        final newMsgs = men.split(" // ");
        final splitMsgs = newMsgs[0].split("Categoria:");
        newMsgs[0] = splitMsgs[0];
        messages.insert(0, botMessageReply(newMsgs[0]));
        messages.insert(0, botMessageReply(newMsgs[1]));
        await userAssign(category: splitMsgs[1]);
      } else if (men.contains("Puntaje:")) {
        final newMsgs = men.split("Puntaje:");
        final int score = int.parse(newMsgs[1]);
        if (score < 8) {
          Get.find<HomepageController>().setBotScore("low");
        } else if (score < 14) {
          Get.find<HomepageController>().setBotScore("medium");
        } else {
          Get.find<HomepageController>().setBotScore("high");
        }

        messages.insert(0, botMessageReply(newMsgs[0]));
      } else {
        messages.insert(0, botMessageReply(men));
      }
    }
  }

  types.Message botMessageReply(String message) {
    return types.TextMessage(
      author: bot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message,
    );
  }

  void handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    addMessage(textMessage);
    update();
  }

  Future loadMessages() async {
    final RxList<types.Message> messagesList = <types.Message>[].obs;
    Future.delayed(const Duration(milliseconds: 300), () {
      messages = messagesList;
    });
  }

  Future userAssign({required String category}) async {
    loading.value = true;
    final ctr = Get.find<SessionController>();

    dio.Response response;
    try {
      response = await UserProvider().userAssign(
          token: ctr.token.value, uid: ctr.uid.value, category: category);
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        asigned.value = "assigned";
        map = response.data;
        logger.i(response.data);
        await Get.find<HomepageController>().getSpecialistAssigned();
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  Future createChatAssigned(BuildContext context) async {
    loading.value = true;
    asigned.value = "exit";
    final map = Get.find<ChatController>().map;
    final idParticipants = ["SP${map["id"]["specialistId"]}"];
    // ignore: use_build_context_synchronously
    await StreamChannelApi.createChannel(
      context,
      name:
          "${map["specialistName"]} - ${Get.find<PerfilController>().user["email"]}",
      idMembers: idParticipants,
    );
    loading.value = false;
  }

  @override
  void onInit() {
    loadMessages();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
