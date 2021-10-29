import 'package:ayuda_mujer/app/modules/homepage/views/widgets/user_home_view.dart';
import 'package:ayuda_mujer/app/utils/constants/enums.dart';
import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';
import 'package:ayuda_mujer/app/utils/controllers/user_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/homepage_controller.dart';
import 'widgets/admin_home_view.dart';

import 'widgets/specialist_home_view.dart';

class HomepageView extends GetView<HomepageController> {
  @override
  Widget build(BuildContext context) {
    final Role role = Get.find<SessionController>().role.value;
    return Scaffold(
      body: role == Role.ADMIN
          ? const AdminHomeVIew()
          : role == Role.SPECIALIST
              ? const SpecialistHomeView()
              : const UserHomeView(),
    );
  }
}
