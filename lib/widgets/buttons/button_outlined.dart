import 'package:flutter/material.dart';

class ButtonOutlined extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool? isLoading;

  const ButtonOutlined(
      {super.key, required this.title, this.onPressed, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: isLoading == true ? null : onPressed,
        style: ButtonStyle(
            shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        )),
        child:
            isLoading == true ? const CircularProgressIndicator() : Text(title),
      ),
    );
  }
}
