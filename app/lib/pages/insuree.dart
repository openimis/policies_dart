import 'package:app/widgets/button.dart';
import 'package:app/widgets/header.dart';
import 'package:app/widgets/layout/standard_layout.dart';
import 'package:app/widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:business_logic/business_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fhir_openimis/src/generated/resources/resources.dart';
import 'package:get/get.dart';
import 'family.dart';
import 'package:provider/provider.dart';

class InsureeScreen extends StatelessWidget {
  static final String routeName = '/insuree/detail/';
  late String id;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final labels = [
      "ID",
      AppLocalizations.of(context).birthDate,
      AppLocalizations.of(context).gender,
      AppLocalizations.of(context).state,
      AppLocalizations.of(context).district,
      AppLocalizations.of(context).city
    ];
    final businessLogic = context.read<BusinessLogic>();

    return StandardLayout(
      title: AppLocalizations.of(context).insuree,
      child: FutureBuilder<OpenimisPatient>(
        future: businessLogic.getPerson(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final patient = snapshot.data!;
          final address = patient.address!.first;
          final id = patient.identifier.last.value;
          final familyId = patient.extension?.last
              .toString()
              .split("value: ")
              .last
              .split(",")
              .first;
          final insureeDetails = [
            id,
            patient.birthDate.toString(),
            patient.gender.name.toLowerCase().substring(6),
            address.state,
            address.district,
            address.city
          ];
          for (int i = 0; i < insureeDetails.length; i++) {
            if (insureeDetails[i] == null) {
              insureeDetails[i] = AppLocalizations.of(context).dataNotAvailable;
            }
          }
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OpenImisHeader(
                text:
                    "${patient.name.first.family}, ${patient.name.first.given!.join(" ")}",
              ),
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 12,
                  ),
                  itemCount: labels.length,
                  itemBuilder: (context, index) {
                    return OpenImisListTile(
                      header: insureeDetails[index],
                      bodyText: labels[index],
                      onPress: () {},
                      icon: null,
                    );
                  },
                ),
              ),
              OpenImisButton(
                buttonText: AppLocalizations.of(context).goToFamily,
                onPress: () {
                  Navigator.pushReplacementNamed(
                    context,
                    FamilyScreen.routeName,
                    arguments: familyId,
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
