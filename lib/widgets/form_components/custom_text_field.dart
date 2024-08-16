import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? placeholder;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.placeholder,
    this.obscureText,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null ? Text(label!, style: const TextStyle(fontWeight: FontWeight.w500),) : Container(),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText ?? false,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: placeholder ?? 'Insira um valor',
            hintStyle: const TextStyle(fontWeight: FontWeight.w300),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        )
      ],
    );
  }
}
