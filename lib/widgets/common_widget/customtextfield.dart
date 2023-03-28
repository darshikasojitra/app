import 'package:flutter/material.dart';
import 'package:demo_splash_screen/resources/resources.dart';

// ignore: must_be_immutable
class CustomTextFields extends StatefulWidget {
  TextEditingController? controller;
  String? labelText;
  String? hintText;
  TextStyle? hintStyle;
  final bool obscureText;
  Widget? suffixIcon;
  EdgeInsets? contentPadding;
  InputBorder? focusedBorder;
  String? Function(dynamic value) validator;
  CustomTextFields(
      {super.key,
      this.controller,
      this.hintText,
      this.hintStyle,
      this.labelText,
      required this.obscureText,
      this.suffixIcon,
      this.focusedBorder,
      required this.validator, EdgeInsets? contentPadding,});
  @override
  State<CustomTextFields> createState() => _CustomTextFieldsState();
}

class _CustomTextFieldsState extends State<CustomTextFields> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        labelText: widget.labelText,
        floatingLabelStyle: TextStyle(color: AllColors.maincolor),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        border: const OutlineInputBorder(),
        //focusedBorder: widget.focusedBorder,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AllColors.maincolor),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AllColors.maincolor)),
            suffixIcon: widget.suffixIcon,
      ),
      validator: widget.validator,
    );
  }
}
