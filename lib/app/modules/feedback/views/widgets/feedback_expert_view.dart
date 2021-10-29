import 'package:ayuda_mujer/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:ayuda_mujer/app/utils/widget_size.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class FeedbackExpertView extends GetView<FeedbackController> {
  const FeedbackExpertView({Key? key}) : super(key: key);

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
          : SingleChildScrollView(
              child: Container(
                //color: Colors.redAccent,
                padding: EdgeInsets.all(size),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TÍTULO",
                      style: GoogleFonts.roboto(
                          fontSize: size * 0.8,
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size / 2,
                    ),
                    Container(
                      padding: EdgeInsets.all(size / 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9DAEFB),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              offset: const Offset(0, 40),
                              blurRadius: 80),
                        ],
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: size),
                        child: TextFormField(
                          controller: controller.titleController,
                          decoration: InputDecoration(
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: size * 0.8,
                                  fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                              hintText: "Ingresa el Título del feedback"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size,
                    ),
                    Text(
                      "DESCRIPCIÓN",
                      style: GoogleFonts.roboto(
                          fontSize: size * 0.8,
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size / 2,
                    ),
                    Container(
                      padding: EdgeInsets.all(size / 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9DAEFB),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              offset: const Offset(0, 40),
                              blurRadius: 80),
                        ],
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: size),
                        child: TextFormField(
                          controller: controller.descriptionController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.roboto(
                                  fontSize: size * 0.8,
                                  fontWeight: FontWeight.w500),
                              hintText: "Redacta la descripción del feedback"),
                          keyboardType: TextInputType.multiline,
                          maxLines: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: size * 13,
                        height: size * 2.3,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.sendFeed();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepPurpleAccent),
                            overlayColor:
                                MaterialStateProperty.all(Colors.black12),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                          ),
                          child: Text(
                            "ENVIAR",
                            style: GoogleFonts.roboto(fontSize: size * 0.9),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
