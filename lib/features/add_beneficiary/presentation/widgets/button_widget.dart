import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final bool isLoading;
  final String title;
  final void Function() onPressed;
  const ButtonWidget(
      {super.key,
      required this.isLoading,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: isLoading
          ? const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(title),
    );
  }
}
