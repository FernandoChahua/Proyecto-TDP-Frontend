import 'package:ayuda_mujer/app/utils/widgets/custom_app_bar.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          appBar: customAppBar(),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus( FocusNode());
            },
            child: Center(
              child: SafeArea(
                child: IndexedStack(
                  index: controller.tabIndex,
                  children: controller.widgets,
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            onTap: controller.chaangeTabIndex,
          ),
        );
      },
    );
  }
}

class CustomBottomNavigationBar extends GetView<HomeController> {
  const CustomBottomNavigationBar({Key? key, required this.onTap})
      : super(key: key);

  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
          colors: [Colors.deepPurpleAccent[100]!, Colors.blueAccent[100]!],
        ),
      ),
      child: BottomNavigationBar(
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.deepPurple[900],
        currentIndex: controller.tabIndex,
        backgroundColor: Colors.transparent,
        items: controller.tabs,
      ),
    );
  }
}
