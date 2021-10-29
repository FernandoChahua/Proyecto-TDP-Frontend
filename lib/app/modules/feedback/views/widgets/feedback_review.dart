import 'package:ayuda_mujer/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:ayuda_mujer/app/modules/home/controllers/home_controller.dart';
import 'package:ayuda_mujer/app/modules/home/views/home_view.dart';

import 'package:ayuda_mujer/app/utils/widgets/custom_app_bar.dart';
import 'package:ayuda_mujer/app/utils/widget_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FeedbackReview extends GetView<FeedbackController> {
  const FeedbackReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('dd-MM-yyyy hh:mm a');
    final i = controller.selectedFeed.value;
    final double size = defaultSize(context);

    final map = Get.arguments;
    map["state"] = false;
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(size),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  map["title"].toString(),
                  style: GoogleFonts.roboto(
                    fontSize: size,
                    color: Colors.deepPurple.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Realizado por",
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.9,
                          color: Colors.deepPurple.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Fecha",
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.9,
                          color: Colors.deepPurple.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        map["title"].toString(),
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.9,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        df.format(
                          DateTime.parse(
                            map["registrationDate"].toString(),
                          ),
                        ),
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.9,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: size,
              ),
              Text(
                "Descripción",
                style: GoogleFonts.roboto(
                  fontSize: size * 0.9,
                  color: Colors.deepPurple.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: size * 0.5,
              ),
              Text(
                map["description"].toString(),
                style: GoogleFonts.roboto(
                  fontSize: size * 0.9,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
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
