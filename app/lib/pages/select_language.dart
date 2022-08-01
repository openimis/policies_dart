import 'package:app/widgets/layout/standard_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class SelectLanguageScreen extends StatefulWidget {
  static final String routeName = '/select/language';

  SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  path(String local) {
    return "assets/icon/${local.toLowerCase()}.png";
  }

  // TODO: configure somewhere else
  final Map<Locale, String> _locales = {
    Locale('de', ''): 'assets/icon/german.png',
    Locale('en', ''): 'assets/icon/english.png',
  };

  int selected = 0;

  @override
  void initState() {
    selected = _locales.keys.toList().indexOf(Get.locale!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final length = _locales.keys.length;
    return StandardLayout(
      title: AppLocalizations.of(context).language,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: selected == index
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1,
                            ),
                          )
                        : null,
                    child: IconButton(
                      icon: Image.asset(_locales.values.elementAt(index)),
                      onPressed: () {
                        setState(() {
                          selected = index;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              child: Text(AppLocalizations.of(context).save, style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),
              onPressed: () {
                Get.updateLocale(_locales.keys.elementAt(selected));
              },
            ),
          ),
        ],
      ),
    );
  }
}
