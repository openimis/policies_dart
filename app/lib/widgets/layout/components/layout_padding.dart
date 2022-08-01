import 'package:flutter/material.dart';

class Layout_Padding extends StatelessWidget {
  const Layout_Padding({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: this.child,
        ),
      ),
    );
  }
}
