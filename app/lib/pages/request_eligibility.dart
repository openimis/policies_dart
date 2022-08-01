import 'dart:async';
import 'dart:math';
import 'package:app/pages/barcode_scanner.dart';
import 'package:app/widgets/layout/standard_layout.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:business_logic/business_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class RequestEligibilityScreen extends StatefulWidget {
  static final String routeName = '/eligibility';

  @override
  State<RequestEligibilityScreen> createState() =>
      _RequestEligibilityScreenState();
}

class _RequestEligibilityScreenState extends State<RequestEligibilityScreen> {
  String _insureeId = "";
  RegExp _eligibilitySearch = RegExp(".*");
  final Set<Eligibility> _eligibilities = {};
  final Map<Eligibility, bool?> _coveredEligibilities = {};
  bool? _isInsured = null;
  late RestartableTimer _checkForInsuranceTimer;
  BusinessLogic? _businessLogic;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _businessLogic = Provider.of<BusinessLogic>(context, listen: false);
    _businessLogic!.getAllEligibilities().listen((event) {
      Map<Eligibility, bool?> entries =
          Map.fromEntries(event.map((e) => MapEntry(e, null)));
      setState(() {
        _eligibilities.addAll(event);
        entries.forEach((key, value) {
          _coveredEligibilities.putIfAbsent(key, () => value);
        });
      });
      _checkForInsuranceTimer = RestartableTimer(Duration(milliseconds: 500),
          () async => await _checkInsurance(_insureeId, false));
      _checkForInsuranceTimer.cancel();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eligibilities = _eligibilities
        .where((e) => _eligibilitySearch.hasMatch(e.displayName))
        .toList();

    return StandardLayout(
      title: AppLocalizations.of(context).eligibility,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).insureeId,
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => setState(() {
                    _insureeId = value;
                    _isInsured = null;
                    _coveredEligibilities.updateAll((key, value) => null);
                    _checkForInsuranceTimer.reset();
                  }),
                  onSubmitted: (value) {
                    _checkForInsuranceTimer.cancel();
                    _checkInsurance(_insureeId, true);
                  },
                  controller: _searchController,
                ),
              ),
              if (defaultTargetPlatform == TargetPlatform.android ||
                  defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.macOS) ...{
                IconButton(
                  onPressed: () async {
                    final barcode = (await Navigator.pushNamed(
                                context, BarcodeScanner.routeName))
                            ?.toString() ??
                        _searchController.text;
                    setState(() {
                      _insureeId = barcode;
                      _searchController.text = barcode;
                      _checkForInsuranceTimer.cancel();
                      _checkInsurance(_insureeId, true);
                    });
                  },
                  icon: Icon(Icons.camera_alt),
                ),
              }
            ],
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).eligibility,
            ),
            onChanged: (value) => setState(() {
              _eligibilitySearch = RegExp(".*$value.*", caseSensitive: false);
            }),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                  child: Text(
                AppLocalizations.of(context).isInsured,
                textScaleFactor: 2,
              )),
              _toStatusIcon(_isInsured),
            ],
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              separatorBuilder: (context, index) => SizedBox(height: 0),
              itemCount: eligibilities.length,
              itemBuilder: (context, index) {
                final eligibility = eligibilities.elementAt(index);
                return ElevatedButton(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          eligibility.displayName,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _toStatusIcon(_coveredEligibilities[eligibility]),
                    ],
                  ),
                  onPressed: _isInsured ?? false
                      ? () => _requestEligibility(eligibility)
                      : null,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _checkInsurance(String insureeId, bool isSubmit) async {
    try {
      bool result = await _businessLogic!.checkInsurance(_insureeId);

      if (insureeId != _insureeId) {
        //Id changed while waiting for the result -> The result is outdated
        return;
      }

      setState(() => _isInsured = result);
    } catch (e, stackTrace) {
      _handleError(e, stackTrace, isSubmit);
    }
  }

  Future<void> _requestEligibility(Eligibility eligibility) async {
    try {
      bool result =
          await _businessLogic!.requestItemEligibility(_insureeId, eligibility);

      setState(() => _coveredEligibilities[eligibility] = result);
    } catch (e, stackTrace) {
      _handleError(e, stackTrace);
    }
  }

  void _handleError(Object e,
      [StackTrace? stackTrace, bool displayError = true]) {
    print("Encountered an exception at: $stackTrace");
    print("Exception data: $e");

    if (!displayError) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: new Text(AppLocalizations.of(context).failed),
        duration: new Duration(seconds: 3),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  Widget _toStatusIcon(bool? value) {
    return Icon(value == null
        ? Icons.question_mark
        : value
            ? Icons.thumb_up
            : Icons.thumb_down);
  }
}
