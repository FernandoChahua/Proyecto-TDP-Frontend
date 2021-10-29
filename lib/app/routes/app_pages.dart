import 'package:ayuda_mujer/app/modules/chat/bindings/chatbot_binding.dart';
import 'package:ayuda_mujer/app/modules/chat/views/chat_view.dart';
import 'package:get/get.dart';

import 'package:ayuda_mujer/app/modules/feedback/bindings/feedback_binding.dart';
import 'package:ayuda_mujer/app/modules/feedback/views/feedback_view.dart';
import 'package:ayuda_mujer/app/modules/home/bindings/home_binding.dart';
import 'package:ayuda_mujer/app/modules/home/views/home_view.dart';
import 'package:ayuda_mujer/app/modules/homepage/bindings/homepage_binding.dart';
import 'package:ayuda_mujer/app/modules/homepage/views/homepage_view.dart';
import 'package:ayuda_mujer/app/modules/news/bindings/news_binding.dart';
import 'package:ayuda_mujer/app/modules/news/views/news_view.dart';
import 'package:ayuda_mujer/app/modules/login/bindings/login_binding.dart';
import 'package:ayuda_mujer/app/modules/login/views/login_view.dart';
import 'package:ayuda_mujer/app/modules/perfil/bindings/perfil_binding.dart';
import 'package:ayuda_mujer/app/modules/perfil/views/perfil_view.dart';
import 'package:ayuda_mujer/app/modules/sign_up/bindings/sign_up_binding.dart';
import 'package:ayuda_mujer/app/modules/sign_up/views/sign_up_view.dart';
import 'package:ayuda_mujer/app/modules/location/bindings/location_binding.dart';
import 'package:ayuda_mujer/app/modules/location/views/location_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => HomepageView(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK,
      page: () => FeedbackView(),
      binding: FeedbackBinding(),
    ),
    GetPage(
      name: _Paths.INFO,
      page: () => NewsView(),
      binding: NewsBinding(),
    ),
    GetPage(
      name: _Paths.PERFIL,
      page: () => PerfilView(),
      binding: PerfilBinding(),
    ),
    GetPage(
      name: _Paths.UBICACION,
      page: () => UbicacionView(),
      binding: UbicacionBinding(),
    ),
    GetPage(
      name: _Paths.CHATBOT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
  ];
}
