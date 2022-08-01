import 'package:flutter/material.dart';

class OpenImisTextInput extends StatelessWidget {
  const OpenImisTextInput(
      {Key? key,
      required this.text,
      this.obscureText = false,
      this.onSaved = null,
      this.onComplete = null,
      this.controller = null})
      : super(key: key);

  final String text;
  final void Function(dynamic state)? onSaved;
  final void Function()? onComplete;
  final bool obscureText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: text,
      ),
      obscureText: this.obscureText,
      onSaved: onSaved,
      textInputAction: TextInputAction.next,
      autofocus: true,
      controller: controller,
    );
  }
}
