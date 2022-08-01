import 'package:flutter/material.dart';

class OpenImisButton extends StatelessWidget {
  OpenImisButton({
    required this.buttonText,
    required this.onPress,
    this.icon,
  });

  final void Function()? onPress;
  final String buttonText;
  final IconData? icon;

  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      ),
      child: Wrap(
        children: [
          if (icon != null) ...{
            Icon(
              icon,
              color: Colors.white,
              size: 24.0,
            ),
          },
          SizedBox(
            width: 15,
          ),
          Text(
            buttonText,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
