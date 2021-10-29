import 'package:ayuda_mujer/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:ayuda_mujer/app/utils/widget_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'homepage_list_item.dart';

class SpecialistHomeView extends GetView<HomepageController> {
  const SpecialistHomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = defaultSize(context);
    return Container(
      padding: EdgeInsets.all(size),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Consejo del día:",
                    style: GoogleFonts.roboto(
                      fontSize: size * 0.9,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    controller.tipDay.value,
                    style: GoogleFonts.roboto(
                      fontSize: size * 0.8,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: size * 8,
                    child: Image.asset("assets/images/paisaje.jpg"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Víctimas asignadas",
                    style: GoogleFonts.roboto(
                      fontSize: size * 0.9,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.pacientsAssinged.value.length,
                      itemBuilder: (context, index) {
                        dynamic map = controller.pacientsAssinged.value[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.defaultDialog(
                                  title: "Cambiar estado  ",
                                  content: Column(children: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                        controller.updatePatientCriticality(
                                            index, "low");
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 7),
                                        height: size * 1.7,
                                        width: size * 7,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          "Bajo",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: size * 0.8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                        controller.updatePatientCriticality(
                                            index, "medium");
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 7),
                                        height: size * 1.7,
                                        width: size * 7,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          "Medio",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: size * 0.8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                        controller.updatePatientCriticality(
                                            index, "high");
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 7),
                                        height: size * 1.7,
                                        width: size * 7,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          "Alto",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: size * 0.8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                );
                              },
                              child: HomepageListItem(
                                label:
                                    '${map["patientName"] == " " ? map["patientEmail"] : map["patientName"]}',
                                child: Container(
                                  padding: const EdgeInsets.only(top: 3),
                                  height: size * 1.2,
                                  width: size * 6,
                                  decoration: BoxDecoration(
                                    color:
                                        map["criticality"].toString() == "low"
                                            ? Colors.green
                                            : map["criticality"].toString() ==
                                                    "medium"
                                                ? Colors.amber
                                                : Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    map["criticality"].toString() == "low"
                                        ? "Bajo"
                                        : map["criticality"].toString() ==
                                                "medium"
                                            ? "Medio"
                                            : "Alto",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: size * 0.8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 13,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
