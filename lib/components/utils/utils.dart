import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future showDialogEditTopic(BuildContext context,
    {required String title,
    String? initContent,
    Function(String value)? onTapSave}) async {
  TextEditingController textCtrl = TextEditingController(text: initContent);

  FocusNode focusNode = FocusNode();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return SingleChildScrollView(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(bottom: 20),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: null,
                  maxLength: 255,
                  focusNode: focusNode,
                  controller: textCtrl,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText:
                        "${AppLocalizations.of(context)!.input} ${AppLocalizations.of(context)!.title} ${AppLocalizations.of(context)!.topic}",
                    labelText:
                        "${AppLocalizations.of(context)!.input} ${AppLocalizations.of(context)!.title} ${AppLocalizations.of(context)!.topic}",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber),
                              onPressed: () {
                                focusNode.unfocus();
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.cancel,
                                style: const TextStyle(fontSize: 20),
                              )),
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 60,
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber),
                            onPressed: () async {
                              if (textCtrl.text.isNotEmpty &&
                                  onTapSave != null) {
                                onTapSave(textCtrl.text);
                                textCtrl.clear();
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: Text(
                              AppLocalizations.of(context)!.save,
                              style: const TextStyle(fontSize: 20),
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
