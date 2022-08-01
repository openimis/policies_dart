import 'package:app/main.dart';
import 'package:app/pages/login.dart';
import 'package:business_logic/business_logic.dart';
import 'package:fhir_openimis/fhir_openimis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginProtected extends StatelessWidget {
  final Widget child;

  LoginProtected(this.child);

  @override
  Widget build(BuildContext context) {
    AuthLogic notifyAuthLogic = context.read<AuthLogic>();
    return StreamBuilder<Authenticator?>(
      builder: (context, sna) {
        if (!sna.hasData || sna.hasError) {
          return LoginScreen();
        }

        return new FutureBuilder<Widget>(
          future: () async {
            final state = context.read<BusinessLogicState>();
            if (state.value == null) {
              final client =
                  FhirClient(notifyAuthLogic.selectedServer, sna.data!);
              BusinessLogic bl = await BusinessLogic.create(client,
                  "openIMIS-Implementation"); //TODO: make the insurer configurable
              state.value = bl;
            }
            return Provider.value(child: this.child, value: state.value);
          }(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if (snap.hasError) {
              return LoginScreen();
            }

            return snap.data!;
          },
        );
      },
      stream: notifyAuthLogic.getAuthenticatorStream(),
      initialData: notifyAuthLogic.getLastAuthenticator(),
    );
  }
}
