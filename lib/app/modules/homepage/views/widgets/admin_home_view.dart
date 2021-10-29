import 'package:ayuda_mujer/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:ayuda_mujer/app/modules/homepage/views/widgets/specialist_review.dart';
import 'package:ayuda_mujer/app/utils/widget_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'homepage_list_item.dart';

class AdminHomeVIew extends GetView<HomepageController> {
  const AdminHomeVIew({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = defaultSize(context);
    return Obx(
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
          : Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Solicitudes pendientes:",
                    style: GoogleFonts.roboto(
                      fontSize: size * 0.9,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => Expanded(
                      child: ListView.builder(
                        itemCount: controller.specialistPendingList.length,
                        itemBuilder: (context, index) {
                          final map = controller.specialistPendingList[index];

                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => const SpecialistReview(),
                                      arguments: map);
                                },
                                child: HomepageListItem(
                                  label:
                                      "${map["firstName"]} ${map["lastName"]}",
                                  child: Container(
                                    height: 11,
                                    width: 11,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurpleAccent,
                                      borderRadius: BorderRadius.circular(20),
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
                  ),
                  Text(
                    "Historial de solicitudes",
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
                    child: Obx(
                      () => ListView.builder(
                        itemCount: controller.specialistNonPendingList.length,
                        itemBuilder: (context, index) {
                          final map =
                              controller.specialistNonPendingList[index];

                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => const SpecialistReview(),
                                      arguments: map);
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: HomepageListItem(
                                        label:
                                            "${map["firstName"]} ${map["lastName"]}",
                                        child: Container(
                                          height: 11,
                                          width: 11,
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurpleAccent,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      map["state"].toString() == "APPROVED"
                                          ? Icons.check_box
                                          : Icons.disabled_by_default,
                                      color:
                                          map["state"].toString() == "APPROVED"
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    )
                                  ],
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
                  ),
                ],
              ),
            ),
    );
  }
}
