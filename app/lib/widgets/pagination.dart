import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Pagination extends StatelessWidget {
  final int page;
  final int totalPages;
  final Function onChange;

  Pagination(this.page, this.onChange, [this.totalPages = 1000]);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(AppLocalizations.of(context).page +
            " " +
            page.toString() +
            " / " +
            totalPages.toString()),
        SizedBox(width: 8),
        TextButton(
          style: TextButton.styleFrom(
            primary: Theme.of(context).colorScheme.onSecondary,
          ),
          child: Icon(Icons.chevron_left),
          onPressed: (page > 1)
              ? () {
                  onChange(page - 1);
                }
              : null,
        ),
        SizedBox(width: 8),
        TextButton(
          style: TextButton.styleFrom(
            primary: Theme.of(context).colorScheme.onSecondary,
          ),
          child: Icon(Icons.chevron_right),
          onPressed: (page < totalPages)
              ? () {
                  onChange(page + 1);
                }
              : null,
        ),
      ],
    );
  }
}
