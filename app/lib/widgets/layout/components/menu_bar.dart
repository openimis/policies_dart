import 'package:app/pages/home.dart';
import 'package:app/pages/login.dart';
import 'package:app/pages/select_language.dart';
import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    child: Icon(Icons.account_circle_sharp, size: 70),
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.read<AuthLogic>().getCurrentUsername() ?? " ",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        Text(
                          context.read<AuthLogic>().getCurrentAuthHost() ?? " ",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text(AppLocalizations.of(context).home),
            onTap: () {
              Navigator.pushNamed(
                context,
                HomeScreen.routeName,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(AppLocalizations.of(context).language),
            onTap: () {
              Navigator.pushNamed(
                context,
                SelectLanguageScreen.routeName,
              );
            },
          ),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(AppLocalizations.of(context).logout),
              onTap: () async {
                context.read<AuthLogic>().logout();
              }),
          ListTile(title: Text(AppLocalizations.of(context).release))
        ],
      ),
    );
  }
}
