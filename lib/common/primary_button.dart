import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final BuildContext context;
  final bool isLoading;

  const PrimaryButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.context,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 150),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}
