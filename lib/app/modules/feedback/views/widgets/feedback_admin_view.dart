import 'package:ayuda_mujer/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:ayuda_mujer/app/utils/widget_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'feedback_review.dart';

class FeedbackAdminView extends GetView<FeedbackController> {
  const FeedbackAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = defaultSize(context);
    var df = DateFormat('dd-MM-yyyy hh:mm a');
    return Container(
      padding: EdgeInsets.all(size),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Propuestas de mejora:",
            style: GoogleFonts.roboto(
              fontSize: size * 0.9,
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Obx(
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
                  : AnimatedList(
                      key: controller.listKey,
                      initialItemCount: controller.feedsList.length,
                      itemBuilder: (context, index, animation) {
                        final map = controller.feedsList[index];
                        return SizeTransition(
                          sizeFactor: animation,
                          child: InkWell(
                            onTap: () {
                              controller.selectedFeed.value = index;
                              Get.to(
                                () => const FeedbackReview(),
                                arguments: map,
                              );
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Visibility(
                                      visible: map["state"] as bool,
                                      child: Container(
                                        height: 7,
                                        width: 7,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "${map["title"]}\n",
                                              style: GoogleFonts.roboto(
                                                  fontSize: size * 0.9,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: "Realizado por: ",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: size * 0.8),
                                            ),
                                            TextSpan(
                                              text: "${map["title"]}\n",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: size * 0.8),
                                            ),
                                            TextSpan(
                                              text: "Fecha: ",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: size * 0.8),
                                            ),
                                            TextSpan(
                                              text: df.format(
                                                DateTime.parse(
                                                  map["registrationDate"]
                                                      .toString(),
                                                ),
                                              ),
                                              style: GoogleFonts.roboto(
                                                fontWeight: FontWeight.w500,
                                                fontSize: size * 0.8,
                                              ),
                                            ),
                                          ],
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            letterSpacing: 1,
                                            height: 1.4,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.deepPurple.shade700,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}
