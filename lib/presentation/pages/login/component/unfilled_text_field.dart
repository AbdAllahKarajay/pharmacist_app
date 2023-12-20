import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnfilledTextField extends StatelessWidget {
  const UnfilledTextField(
      {Key? key,
      required this.color,
      required this.icon,
      required this.controller,
      required this.hintText,
      this.obscure = false,
      this.inputFormatters, this.keyboardType})
      : super(key: key);
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Color color;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          TextField(
            controller: controller,
            obscureText: obscure,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: color)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: color)),
              hintText: hintText,
              hintStyle: TextStyle(color: color),
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: color),
            cursorColor: color,
          ),
        ],
      ),
    );
  }
}
