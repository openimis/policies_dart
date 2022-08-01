import 'package:app/pages/family.dart';
import 'package:app/pages/insuree.dart';
import 'package:app/widgets/list_tile.dart';
import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:fhir_openimis/src/generated/resources/resources.dart';

class ListTileTemplates {
  static Widget Person(
      BuildContext context, OpenimisPatient person, BusinessLogic businessLogic,
      [bool toFamily = false]) {
    Function()? onPress = (toFamily)
        ? () {
            FocusScope.of(context).unfocus();
            Navigator.pushNamed(
              context,
              FamilyScreen.routeName,
              arguments: person.extension?.last
                  .toString()
                  .split("value: ")
                  .last
                  .split(",")
                  .first,
            );
          }
        : () {
            FocusScope.of(context).unfocus();
            Navigator.pushNamed(
              context,
              InsureeScreen.routeName,
              arguments: person.identifier.first.value,
            );
          };

    return OpenImisListTile(
      icon: Icons.chevron_right,
      onPress: onPress,
      header:
          "${person.name.first.family}, ${person.name.first.given!.join(" ")}",
      bodyText: person.identifier.last.value,
    );
  }

  static Widget Policies(
      BuildContext context, dynamic policy, BusinessLogic businessLogic) {
    return OpenImisListTile(
      icon: Icons.edit,
      onPress: () {},
      header: policy["name"],
      bodyText: policy["id"],
    );
  }
}
