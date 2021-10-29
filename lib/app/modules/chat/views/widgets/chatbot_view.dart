import 'package:ayuda_mujer/app/modules/chat/controllers/chat_controller.dart';
import 'package:ayuda_mujer/app/modules/perfil/controllers/perfil_controller.dart';
import 'package:ayuda_mujer/app/utils/constants/profile_image.dart';

import 'package:flutter/material.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:get/state_manager.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:get/get.dart';

class BotScreen extends GetView<ChatController> {
  BotScreen({Key? key}) : super(key: key);

//id of bot and user doesn't matter here as we have only pair interaction

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: controller.asigned.value);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: apbar(context),
        body: Obx(
          () => Chat(
            messages: controller.messages.value,
            showUserNames: true,
            onSendPressed: controller.handleSendPressed,
            user: controller.user,
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget apbar(BuildContext context) {
  return AppBar(
    backgroundColor: ChannelHeaderTheme.of(context).color,
    textTheme: Theme.of(context).textTheme,
    brightness: Theme.of(context).brightness,
    elevation: 1,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Center(
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey.shade100,
            child: Image.network(
              ImageGeneratonr.getBotImage(
                Get.find<PerfilController>().user['email'].toString(),
              ),
            ),
          ),
        ),
      ),
    ],
    centerTitle: true,
    title: InkWell(
      child: SizedBox(
        height: const Size.fromHeight(kToolbarHeight).height,
        width: const Size.fromHeight(kToolbarHeight).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Chatbot de ayuda"),
            SizedBox(height: 2),
          ],
        ),
      ),
    ),
  );
}
