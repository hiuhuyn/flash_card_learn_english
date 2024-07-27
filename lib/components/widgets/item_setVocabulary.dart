import 'package:flash_card_learn_english/models/vocabulary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class ItemSetVocabulary extends StatefulWidget {
  ItemSetVocabulary(
      {super.key,
      required this.vocabulary,
      required this.onChangedTerm,
      required this.onChangedSpelling,
      required this.onChangedDefine,
      required this.onChangedExample,
      required this.onChangedBackgroudColor,
      required this.onChangedTextColor});
  Vocabulary vocabulary;
  Function(String value) onChangedTerm;
  Function(String value) onChangedSpelling;
  Function(String value) onChangedDefine;
  Function(String value) onChangedExample;
  Function(int color) onChangedTextColor;
  Function(int color) onChangedBackgroudColor;

  @override
  State<ItemSetVocabulary> createState() => _ItemSetVocabularyState();
}

class _ItemSetVocabularyState extends State<ItemSetVocabulary> {
  Vocabulary vocabulary = Vocabulary();
  @override
  void initState() {
    // TODO: implement initState
    vocabulary = widget.vocabulary;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            maxLines: null,
            initialValue: vocabulary.terms,
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onChangedTerm,
            style: TextStyle(color: Color(vocabulary.textColor)),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              hintText: AppLocalizations.of(context)!.terms,
              labelText: AppLocalizations.of(context)!.terms,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            maxLines: null,
            initialValue: vocabulary.spelling,
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onChangedSpelling,
            style: TextStyle(color: Color(vocabulary.textColor)),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              hintText: AppLocalizations.of(context)!.spelling,
              labelText: AppLocalizations.of(context)!.spelling,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            maxLines: null,
            initialValue: vocabulary.define,
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onChangedDefine,
            style: TextStyle(color: Color(vocabulary.textColor)),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              hintText: AppLocalizations.of(context)!.define,
              labelText: AppLocalizations.of(context)!.define,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 15),
          child: TextFormField(
            maxLines: null,
            initialValue: vocabulary.example,
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onChangedExample,
            style: TextStyle(color: Color(vocabulary.textColor)),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              hintText: AppLocalizations.of(context)!.example,
              labelText: AppLocalizations.of(context)!.example,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _showColorPicker(true);
              },
              icon: const Icon(Icons.color_lens, color: Colors.white),
              label: Text(
                AppLocalizations.of(context)!.text_color,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 0, 140, 255)),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showColorPicker(false);
              },
              icon: const Icon(Icons.colorize, color: Colors.white),
              label: Text(
                AppLocalizations.of(context)!.background_color,
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color.fromARGB(255, 0, 140, 255),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _showColorPicker(bool isTextColor) {
    Color pickerColor =
        isTextColor ? Color(vocabulary.textColor) : Color(vocabulary.color);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (value) {
              pickerColor = value;
            },
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() {
                if (isTextColor) {
                  vocabulary.textColor = pickerColor.value;
                  widget.onChangedTextColor(pickerColor.value);
                } else {
                  vocabulary.color = pickerColor.value;
                  widget.onChangedBackgroudColor(pickerColor.value);
                }
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemCreateVocabulary extends StatefulWidget {
  ItemCreateVocabulary(
      {super.key,
      required this.vocabulary,
      required this.onChangedTerm,
      required this.onChangedSpelling,
      required this.onChangedDefine,
      required this.onChangedExample,
      required this.onChangedBackgroudColor,
      required this.onChangedTextColor});
  Vocabulary vocabulary;
  Function(String value) onChangedTerm;
  Function(String value) onChangedSpelling;
  Function(String value) onChangedDefine;
  Function(String value) onChangedExample;
  Function(int color) onChangedTextColor;
  Function(int color) onChangedBackgroudColor;

  @override
  State<ItemCreateVocabulary> createState() => _ItemCreateVocabularyState();
}

class _ItemCreateVocabularyState extends State<ItemCreateVocabulary> {
  Vocabulary _vocabulary = Vocabulary();
  bool _isShowInput34 = false;
  @override
  void initState() {
    _vocabulary = widget.vocabulary;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            maxLines: null,
            initialValue: _vocabulary.terms,
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onChangedTerm,
            style: TextStyle(color: Color(_vocabulary.textColor)),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              hintText: AppLocalizations.of(context)!.terms,
              labelText: AppLocalizations.of(context)!.terms,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            maxLines: null,
            initialValue: _vocabulary.define,
            textAlignVertical: TextAlignVertical.center,
            onChanged: widget.onChangedDefine,
            style: TextStyle(color: Color(_vocabulary.textColor)),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              hintText: AppLocalizations.of(context)!.define,
              labelText: AppLocalizations.of(context)!.define,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Visibility(
            visible: !_isShowInput34,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  setState(() {
                    _isShowInput34 = !_isShowInput34;
                  });
                },
                label: Text(
                  AppLocalizations.of(context)!.add_information,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          ),
        ),
        SizedBox(
          child: Visibility(
            visible: _isShowInput34,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    maxLines: null,
                    initialValue: _vocabulary.spelling,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: widget.onChangedSpelling,
                    style: TextStyle(color: Color(_vocabulary.textColor)),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: AppLocalizations.of(context)!.spelling,
                      labelText: AppLocalizations.of(context)!.spelling,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: TextFormField(
                    maxLines: null,
                    initialValue: _vocabulary.example,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: widget.onChangedExample,
                    style: TextStyle(color: Color(_vocabulary.textColor)),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: AppLocalizations.of(context)!.example,
                      labelText: AppLocalizations.of(context)!.example,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _showColorPicker(true);
                      },
                      icon: const Icon(Icons.color_lens, color: Colors.white),
                      label: Text(
                        AppLocalizations.of(context)!.text_color,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor:
                              const Color.fromARGB(255, 0, 140, 255)),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        _showColorPicker(false);
                      },
                      icon: const Icon(Icons.colorize, color: Colors.white),
                      label: Text(
                        AppLocalizations.of(context)!.background_color,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor:
                              const Color.fromARGB(255, 0, 140, 255)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showColorPicker(bool isTextColor) {
    Color pickerColor =
        isTextColor ? Color(_vocabulary.textColor) : Color(_vocabulary.color);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (value) {
              pickerColor = value;
            },
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() {
                if (isTextColor) {
                  _vocabulary.textColor = pickerColor.value;
                  widget.onChangedTextColor(pickerColor.value);
                } else {
                  _vocabulary.color = pickerColor.value;
                  widget.onChangedBackgroudColor(pickerColor.value);
                }
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
