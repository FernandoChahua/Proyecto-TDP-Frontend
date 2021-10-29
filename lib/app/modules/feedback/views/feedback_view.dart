import 'package:ayuda_mujer/app/utils/constants/enums.dart';
import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';
import 'package:ayuda_mujer/app/utils/controllers/user_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/feedback_controller.dart';
import 'widgets/feedback_admin_view.dart';
import 'widgets/feedback_expert_view.dart';

class FeedbackView extends GetView<FeedbackController> {
  @override
  Widget build(BuildContext context) {
    return Get.find<SessionController>().role.value == Role.ADMIN
        ? const FeedbackAdminView()
        : const FeedbackExpertView();
  }
}
