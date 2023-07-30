import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsSystem {
  static alertDialog(BuildContext context,
      {required Widget title,
      Widget? content,
      VoidCallback? onTapCancel,
      VoidCallback? onTapYes}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: title,
        actions: [
          TextButton(
            onPressed: onTapCancel ??
                () {
                  Navigator.pop(context);
                },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: onTapYes ??
                () {
                  Navigator.pop(context);
                },
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }
}
