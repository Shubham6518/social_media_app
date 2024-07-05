import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: TextField(
        controller: textEditingController, 
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          border: inputBorder,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(219, 214, 214, 1)),
          ),
          filled: true,
          contentPadding: const EdgeInsets.all(8),
          labelStyle: TextStyle(color: Colors.grey[500]),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500])
        ),
        keyboardType: textInputType,
        obscureText: isPass,
      ),
    );
  }
}