import 'package:ayuda_mujer/app/modules/perfil/views/widgets/perfil_specialist_view.dart';
import 'package:ayuda_mujer/app/utils/constants/enums.dart';
import 'package:ayuda_mujer/app/utils/controllers/session_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../controllers/perfil_controller.dart';
import 'widgets/perfil_patient_view.dart';

class PerfilView extends GetView<PerfilController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
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
          : SingleChildScrollView(
              child: Get.find<SessionController>().role.value == Role.SPECIALIST
                  ? const PerfilSpecialisttView()
                  : const PerfilPatientView(),
            ),
    );
  }
}
