import 'package:ayuda_mujer/app/modules/perfil/controllers/perfil_controller.dart';
import 'package:ayuda_mujer/app/utils/constants/enums.dart';
import 'package:ayuda_mujer/app/utils/constants/profile_image.dart';
import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';
import 'package:ayuda_mujer/app/utils/stream_api.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../controllers/chat_controller.dart';
import 'widgets/active_user_row_widget.dart';
import 'widgets/chatbot_view.dart';
import 'widgets/chats_widget.dart';

class ChatView extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChannelsBloc(
        child: Column(
          children: [
            Visibility(
              visible: Get.find<SessionController>().role.value == Role.PATIENT,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 100,
                        child: ActiveUsersRowWidget(),
                      ),
                      SizedBox(
                        height: 100,
                        child: GestureDetector(
                          onTap: () async {
                            final result = await Get.to(() => BotScreen());

                            if (result != null && result != "not yet") {
                              await controller.createChatAssigned(context);
                            }
                          },
                          child: SizedBox(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade100,
                                  radius: 25,
                                  child: Image.network(
                                    ImageGeneratonr.getBotImage(
                                      Get.find<PerfilController>()
                                          .user['email']
                                          .toString(),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Chatbot\nde ayuda',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
            Expanded(
              child: Obx(() => controller.loading.value
                  ? Center(
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: LoadingIndicator(
                          colors: [Colors.pink.shade500],
                          indicatorType: Indicator.ballClipRotateMultiple,
                        ),
                      ),
                    )
                  : ChatsWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
