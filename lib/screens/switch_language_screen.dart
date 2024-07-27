import 'package:flash_card_learn_english/controllers/setting_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';

import '../models/language.dart';

class SwitchLanguageScreen extends StatefulWidget {
  const SwitchLanguageScreen({super.key});

  @override
  State<SwitchLanguageScreen> createState() => _SwitchLanguageStateScreen();
}

class _SwitchLanguageStateScreen extends State<SwitchLanguageScreen> {
  String _radioVal = 'en';
  @override
  void initState() {
    _radioVal = context.read<SettingApp>().languageKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            AppLocalizations.of(context)!.language,
            style: const TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black)),
        ),
        body: ListView.builder(
          itemCount: getLanguages.length,
          itemBuilder: (context, index) {
            return item(getLanguages[index]);
          },
        ),
      ),
    );
  }

  Widget item(Language language) {
    return RadioListTile(
      shape: Border.all(width: 0.2, color: Colors.grey),
      title: Text(
        language.title,
        style: const TextStyle(fontSize: 16),
      ),
      value: language.key,
      groupValue: _radioVal,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _radioVal = value;
          });
          context.read<SettingApp>().setLocale(language);
        }
      },
    );
  }
}
