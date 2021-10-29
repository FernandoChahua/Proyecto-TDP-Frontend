import 'package:ayuda_mujer/app/modules/home/controllers/home_controller.dart';
import 'package:ayuda_mujer/app/modules/home/views/home_view.dart';
import 'package:ayuda_mujer/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:ayuda_mujer/app/utils/widget_size.dart';
import 'package:ayuda_mujer/app/utils/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SpecialistReview extends GetView<HomepageController> {
  const SpecialistReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = defaultSize(context);
    final map = Get.arguments;
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NOMBRES:",
                style: GoogleFonts.roboto(
                    fontSize: size * 0.9, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size * 0.3,
              ),
              Text(
                map["firstName"].toString(),
                style: GoogleFonts.roboto(fontSize: size * 0.9),
              ),
              SizedBox(
                height: size,
              ),
              Text(
                "APELLIDOS:",
                style: GoogleFonts.roboto(
                    fontSize: size * 0.9, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size * 0.3,
              ),
              Text(
                map["lastName"].toString(),
                style: GoogleFonts.roboto(fontSize: size * 0.9),
              ),
              SizedBox(
                height: size,
              ),
              Text(
                "CORREO:",
                style: GoogleFonts.roboto(
                    fontSize: size * 0.9, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size * 0.3,
              ),
              Text(
                map["email"].toString(),
                style: GoogleFonts.roboto(fontSize: size * 0.9),
              ),
              SizedBox(
                height: size,
              ),
              Text(
                "ESPECIALISTA EN:",
                style: GoogleFonts.roboto(
                    fontSize: size * 0.9, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size * 0.3,
              ),
              Text(
                map["category"].toString(),
                style: GoogleFonts.roboto(fontSize: size * 0.9),
              ),
              SizedBox(
                height: size,
              ),
              Text(
                "FECHA DE NACIMIENTO:",
                style: GoogleFonts.roboto(
                    fontSize: size * 0.9, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size * 0.3,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(
                    width: size * 0.5,
                  ),
                  Text(
                    map["bornDate"].toString(),
                    style: GoogleFonts.roboto(fontSize: size * 0.9),
                  ),
                ],
              ),
              SizedBox(
                height: size,
              ),
              Text(
                "FECHA DE REGISTRO:",
                style: GoogleFonts.roboto(
                    fontSize: size * 0.9, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size * 0.3,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(
                    width: size * 0.5,
                  ),
                  Text(
                    map["createdAt"].toString(),
                    style: GoogleFonts.roboto(fontSize: size * 0.9),
                  ),
                ],
              ),
              SizedBox(
                height: size,
              ),
              Center(
                child: TextButton(
                  onPressed: () async {
                    final String url = map["urlCertificate"].toString();
                    if (await canLaunch(url)) {
                      await launch(
                        url,
                        forceSafariVC: false,
                      );
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text(
                    "Ver Certificado",
                    style: GoogleFonts.roboto(
                        fontSize: size * 0.9, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: size,
              ),
              if (map["state"].toString() == "CREATED")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.setRequest(
                              rid: map["idSpecialistRequest"].toString(),
                              status: "APPROVED");
                          controller.update();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Text(
                          "APROBAR",
                          style: GoogleFonts.roboto(
                              fontSize: size * 0.9,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.setRequest(
                              rid: map["idSpecialistRequest"].toString(),
                              status: "REJECTED");
                          controller.update();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Text(
                          "RECHAZAR",
                          style: GoogleFonts.roboto(
                              fontSize: size * 0.9,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                )
              else
                Column(
                  children: [
                    Text(
                      "SOLICITUD:",
                      style: GoogleFonts.roboto(
                          fontSize: size * 0.9, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: size * 0.3,
                    ),
                    Text(
                      map["state"].toString(),
                      style: GoogleFonts.roboto(fontSize: size * 0.9),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: (int index) {
          final ctrl = Get.find<HomeController>();
          ctrl.chaangeTabIndex(index);
          Get.back();
        },
      ),
    );
  }
}
