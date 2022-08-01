import 'package:app/pages/home.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/drop_down.dart';
import 'package:app/widgets/language_bar.dart';
import 'package:app/widgets/layout/standard_layout.dart';
import 'package:app/widgets/text_input.dart';
import 'package:business_logic/business_logic.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = "", password = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedServer = '';

  @override
  void initState() {
    final prefs = context.read<SharedPreferences>();
    final _server =
        context.read<AuthLogic>().servers.map((e) => e.server).toList();
    selectedServer = prefs.getString('server') ?? _server[0];
    if (!_server.contains(selectedServer)) {
      selectedServer = _server[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(
                    child: Container(
                        width: 200,
                        height: 150,
                        child: Image.asset('assets/icon/icon.png')),
                  ),
                ),
                OpenImisTextInput(
                  text: AppLocalizations.of(context).user,
                  onSaved: (state) {
                    username = state ?? "";
                  },
                ),
                SizedBox(height: 12),
                OpenImisTextInput(
                  text: AppLocalizations.of(context).password,
                  onSaved: (state) {
                    password = state ?? "";
                  },
                  obscureText: true,
                ),
                SizedBox(height: 12),
                OpenImisButton(
                  onPress: _login,
                  icon: Icons.login_sharp,
                  buttonText: AppLocalizations.of(context).login,
                ),
                LanguageBar(),
                DropDown(
                  values: context
                      .read<AuthLogic>()
                      .servers
                      .map((e) => e.server)
                      .toList(),
                  selected: selectedServer,
                  onSelect: (server) {
                    context
                        .read<SharedPreferences>()
                        .setString('server', server);
                    context.read<AuthLogic>().selectedServer = context
                        .read<AuthLogic>()
                        .servers
                        .firstWhere((element) => element.server == server);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    _formKey.currentState?.save();

    if (username == "" || password == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: new Text(AppLocalizations.of(context).loginFieldsMissing),
          duration: new Duration(seconds: 10),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    try {
      AuthLogic nal = context.read<AuthLogic>();
      await nal.login(username, password);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          //TODO: Replace
          content: new Text(AppLocalizations.of(context).failed),
          duration: new Duration(seconds: 10),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
  }
}
