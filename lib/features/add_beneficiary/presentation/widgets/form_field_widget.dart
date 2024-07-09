import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final String? hint;
  final String? label;
  final void Function(String)? onChanged;

  const FormFieldWidget({
    super.key,
    required this.controller,
    required this.errorText,
    this.hint,
    this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
      ),
    );
  }
}
