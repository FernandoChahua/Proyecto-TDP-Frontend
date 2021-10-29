import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar() {
  return AppBar(
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurpleAccent, Colors.blueAccent]),
      ),
    ),
    title: const Text(
      'Ayuda Mujer',
      textAlign: TextAlign.left,
    ),
    centerTitle: false,
  );
}
