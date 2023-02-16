import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:flutter/material.dart';

class TextFormFeild1 extends StatefulWidget {
  TextEditingController? controller;
  String? labelText;
  String? hintText;
  final bool obscureText;
  String? Function(dynamic value) validator;
  TextFormFeild1({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    required this.obscureText,
    required this.validator,
  });

  @override
  State<TextFormFeild1> createState() => _TextFormFeild1State();
}

class _TextFormFeild1State extends State<TextFormFeild1> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      obscureText:widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        floatingLabelStyle: TextStyle(color: AllColors.maincolor),
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AllColors.maincolor),
        ),
      ),
      validator: widget.validator,
    );
  }
}
