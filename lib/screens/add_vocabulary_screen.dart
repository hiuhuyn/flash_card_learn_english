import 'package:flash_card_learn_english/controllers/topic_controller.dart';
import 'package:flash_card_learn_english/controllers/vocabularys_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';

import '../components/widgets/item_setVocabulary.dart';
import '../models/vocabulary.dart';

class AddVocabularyScreen extends StatefulWidget {
  const AddVocabularyScreen({super.key});

  @override
  State<AddVocabularyScreen> createState() => _AddVocabularyScreenState();
}

class _AddVocabularyScreenState extends State<AddVocabularyScreen> {
  final List<Vocabulary> _vocabularys = [Vocabulary()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            AppLocalizations.of(context)!.new_vocabulary,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context
                      .read<VocabularysController>()
                      .addVocabulary(_vocabularys)
                      .then((value) {
                    context.read<TopicController>().updateTopic(
                        context.read<VocabularysController>().topic);
                    Navigator.pop(context);
                  });
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                )),
          ],
        ),
        body: ListView.builder(
          itemCount: _vocabularys.length + 1,
          itemBuilder: (context, index) {
            return index == _vocabularys.length
                ? const SizedBox(
                    height: 100,
                  )
                : Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 3,
                              offset: Offset(0, 2),
                              color: Colors.grey)
                        ],
                        color: Color(_vocabularys[index].color)),
                    child: ItemCreateVocabulary(
                      vocabulary: _vocabularys[index],
                      onChangedTerm: (value) {
                        _vocabularys[index].terms = value.trim();
                      },
                      onChangedSpelling: (value) {
                        _vocabularys[index].spelling =
                            value.trim().replaceAll("/", "");
                      },
                      onChangedDefine: (value) {
                        _vocabularys[index].define = value.trim();
                      },
                      onChangedExample: (value) {
                        _vocabularys[index].example = value.trim();
                      },
                      onChangedBackgroudColor: (color) {
                        setState(() {
                          _vocabularys[index].color = color;
                        });
                      },
                      onChangedTextColor: (color) {
                        _vocabularys[index].textColor = color;
                      },
                    ),
                  );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            setState(() {
              _vocabularys.add(Vocabulary());
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
