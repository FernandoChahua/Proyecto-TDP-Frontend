import 'package:ayuda_mujer/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:ayuda_mujer/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';
import 'package:ayuda_mujer/app/utils/stream_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'app/modules/chat/controllers/chat_controller.dart';
import 'app/modules/location/controllers/location_controller.dart';
import 'app/modules/news/controllers/news_controller.dart';
import 'app/modules/perfil/controllers/perfil_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/controllers/user_controller.dart';

void main() {
  /*SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: ,
    ),
  );*/
  Get.put(FeedbackController());
  Get.put(UserController());
  Get.put(SessionController());
  Get.put(HomepageController());
  Get.put(PerfilController());
  Get.put(UbicacionController());
  Get.put(NewsController());
  Get.put(
    ChatController(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return StreamChat(
          client: StreamApi.client,
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
