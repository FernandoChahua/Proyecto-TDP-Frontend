import 'package:get/get.dart';

import '../controllers/location_controller.dart';

class UbicacionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      UbicacionController(),
    );
  }
}
