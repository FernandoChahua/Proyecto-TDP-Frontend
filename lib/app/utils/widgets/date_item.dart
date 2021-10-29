import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateItem extends StatelessWidget {
  const DateItem({
    Key? key,
    required this.size,
    required this.controller,
  }) : super(key: key);

  final double size;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    var df = DateFormat('yyyy-MM-dd');
    return Padding(
      padding: EdgeInsets.only(left: size, bottom: size, right: size),
      child: TextFormField(
        controller: controller,
        onTap: () async {
          final DateTime date = DateTime.now();
          FocusScope.of(context).requestFocus(FocusNode());
          final DateTime? picked = await showDatePicker(
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime.now(),
            context: context,
            initialDate: date,
          );
          if (picked != null) controller.text = df.format(picked);
        },
        decoration: InputDecoration(
          hintText: "Selecciona tu fecha de nacimiento",
          icon: const Icon(Icons.calendar_today),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          hintStyle: TextStyle(color: Colors.black45, fontSize: size * 0.8),
        ),
      ),
    );
  }
}
