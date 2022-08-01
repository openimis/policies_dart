import 'package:app/pages/create_insuree.dart';
import 'package:app/pages/request_eligibility.dart';
import 'package:app/pages/search_insuree.dart';
import 'package:app/widgets/layout/standard_layout.dart';
import 'package:app/widgets/options_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      hasDrawer: true,
      title: AppLocalizations.of(context).appName,
      resizeToAvoidBottomInset: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OptionsField(
            title: AppLocalizations.of(context).addInsuree,
            icon: Icons.supervised_user_circle_outlined,
            color: Theme.of(context).colorScheme.secondary,
            textColor: Theme.of(context).colorScheme.onSecondary,
            routeName: CreateInsureeScreen.routeName,
            rows: 3,
          ),
          OptionsField(
            title: AppLocalizations.of(context).searchInsuree,
            icon: Icons.search,
            color: Theme.of(context).colorScheme.secondary,
            textColor: Theme.of(context).colorScheme.onSecondary,
            routeName: SearchInsureeScreen.routeName,
            rows: 3,
          ),
          OptionsField(
            title: AppLocalizations.of(context).eligibility,
            icon: Icons.list,
            color: Theme.of(context).colorScheme.secondary,
            textColor: Theme.of(context).colorScheme.onSecondary,
            routeName: RequestEligibilityScreen.routeName,
            rows: 3,
          )
        ],
      ),
    );
  }
}
