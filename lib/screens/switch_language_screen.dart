import 'package:flash_card_learn_english/controllers/setting_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    // TODO: implement initState
    _radioVal = context.read<SettingApp>().languageKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
    return Container(
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 0.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            language.title,
            style: TextStyle(fontSize: 16.sp),
          ),
          Radio<String>(
            groupValue: _radioVal,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _radioVal = value;
                });
                context.read<SettingApp>().setLocale(language);
              }
            },
            value: language.key,
          )
        ],
      ),
    );
  }
}
