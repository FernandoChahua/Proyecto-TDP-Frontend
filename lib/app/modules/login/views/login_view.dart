import 'dart:ui';

import 'package:ayuda_mujer/app/utils/widget_size.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final size = defaultSize(context);
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                colors: [Colors.deepPurpleAccent, Colors.blueAccent],
              ),
            ),
            child: Obx(
              () => controller.loading.value
                  ? Center(
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: LoadingIndicator(
                            colors: [Colors.pink.shade500],
                            indicatorType: Indicator.ballClipRotateMultiple,
                          )),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Center(
                            child: SizedBox(
                              width: size * 5,
                              height: size * 5,
                              child: Image.asset("assets/images/logo.png"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size * 3),
                          child: Text(
                            "USUARIO",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.roboto(
                              fontSize: size * 0.9,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: size * 3),
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: controller.usernameController,
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange)),
                                hintText: "Ingresa Usuario *",
                                hintStyle: TextStyle(
                                    color: Colors.white60,
                                    fontSize: size * 0.8),
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: size * 0.8),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size * 3),
                          child: Text(
                            "CONTRASEÑA",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.roboto(
                              fontSize: size * 0.9,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: size * 3),
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: controller.passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                hintText: "Ingresa Contraseña *",
                                hintStyle: TextStyle(
                                    color: Colors.white60,
                                    fontSize: size * 0.8),
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: size * 0.8),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: size * 13,
                            height: size * 2.3,
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller.getSesion();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                overlayColor:
                                    MaterialStateProperty.all(Colors.black12),
                                foregroundColor: MaterialStateProperty.all(
                                    Colors.deepPurpleAccent),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              child: Text("LOGIN",
                                  style: TextStyle(fontSize: size * 0.9)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () async {
                              Get.toNamed("/sign-in");
                            },
                            child: Text("Registrar Cuenta",
                                style: TextStyle(
                                    color: Colors.orange, fontSize: size)),
                          ),
                        ),
                        SizedBox(
                          height: size,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
