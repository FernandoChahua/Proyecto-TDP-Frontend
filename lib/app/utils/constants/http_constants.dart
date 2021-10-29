import 'dart:convert';

abstract class HttpConstants {
  static const URL = "https://stark-basin-96016.herokuapp.com";
  static const MAPURL =
      "https://maps.googleapis.com/maps/api/place/nearbysearch";
  static const MAPTOKEN = "AIzaSyDJUNhxVvtK6WmrwelGzkM9GgbwwLMwsWk";
  static final BASIC_HEADER =
      "Basic ${base64Encode(utf8.encode('tdp-rest-api:secret'))}";
}
