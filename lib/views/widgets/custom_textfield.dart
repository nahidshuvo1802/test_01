
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObs;
  const CustomTextField({super.key, required this.controller, required this.hint, this.isObs = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObs,
      decoration: InputDecoration(hintText: hint, border: const OutlineInputBorder()),
    );
  }
}