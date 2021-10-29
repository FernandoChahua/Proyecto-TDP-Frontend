import 'package:ayuda_mujer/app/modules/location/providers/location_provider.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart' as dio;

class UbicacionController extends GetxController {
  late GoogleMapController mapController;

  late LocationData actualLocation;
  final RxList<dynamic> markersList = [].obs;
  final Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  final RxBool loading = true.obs;

  final logger = Logger(
    printer: PrettyPrinter(),
  );
  Future<bool> initMap() async {
    actualLocation = await Location().getLocation();
    await getPendingRequests();
    return true;
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void setMarkers() {
    for (final m in markersList) {
      final markerId = MarkerId(m["place_id"].toString());
      final double lat = m["geometry"]["location"]["lat"] as double;
      final double lng = m["geometry"]["location"]["lng"] as double;
      final marker = Marker(
        markerId: markerId,
        draggable: false,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: m["name"].toString()),
      );
      markers[markerId] = marker;
    }
  }

  Future getPendingRequests() async {
    markersList.clear();
    loading.value = true;

    dio.Response response;
    try {
      response = await LocationProvider().getMarkers(
        latitude: actualLocation.latitude.toString(),
        longitude: actualLocation.longitude.toString(),
      );
      loading.value = false;
      if (response.statusCode == 201 || response.statusCode == 200) {
        markersList.value = response.data["results"] as List;
        setMarkers();
        logger.i(markers.values);
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
