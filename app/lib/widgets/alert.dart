import 'package:flutter/material.dart';

class openImisAlert extends StatelessWidget {
  openImisAlert({
    required this.alertText,
  });

  final String alertText;

  Widget build(BuildContext context) {
    return SnackBar(
      content: new Text(alertText),
      duration: new Duration(seconds: 7),
      backgroundColor: Theme.of(context).colorScheme.error,
    );
  }
}
