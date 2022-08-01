import 'package:app/pages/create_insuree.dart';
import 'package:app/pages/insuree.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/header.dart';
import 'package:app/widgets/layout/standard_layout.dart';
import 'package:app/widgets/list_tile_templates.dart';
import 'package:flutter/material.dart';
import 'package:business_logic/business_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:fhir_openimis/src/generated/resources/resources.dart';

class FamilyScreen extends StatelessWidget {
  static final String routeName = '/family/detail';
  late String id;

  @override
  Widget build(BuildContext context) {
    final businessLogic = context.read<BusinessLogic>();
    id = ModalRoute.of(context)!.settings.arguments as String;
    return StandardLayout(
      title: AppLocalizations.of(context).family,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OpenImisHeader(text: AppLocalizations.of(context).familyHead),
          FutureBuilder<OpenimisPatient>(
            future: businessLogic.getFamilyHead(id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListTileTemplates.Person(
                  context, snapshot.data!, businessLogic);
            },
          ),
          SizedBox(height: 12),
          OpenImisHeader(text: AppLocalizations.of(context).familyMember),
          Expanded(
            child: FutureBuilder<List<OpenimisPatient>>(
              future: businessLogic.getFamilyMembers(id),
              builder: ((context, snapshot) {
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 12,
                  ),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTileTemplates.Person(
                      context,
                      snapshot.data![index],
                      businessLogic,
                    );
                  },
                );
              }),
            ),
          ),
          SizedBox(height: 12),
          OpenImisButton(
            buttonText: AppLocalizations.of(context).addFamilyMember,
            onPress: () {
              Navigator.pushNamed(
                context,
                CreateInsureeScreen.routeName,
                arguments: id,
              );
            },
            icon: Icons.add,
          ),
        ],
      ),
    );
  }
}
