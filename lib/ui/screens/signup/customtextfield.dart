import 'package:flutter/material.dart';
import 'package:demo_splash_screen/resources/resources.dart';

// ignore: must_be_immutable
class CustomTextFields extends StatefulWidget {
  TextEditingController? controller;
  String? labelText;
  String? hintText;
  final bool obscureText;
  String? Function(dynamic value) validator;
  CustomTextFields(
      {super.key,
      this.controller,
      this.hintText,
      this.labelText,
      required this.obscureText,
      required this.validator});
  @override
  State<CustomTextFields> createState() => _CustomTextFieldsState();
}

class _CustomTextFieldsState extends State<CustomTextFields> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      obscureText: widget.obscureText,
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
