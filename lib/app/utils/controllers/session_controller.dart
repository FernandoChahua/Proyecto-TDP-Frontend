import 'package:ayuda_mujer/app/utils/constants/enums.dart';
import 'package:ayuda_mujer/app/utils/constants/profile_image.dart';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart' as log;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SessionController extends GetxController {
  late final SharedPreferences prefs;

  final RxBool active = false.obs; //*Si hay una sesíon activa
  final RxString refreshToken = "empty".obs;
  final RxString uid = "empty".obs;
  final RxString chatId = "empty".obs;
  final RxString token = "empty".obs;
  final Rx<Role> role = Role.ADMIN.obs;

  Future getUserChat(BuildContext context, String uid) async {
    final client = StreamChat.of(context).client;
    client.connectUser(
      User(
        id: uid,
        extraData: const {
          'image': ImageGeneratonr.userProfile,
        },
      ),
      client.devToken(uid).rawValue,
    );
  }

  void setSesion(
      {required String token,
      required String uid,
      required String refreshToken,
      required Role role,
      required String chatid}) {
    this.role.value = role;
    this.uid.value = uid;
    this.token.value = token;
    this.refreshToken.value = refreshToken;
    this.chatId.value = chatid;
  }

  final logger = log.Logger(
    printer: log.PrettyPrinter(),
  );

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
