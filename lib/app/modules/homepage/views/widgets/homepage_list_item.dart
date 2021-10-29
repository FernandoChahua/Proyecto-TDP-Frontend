import 'package:ayuda_mujer/app/utils/widget_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomepageListItem extends StatelessWidget {
  const HomepageListItem({
    Key? key,
    required this.label,
    required this.child,
  }) : super(key: key);
  final String label;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final double size = defaultSize(context);
    return Row(
      children: [
        /*  Container(
          height: 11,
          width: 11,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
        ) */
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.roboto(
                color: Colors.black, height: 1.4, fontSize: size * 0.9),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        child
      ],
    );
  }
}
