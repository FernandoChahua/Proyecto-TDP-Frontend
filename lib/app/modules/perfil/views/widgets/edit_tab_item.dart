import 'package:flutter/material.dart';

class EditTabItem extends StatelessWidget {
  const EditTabItem({
    Key? key,
    required this.size,
    required this.hintText,
    required this.textController,
  }) : super(key: key);

  final double size;
  final String hintText;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: size, bottom: size, right: size),
      child: TextFormField(
        controller: textController,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black45, fontSize: size * 0.8),
        ),
      ),
    );
  }
}
