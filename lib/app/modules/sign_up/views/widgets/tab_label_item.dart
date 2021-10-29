import 'package:flutter/material.dart';

class TabLabelItem extends StatelessWidget {
  const TabLabelItem({
    Key? key,
    required this.size,
    required this.labeltext,
    this.flag,
  }) : super(key: key);

  final double size;
  final String labeltext;
  final bool? flag;

  @override
  Widget build(BuildContext context) {
    bool visibilidad = flag ?? false;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size),
      child: AnimatedCrossFade(
        crossFadeState:
            !visibilidad ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: SizedBox(
          width: 200,
          child: Text(
            labeltext,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: size * 0.9, color: Colors.black),
          ),
        ),
        secondChild: const SizedBox(
          width: 200,
        ),
        duration: const Duration(milliseconds: 500),
        firstCurve: Curves.bounceIn,
      ),
    );
  }
}
