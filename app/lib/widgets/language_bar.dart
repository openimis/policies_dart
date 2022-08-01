import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageBar extends StatelessWidget {
  late Locale locale;

  @override
  Widget build(BuildContext context) {
    var locale;
    var width = 70.0;
    var height = 50.0;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: Image.asset('assets/icon/german.png',
                  width: width, height: height),
              iconSize: 50,
              onPressed: () {
                locale = context
                    .findAncestorWidgetOfExactType<MaterialApp>()
                    ?.supportedLocales;
                Get.updateLocale(locale[1]);
              }),
          IconButton(
            icon: Image.asset('assets/icon/english.png',
                width: width, height: height),
            iconSize: 50,
            onPressed: () {
              locale = context
                  .findAncestorWidgetOfExactType<MaterialApp>()
                  ?.supportedLocales;
              Get.updateLocale(locale[0]);
            },
          ),
        ]);
  }
}
