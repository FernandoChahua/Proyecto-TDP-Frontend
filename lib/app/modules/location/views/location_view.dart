import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../controllers/location_controller.dart';

class UbicacionView extends GetView<UbicacionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
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
            : GoogleMap(
                onMapCreated: controller.onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(controller.actualLocation.latitude!,
                      controller.actualLocation.longitude!),
                  zoom: 13,
                ),
                markers: Set<Marker>.of(controller.markers.values),
              ),
      ),
    );
  }
}
