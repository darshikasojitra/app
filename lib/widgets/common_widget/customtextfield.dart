import 'package:flutter/material.dart';
import 'package:demo_splash_screen/resources/resources.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextFields extends StatefulWidget {
  TextEditingController? controller;
  int? maxLines;
  Color? cursorColor;
  TextInputType? keyboardType;
  TextAlign? textAlign;
  String? initialValue;
  String? labelText;
  FocusNode? focusNode;
  List<TextInputFormatter>? inputFormatters;
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
      this.maxLines,
      this.keyboardType,
      this.cursorColor,
      this.textAlign,
      this.inputFormatters,
      this.initialValue,
     this.focusNode,
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
  final bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      focusNode: widget.focusNode,
      maxLines: widget.maxLines,
      inputFormatters: widget.inputFormatters,
      initialValue: widget.initialValue,
      //textAlign: widget.textAlign,
      cursorColor: AllColors.maincolor,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        labelText: widget.labelText,
        floatingLabelStyle: TextStyle(color: AllColors.maincolor),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        border: const OutlineInputBorder(),
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
