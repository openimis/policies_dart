import 'package:app/widgets/layout/components/layout_padding.dart';
import 'package:app/widgets/layout/components/menu_bar.dart';
import 'package:flutter/material.dart';
import 'components/app_bar.dart';

class StandardLayout extends StatelessWidget {
  /// you can add more fields that meet your needs
  final Widget child;
  final String title;
  final bool resizeToAvoidBottomInset;
  final bool hasDrawer;
  final bool hasPadding;

  const StandardLayout({
    Key? key,
    required this.title,
    required this.child,
    this.resizeToAvoidBottomInset = true,
    this.hasDrawer = false,
    this.hasPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: (hasDrawer) ? MenuBar() : null,
      appBar: MyAppBar(
        title: title,
        hasDrawer: hasDrawer,
      ),
      body: hasPadding ? Layout_Padding(child: child) : child,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
