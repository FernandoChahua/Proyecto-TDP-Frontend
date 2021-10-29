import 'package:ayuda_mujer/app/utils/widget_size.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    final double size = defaultSize(context);
    return Scaffold(
        body: Obx(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Últimas Noticias:",
                    style: GoogleFonts.roboto(
                      fontSize: size * 0.9,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: size,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.newsList.length,
                      itemBuilder: (context, index) {
                        final map = controller.newsList[index];

                        return NewsItem(
                          map: map,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    ));
  }
}

class NewsItem extends StatelessWidget {
  const NewsItem({Key? key, required this.map}) : super(key: key);
  final dynamic map;
  @override
  Widget build(BuildContext context) {
    final double size = defaultSize(context);
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.defaultDialog(
              title: "Aviso",
              content:
                  const Text("Se le redirigirá a la página de la noticia."),
              onConfirm: () async {
                final String url = map["urlNews"].toString();
                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: false,
                  );
                } else {
                  throw 'Could not launch $url';
                }
                Get.back();
              },
              onCancel: () {},
              buttonColor: Colors.deepPurpleAccent,
              confirmTextColor: Colors.white,
              cancelTextColor: Colors.black,
            );
          },
          child: Container(
            constraints: BoxConstraints(minHeight: size * 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    map["publicationDate"].toString(),
                    style: GoogleFonts.roboto(
                      fontSize: size * 0.5,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        map["title"].toString(),
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.9,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        map["description"].toString(),
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.6,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 4,
                  child: Image.network(
                    map["urlImage"].toString(),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        const Divider(
          color: Colors.deepPurple,
          thickness: 1,
        ),
        const SizedBox(
          height: 3,
        ),
      ],
    );
  }
}
