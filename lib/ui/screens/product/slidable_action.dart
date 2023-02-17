import 'package:demo_splash_screen/resources/all_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: camel_case_types, must_be_immutable
class Slidable_Action extends StatefulWidget {
  String lable;
  IconData icon;
  Slidable_Action({super.key, required this.lable, required this.icon});

  @override
  State<Slidable_Action> createState() => _Slidable_ActionState();
}

// ignore: camel_case_types
class _Slidable_ActionState extends State<Slidable_Action> {
  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      label: widget.lable,
      backgroundColor: AllColors.slidable,
      icon: widget.icon,
      foregroundColor: AllColors.maincolor,
      onPressed: (context) {},
    );
  }
}
