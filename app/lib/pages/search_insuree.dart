import 'package:app/pages/barcode_scanner.dart';
import 'package:app/pages/family.dart';
import 'package:app/pages/insuree.dart';
import 'package:app/widgets/pagination.dart';
import 'package:app/widgets/layout/standard_layout.dart';
import 'package:app/widgets/list_tile_templates.dart';
import 'package:app/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:business_logic/business_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fhir_openimis/src/generated/resources/resources.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class SearchInsureeScreen extends StatefulWidget {
  static final String routeName = '/insuree/search';

  @override
  State<SearchInsureeScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<SearchInsureeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _searchController = TextEditingController();
  int page = 1;
  List<OpenimisPatient>? _insurees;

  @override
  void initState() {
    final businessLogic = Provider.of<BusinessLogic>(context, listen: false);
    businessLogic.getAllInsurees().listen((event) {
      setState(() {
        _insurees = event;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final businessLogic = context.read<BusinessLogic>();

    final searchedInsurees = _insurees != null
        ? businessLogic.searchPatient(_insurees!, _searchController.text, page)
        : null;
    final paginatedSearchInsurees = searchedInsurees != null
        ? searchedInsurees.skip((page - 1) * 10).take(10)
        : null;

    final totalPages = ((searchedInsurees?.length ?? 0) / 10).ceil();

    return StandardLayout(
      title: AppLocalizations.of(context).searchInsuree,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).searchText,
                      suffixIcon: Icon(Icons.search),
                    ),
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {});
                    },
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
                        _searchController.text = barcode;
                      });
                    },
                    icon: Icon(Icons.camera_alt),
                  ),
                }
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: () {
                if (paginatedSearchInsurees == null) {
                  return Center(child: CircularProgressIndicator());
                }
                if (paginatedSearchInsurees.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(context).noResults),
                  );
                }

                return ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                    itemCount: paginatedSearchInsurees.length,
                    itemBuilder: (context, index) {
                      return ListTileTemplates.Person(
                        context,
                        paginatedSearchInsurees.elementAt(index),
                        businessLogic,
                        true,
                      );
                    });
              }(),
            ),
            SizedBox(height: 12),
            Pagination(
              page,
              (int _page) {
                setState(() {
                  page = _page;
                });
              },
              totalPages,
            ),
          ],
        ),
      ),
    );
  }
}

class InsureeListTile extends StatelessWidget {
  const InsureeListTile(
      {Key? key, required this.person, required this.businessLogic})
      : super(key: key);

  final dynamic person;

  final BusinessLogic businessLogic;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(
          "${person["data"]["familyName"]}, ${person["data"]["givenName"]}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("${person["id"]}"),
        trailing: Icon(Icons.chevron_right),
        textColor: Theme.of(context).colorScheme.onSurface,
        onTap: () {
          FocusScope.of(context).unfocus();
          Navigator.pushNamed(
            context,
            FamilyScreen.routeName,
            arguments: person["relation"]["family"]["id"],
          );
        },
      ),
    );
  }
}
