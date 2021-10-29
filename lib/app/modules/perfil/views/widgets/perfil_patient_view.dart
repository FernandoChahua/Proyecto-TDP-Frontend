import 'package:ayuda_mujer/app/modules/perfil/controllers/perfil_controller.dart';
import 'package:ayuda_mujer/app/modules/perfil/views/widgets/edit_tab_item.dart';
import 'package:ayuda_mujer/app/utils/constants/profile_image.dart';
import 'package:ayuda_mujer/app/utils/widget_size.dart';
import 'package:ayuda_mujer/app/utils/widgets/date_item.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class PerfilPatientView extends GetView<PerfilController> {
  const PerfilPatientView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = defaultSize(context);
    return Container(
      padding: EdgeInsets.all(size),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: size * 3,
              backgroundColor: Colors.grey.shade100,
              child: Image.network(
                ImageGeneratonr.getImage(
                  controller.user["email"].toString(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size,
          ),
          Text(
            "NOMBRES:",
            style: GoogleFonts.roboto(
                fontSize: size * 0.9, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: size * 0.3,
          ),
          Text(
            controller.user["firstName"].toString(),
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
            controller.user["lastName"].toString(),
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
            controller.user["email"].toString(),
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
                controller.user["bornDate"].toString(),
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
                controller.user["createdAt"].toString(),
                style: GoogleFonts.roboto(fontSize: size * 0.9),
              ),
            ],
          ),
          SizedBox(
            height: size * 2,
          ),
          Center(
            child: SizedBox(
              width: size * 13,
              height: size * 2.3,
              child: ElevatedButton(
                onPressed: () {
                  controller.nameController.text =
                      controller.user["firstName"].toString();
                  controller.lastNameController.text =
                      controller.user["lastName"].toString();
                  controller.fechaController.text =
                      controller.user["bornDate"].toString();
                  Get.defaultDialog(
                    title: "Editar Perfil",
                    buttonColor: Colors.deepPurpleAccent,
                    confirmTextColor: Colors.white,
                    cancelTextColor: Colors.black,
                    onCancel: () {},
                    onConfirm: () async {
                      Get.back();
                      await controller.updatePatientInfo();
                    },
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size),
                          child: Text(
                            "Nombre",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: size * 0.9, color: Colors.black),
                          ),
                        ),
                        EditTabItem(
                          size: size,
                          hintText: "Ingresar nuevo nombre",
                          textController: controller.nameController,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size),
                          child: Text(
                            "Apellido",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: size * 0.9, color: Colors.black),
                          ),
                        ),
                        EditTabItem(
                            size: size,
                            hintText: "Ingresar nuevo apellido",
                            textController: controller.lastNameController),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size),
                          child: Text(
                            "Fecha de Nacimiento",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: size * 0.9, color: Colors.black),
                          ),
                        ),
                        DateItem(
                          size: size,
                          controller: controller.fechaController,
                        )
                      ],
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.deepPurpleAccent.withAlpha(190)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size),
                    ),
                  ),
                ),
                child: Text("EDITAR PERFIL",
                    style: GoogleFonts.roboto(fontSize: size * 0.9)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
