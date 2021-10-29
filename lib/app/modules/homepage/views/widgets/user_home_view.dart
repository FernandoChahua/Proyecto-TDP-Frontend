import 'package:ayuda_mujer/app/modules/chat/controllers/chat_controller.dart';
import 'package:ayuda_mujer/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:ayuda_mujer/app/utils/widget_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'homepage_list_item.dart';

class UserHomeView extends GetView<HomepageController> {
  const UserHomeView({
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
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: Column(
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
                    "Especialista asignado",
                    style: GoogleFonts.roboto(
                      fontSize: size * 0.9,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // ignore: prefer_if_elements_to_conditional_expressions
                  Get.find<ChatController>().asigned.value == "not yet"
                      ? HomepageListItem(
                          label: "Sin asignar",
                          child: Container(
                            height: 11,
                            width: 11,
                            decoration: BoxDecoration(
                              color: Colors.red.shade600,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ))
                      : GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              title: "Calificar especialista",
                              buttonColor: Colors.deepPurpleAccent,
                              confirmTextColor: Colors.white,
                              cancelTextColor: Colors.black,
                              onConfirm: () async {
                                Get.back();
                                await controller.updateAssingment();
                              },
                              onCancel: () {},
                              content: RatingBar.builder(
                                initialRating: controller.specialistAssinged[0]
                                            ["rating"] as double ==
                                        0
                                    ? 3
                                    : controller.specialistAssinged[0]["rating"]
                                        as double,
                                onRatingUpdate: (rating) {
                                  controller.rating.value = rating;
                                },
                                itemBuilder: (context, index) {
                                  return iconRating(index);
                                },
                              ),
                            );
                          },
                          child: HomepageListItem(
                            label:
                                // ignore: invalid_use_of_protected_member
                                controller.specialistAssinged
                                    .value[0]["specialistName"]
                                    .toString(),
                            child: iconRating((controller.specialistAssinged[0]
                                    ["rating"] as double)
                                .round()),
                          ),
                        ),

                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
    );
  }

  Icon iconRating(int index) {
    switch (index) {
      case 0:
        return const Icon(
          Icons.sentiment_very_dissatisfied,
          color: Colors.red,
          size: 35,
        );
      case 1:
        return const Icon(
          Icons.sentiment_dissatisfied,
          color: Colors.redAccent,
          size: 35,
        );
      case 2:
        return const Icon(
          Icons.sentiment_neutral,
          color: Colors.amber,
          size: 35,
        );
      case 3:
        return const Icon(
          Icons.sentiment_satisfied,
          color: Colors.lightGreen,
          size: 35,
        );
      default:
        return const Icon(
          Icons.sentiment_very_satisfied,
          color: Colors.green,
          size: 35,
        );
    }
  }
}
