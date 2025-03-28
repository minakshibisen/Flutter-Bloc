import 'package:flutter/material.dart';

class NeumorphicTextField extends StatefulWidget {
  final IconData icon;
  final String hint;
  final TextEditingController? controller;
  final bool obscureText;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const NeumorphicTextField({
    Key? key,
    required this.icon,
    required this.hint,
    this.controller,
    this.obscureText = false,
    this.errorText,
    this.onChanged,
  }) : super(key: key);

  @override
  _NeumorphicTextFieldState createState() => _NeumorphicTextFieldState();
}

class _NeumorphicTextFieldState extends State<NeumorphicTextField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) {
        setState(() {
          isFocused = focus;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: isFocused
              ? [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
            BoxShadow(color: Colors.white, blurRadius: 3, offset: Offset(-2, -2)),
          ]
              : [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
          ],
        ),
        child: TextField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: Colors.grey),
            hintText: widget.hint,
            border: InputBorder.none,
            errorText: widget.errorText,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
        ),
      ),
    );
  }
}
