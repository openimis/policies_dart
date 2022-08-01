import 'package:app/config/themes.dart';
import 'package:app/pages/family.dart';
import 'package:app/pages/insuree.dart';
import 'package:app/pages/login.dart';
import 'package:app/pages/barcode_scanner.dart';
import 'package:app/pages/request_eligibility.dart';
import 'package:app/pages/select_language.dart';
import 'package:app/widgets/login_protected.dart';
import 'package:fhir_openimis/fhir_openimis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:business_logic/business_logic.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/create_insuree.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/pages/search_insuree.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class BusinessLogicState {
  BusinessLogic? value;
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  AuthLogic auth = AuthLogic(sharedPreferences: sharedPreferences, servers: [
    ResourceServer("demo.openimis.org", "/api/api_fhir_r4"),
    ResourceServer("release.openimis.org", "/api/api_fhir_r4")
  ]);
  Credentials? savedCredentials = auth.loadCredentialsFromPreferences();
  if (savedCredentials != null) {
    // Started with valid saved credentials
    auth.loginWithCredentials(savedCredentials);
  }

  FlutterNativeSplash.remove();
  runApp(
    MultiProvider(
      providers: [
        Provider<SharedPreferences>.value(value: sharedPreferences),
        Provider<AuthLogic>.value(value: auth),
        Provider<BusinessLogicState>.value(value: BusinessLogicState()),
      ],
      child: GetMaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''), // English, no country code
          Locale('de', ''), // German, no country code
        ],
        //supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('en', ''),
        fallbackLocale: Locale('en', ''),
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context).appName,
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => LoginProtected(HomeScreen()),
          CreateInsureeScreen.routeName: (_) =>
              LoginProtected(CreateInsureeScreen()),
          SearchInsureeScreen.routeName: (_) =>
              LoginProtected(SearchInsureeScreen()),
          RequestEligibilityScreen.routeName: (_) =>
              LoginProtected(RequestEligibilityScreen()),
          SelectLanguageScreen.routeName: (_) =>
              LoginProtected(SelectLanguageScreen()),
          FamilyScreen.routeName: (_) => LoginProtected(FamilyScreen()),
          InsureeScreen.routeName: (_) => LoginProtected(InsureeScreen()),
          BarcodeScanner.routeName: (_) => LoginProtected(BarcodeScanner()),
        },
        navigatorKey: navigatorKey,
      ),
    ),
  );
}
