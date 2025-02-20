import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.onPressed, required this.text});

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.green[900],
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ));
  }
}
