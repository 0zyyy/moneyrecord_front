import 'package:flutter/material.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/utils/app_fonts.dart';

class FormWidget extends StatefulWidget {
  final String text;
  final bool hideText;
  final TextEditingController controller;
  final double border;
  final String label;
  const FormWidget(
      {Key? key,
      required this.text,
      this.hideText = false,
      required this.controller,
      this.border = 30,
      required this.label})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  // bool showPass = true;
  // Icon icons = Icon(Icons.remove_red_eye_sharp);
  // void _toggle() {
  //   setState(() {
  //     showPass = !showPass;
  //
  //   });
  // }
  //
  // IconData ngontol(){
  //   return !showPass ? Icons.remove_red_eye_sharp : Icons.remove_red_eye_outlined;
  // }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) => value == '' ? "Jangan kosong" : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.hideText,
      autofocus: false,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: AppFont.secondaryTextStyle,
        suffixIcon: Icon(Icons.add),
        filled: true,
        fillColor: AppColor.secondary,
        contentPadding: const EdgeInsets.all(20),
        hintText: widget.text,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(widget.border),
        ),
      ),
    );
  }
}
