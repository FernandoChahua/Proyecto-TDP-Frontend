import 'package:ayuda_mujer/app/utils/widgets/date_item.dart';
import 'package:ayuda_mujer/app/modules/sign_up/views/widgets/tab_item.dart';
import 'package:ayuda_mujer/app/modules/sign_up/views/widgets/tab_label_item.dart';
import 'package:ayuda_mujer/app/utils/widget_size.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    final double size = defaultSize(context);
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {}
          });
          return Scaffold(
            appBar: AppBar(
              title: const Text('REGISTRO DE CUENTA'),
              centerTitle: true,
              bottom: const TabBar(
                tabs: [
                  Tab(text: "Víctima"),
                  Tab(
                    text: "Especialista",
                  )
                ],
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.deepPurpleAccent, Colors.blueAccent],
                  ),
                ),
              ),
            ),
            body: Obx(
              () {
                return controller.loading.value
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
                    : GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: TabBarView(
                          children: [
                            Obx(
                              () => Padding(
                                padding: EdgeInsets.only(top: size),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: InkWell(
                                              onTap: () {
                                                controller.anonimo.value =
                                                    !controller.anonimo.value;
                                              },
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Icon(
                                                        Icons.person_outline,
                                                        size: size * 2,
                                                        color:
                                                            Colors.deepPurple),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      "¿Desea registrarse como usuario anónimo?",
                                                      style: TextStyle(
                                                          fontSize: size * 0.7,
                                                          color: Colors
                                                              .deepPurple),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Checkbox(
                                                      value: controller
                                                          .anonimo.value,
                                                      onChanged: (bool? v) {
                                                        controller
                                                                .anonimo.value =
                                                            !controller
                                                                .anonimo.value;
                                                      },
                                                      fillColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .deepPurple),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TabLabelItem(
                                        size: size,
                                        labeltext: "NOMBRE",
                                        flag: controller.anonimo.value,
                                      ),
                                      TabItem(
                                        size: size,
                                        hintText: "Ingresa tu nombre",
                                        textController:
                                            controller.nombreController,
                                        obscure: false,
                                        flag: controller.anonimo.value,
                                      ),
                                      TabLabelItem(
                                        size: size,
                                        labeltext: "APELLIDO",
                                        flag: controller.anonimo.value,
                                      ),
                                      TabItem(
                                        size: size,
                                        hintText: "Ingresa tus apellidos",
                                        textController:
                                            controller.apellidoController,
                                        obscure: false,
                                        flag: controller.anonimo.value,
                                      ),
                                      TabLabelItem(
                                        size: size,
                                        labeltext: "FECHA DE NACIMIENTO",
                                      ),
                                      DateItem(
                                        size: size,
                                        controller: controller.fechaController,
                                      ),
                                      TabLabelItem(
                                        size: size,
                                        labeltext: "CORREO",
                                      ),
                                      TabItem(
                                        size: size,
                                        hintText: "Ingresa Correo *",
                                        textController:
                                            controller.usernameController,
                                        obscure: false,
                                      ),
                                      TabLabelItem(
                                        size: size,
                                        labeltext: "CONTRASEÑA",
                                      ),
                                      TabItem(
                                        size: size,
                                        hintText: "Ingresa contraseña *",
                                        textController:
                                            controller.passwordController,
                                        obscure: true,
                                      ),
                                      SizedBox(
                                        height: size,
                                      ),
                                      Center(
                                        child: SizedBox(
                                          width: size * 13,
                                          height: size * 2.3,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              await controller.signUpUser();
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.deepPurpleAccent
                                                          .withAlpha(190)),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          size),
                                                ),
                                              ),
                                            ),
                                            child: Text("REGISTRAR CUENTA",
                                                style: TextStyle(
                                                    fontSize: size * 0.9)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: size),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TabLabelItem(
                                      size: size,
                                      labeltext: "NOMBRE",
                                    ),
                                    TabItem(
                                      size: size,
                                      hintText: "Ingresa tu nombre",
                                      textController:
                                          controller.nombreController,
                                      obscure: false,
                                    ),
                                    TabLabelItem(
                                      size: size,
                                      labeltext: "APELLIDO",
                                    ),
                                    TabItem(
                                      size: size,
                                      hintText: "Ingresa tus apellidos",
                                      textController:
                                          controller.apellidoController,
                                      obscure: false,
                                    ),
                                    TabLabelItem(
                                      size: size,
                                      labeltext: "FECHA DE NACIMIENTO",
                                    ),
                                    DateItem(
                                      size: size,
                                      controller: controller.fechaController,
                                    ),
                                    TabLabelItem(
                                      size: size,
                                      labeltext: "CERTIFICADO",
                                    ),
                                    TabItem(
                                      function: () async {
                                        controller.loading.value = true;
                                        await controller.pickFile();
                                        controller.loading.value = false;
                                        if (controller.fileName.value != "") {
                                          controller.adjuntoController.text =
                                              controller.fileName.value;
                                        }
                                      },
                                      size: size,
                                      hintText: "Adjuntar Certificado",
                                      textController:
                                          controller.adjuntoController,
                                      obscure: false,
                                    ),
                                    TabLabelItem(
                                      size: size,
                                      labeltext: "ESPECIALISTA EN",
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size),
                                      child: DropdownButton(
                                        value: controller.category.value,
                                        focusColor: Colors.deepPurpleAccent,
                                        hint:
                                            const Text("Selecciona categoría"),
                                        onChanged: (String? value) {
                                          controller.category.value = value!;
                                        },
                                        items: controller.items
                                            .map((e) => DropdownMenuItem(
                                                value: e, child: Text(e)))
                                            .toList(),
                                      ),
                                    ),
                                    TabLabelItem(
                                      size: size,
                                      labeltext: "Correo",
                                    ),
                                    TabItem(
                                      size: size,
                                      hintText: "Ingresa correo *",
                                      textController:
                                          controller.usernameController,
                                      obscure: false,
                                    ),
                                    TabLabelItem(
                                      size: size,
                                      labeltext: "CONTRASEÑA",
                                    ),
                                    TabItem(
                                      size: size,
                                      hintText: "Ingresa contraseña *",
                                      textController:
                                          controller.passwordController,
                                      obscure: true,
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: size * 13,
                                        height: size * 2.3,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await controller.signUpSpecialist();
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(Colors
                                                    .deepPurpleAccent
                                                    .withAlpha(190)),
                                            /*overlayColor:
                                                        MaterialStateProperty.all(
                                                            Colors.black12),*/
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(size),
                                              ),
                                            ),
                                          ),
                                          child: Text("REGISTRAR CUENTA",
                                              style: TextStyle(
                                                  fontSize: size * 0.9)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
          );
        },
      ),
    );
  }
}
