import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool? isLoading;

  const ButtonText(
      {super.key,
      required this.title,
      this.onPressed,
      this.isLoading,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton.icon(
        onPressed: isLoading == true ? null : onPressed,
        style: ButtonStyle(
            shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        )),
        icon: icon != null ? Icon(icon) : null,
        label:
            isLoading == true ? const CircularProgressIndicator() : Text(title),
      ),
    );
  }
}
