
import 'package:ayuda_mujer/app/modules/chat/views/chat_view.dart';
import 'package:ayuda_mujer/app/modules/feedback/views/feedback_view.dart';
import 'package:ayuda_mujer/app/modules/homepage/views/homepage_view.dart';
import 'package:ayuda_mujer/app/modules/news/views/news_view.dart';
import 'package:ayuda_mujer/app/modules/perfil/views/perfil_view.dart';
import 'package:ayuda_mujer/app/modules/location/views/location_view.dart';
import 'package:ayuda_mujer/app/utils/constants/enums.dart';
import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var tabIndex = 0;

  List<BottomNavigationBarItem> tabs = [];
  List<Widget> widgets = [];
  void chaangeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  bool setNavBar() {
    return true;
  }

  @override
  void onInit() {
    var role = Get.find<SessionController>().role;

    tabs.add(
      _bottomNavitagionBarItems(
        icon: Icons.home,
        label: "Home",
      ),
    );

    widgets.add(HomepageView());

    if (role == Role.PATIENT || role == Role.SPECIALIST) {
      tabs.add(
        _bottomNavitagionBarItems(
          icon: Icons.person,
          label: "Perfil",
        ),
      );
      widgets.add(PerfilView());

      tabs.add(
        _bottomNavitagionBarItems(
          icon: Icons.chat_bubble_outline,
          label: "Chatbot",
        ),
      );
      widgets.add(ChatView());

      tabs.add(
        _bottomNavitagionBarItems(
          icon: Icons.info,
          label: "Info",
        ),
      );
      widgets.add(NewsView());
    }

    if (role == Role.SPECIALIST || role == Role.ADMIN) {
      tabs.add(
        _bottomNavitagionBarItems(
          icon: Icons.feedback,
          label: "Feedback",
        ),
      );
      widgets.add(FeedbackView());
    }

    if (role == Role.PATIENT) {
      tabs.add(
        _bottomNavitagionBarItems(
          icon: Icons.map,
          label: "Mapa",
        ),
      );
      widgets.add(UbicacionView());
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  BottomNavigationBarItem _bottomNavitagionBarItems(
      {IconData? icon, String? label}) {
    return BottomNavigationBarItem(
        icon: Icon(icon), label: label, backgroundColor: Colors.transparent);
  }
}
