import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    Key? key,
    required this.size,
    required this.hintText,
    required this.textController,
    required this.obscure,
    this.flag,
    this.function,
  }) : super(key: key);

  final bool? flag;
  final double size;
  final bool obscure;
  final String hintText;
  final TextEditingController textController;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    final bool visibilidad = flag ?? false;
    return AnimatedCrossFade(
      crossFadeState:
          !visibilidad ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Padding(
        padding: EdgeInsets.only(left: size, bottom: size, right: size),
        child: TextFormField(
          onTap: function ?? () {},
          obscureText: obscure,
          controller: textController,
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black45, fontSize: size * 0.8),
          ),
        ),
      ),
      secondChild: const SizedBox(
        width: 500,
      ),
      duration: const Duration(milliseconds: 500),
      firstCurve: Curves.bounceIn,
    );
  }
}
