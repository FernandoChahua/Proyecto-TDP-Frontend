import 'package:flutter/widgets.dart';

double defaultSize(BuildContext context) {
  final deviceData = MediaQuery.of(context);
  final double height = deviceData.size.height;
  final double width = deviceData.size.width;

  return (height > width) ? height * 0.025 : width * 0.025;
}

Size deviceSize(BuildContext context) {
  return MediaQuery.of(context).size;
}
