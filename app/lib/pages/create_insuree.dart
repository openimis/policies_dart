import 'dart:async';

import 'package:app/pages/insuree.dart';
import 'package:app/widgets/pagination.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/gender_select.dart';
import 'package:app/widgets/layout/standard_layout.dart';
import 'package:app/widgets/list_tile.dart';
import 'package:app/widgets/text_input.dart';
import 'package:fhir_openimis/fhir_openimis.dart';
import 'package:flutter/material.dart';
import 'package:business_logic/business_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fhir_openimis/src/generated/resources/resources.dart';
import 'package:fhir_openimis/src/generated/base_types/base_types.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateInsureeScreen extends StatefulWidget {
  static final String routeName = '/insuree/create';

  const CreateInsureeScreen({Key? key}) : super(key: key);

  @override
  State<CreateInsureeScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CreateInsureeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _lastNameController = TextEditingController();
  Map<String, String> insuree = {};
  Map<String, bool> gender = {
    "female": false,
    "male": false,
    "other": false,
  };
  int index = 1;
  late BusinessLogic _businessLogic;
  String? _familyId = null;
  bool firstLoad = true;

  updateFamilyId(String? familyId) {
    setState(() {
      _familyId = familyId;
      insuree["familyId"] = familyId ?? "";
      _lastNameController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    _businessLogic = context.read<BusinessLogic>();

    final familyId = ModalRoute.of(context)!.settings.arguments;
    if (familyId != null && firstLoad) {
      updateFamilyId(familyId as String);
      firstLoad = false;
    }

    return StandardLayout(
      title: AppLocalizations.of(context).addInsuree,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GenderSelect(
                onSaved: (value) {
                  var gender = "";
                  value!.forEach((key, value) {
                    if (value) {
                      gender = key;
                    }
                  });
                  insuree["gender"] = gender;
                },
              ),
              SizedBox(height: 12),
              OpenImisTextInput(
                text: AppLocalizations.of(context).firstName,
                onSaved: (state) {
                  insuree["firstName"] = state ?? "";
                },
              ),
              SizedBox(height: 12),
              FutureBuilder<String>(
                future: () async {
                  if (_familyId == null) {
                    return "";
                  }
                  final head = await _businessLogic.getFamilyHead(_familyId!);
                  final familyName = head.name.first.family ?? "";
                  _lastNameController.text = familyName;
                  return familyName;
                }(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Column(
                    children: [
                      if (snapshot.data! != "") ...{
                        OpenImisListTile(
                          header: AppLocalizations.of(context).selectedFamily +
                              ": " +
                              snapshot.data!,
                          icon: Icons.clear,
                          onPress: () {
                            updateFamilyId(null);
                          },
                        ),
                        SizedBox(height: 12),
                      },
                      Row(
                        children: [
                          Expanded(
                            child: OpenImisTextInput(
                              text: AppLocalizations.of(context).lastName,
                              onSaved: (state) {
                                insuree["lastName"] = state ?? "";
                              },
                              controller: _lastNameController,
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.all(16),
                            onPressed: () => {
                              createDialog(
                                onSelect: (familyId) {
                                  updateFamilyId(familyId);
                                },
                              )
                            },
                            icon: Icon(Icons.search),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 12),
              InputDatePickerFormField(
                fieldLabelText: AppLocalizations.of(context).birthDate,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                initialDate: DateTime.now(),
                onDateSaved: (value) {
                  insuree["birthDate"] = DateFormat('yyyy-MM-dd').format(value);
                },
              ),
              SizedBox(height: 12),
              OpenImisTextInput(
                text: AppLocalizations.of(context).city,
                onSaved: (state) {
                  insuree["city"] = state ?? "";
                },
              ),
              SizedBox(height: 12),
              OpenImisTextInput(
                text: AppLocalizations.of(context).district,
                onSaved: (state) {
                  insuree["district"] = state ?? "";
                },
              ),
              SizedBox(height: 12),
              OpenImisTextInput(
                text: AppLocalizations.of(context).state,
                onSaved: (state) {
                  insuree["state"] = state ?? "";
                },
              ),
              SizedBox(height: 12),
              OpenImisButton(
                buttonText: AppLocalizations.of(context).save,
                onPress: _submitForm,
                icon: Icons.save_as_outlined,
              )
            ],
          ),
        ),
      ),
    );
  }

  /**
   * creates a dialog, which goes back and forth
   */
  createDialog({required Function onSelect}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: EdgeInsets.all(16),
              child:
                  Stack(children: [setupAlertDialogContainer(onSelect: onSelect, setState: setState)]),
            );
          }
        );
      },
    );
  }

  Widget setupAlertDialogContainer({required Function onSelect, required setState}) {
    return Column(
      children: [
        SizedBox(height: 16),
        Text(
          AppLocalizations.of(context).familyList,
          textScaleFactor: 1.5,
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              child: FutureBuilder<Bundle<OpenimisGroup>>(
                future: _businessLogic.getFamilies(index),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      physics: AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: snapshot.data!.entry!.length,
                      itemBuilder: (context, index) {
                        final group = snapshot.data!.entry![index];
                        return FamiliyListTile(
                          group: group,
                          onSelect: onSelect,
                        );
                      },
                    );
                  }

                  if (snapshot.hasData && snapshot.data!.entry!.isEmpty) {
                    return Center(
                      child: Text(AppLocalizations.of(context).notCovered),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Pagination(index, (int page) {
            setState(() {
              index = page;
            });
          }, 4),
        ),
      ],
    );
  }

  _submitForm() async {
    _formKey.currentState?.save();
    try {
      final newInsuree = await _businessLogic.createInsuree(insuree);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: new Text(AppLocalizations.of(context).successfull),
          duration: new Duration(seconds: 3),
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 100,
        ),
      );
      await Navigator.pushReplacementNamed(context, InsureeScreen.routeName,
          arguments: newInsuree.id);
    } on NoConnectionException {
      _formKey.currentState?.reset();
      _lastNameController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: new Text(AppLocalizations.of(context).addedToQueue),
          duration: new Duration(seconds: 10),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: new Text(AppLocalizations.of(context).failed),
          duration: new Duration(seconds: 10),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}

class FamiliyListTile extends StatelessWidget {
  FamiliyListTile({
    Key? key,
    required this.group,
    required this.onSelect,
  }) : super(key: key);

  final Entry<OpenimisGroup> group;
  String? familiyId = "";
  Function onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(
          "${group.resource!.name}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(Icons.chevron_right),
        textColor: Theme.of(context).colorScheme.onSurface,
        onTap: () {
          final familyId = group.resource!.id!;
          onSelect(familyId);
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
