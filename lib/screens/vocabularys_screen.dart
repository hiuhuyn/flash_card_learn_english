import 'package:flash_card_learn_english/components/widgets/item_setVocabulary.dart';
import 'package:flash_card_learn_english/controllers/topic_controller.dart';
import 'package:flash_card_learn_english/controllers/topic_controller_offline.dart';
import 'package:flash_card_learn_english/controllers/vocabularys_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/router/route_name.dart';
import '../models/topic.dart';
import '../models/vocabulary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../components/widgets/item_vocabulary.dart';

class VocabularysScreen extends StatefulWidget {
  const VocabularysScreen({super.key});

  @override
  State<VocabularysScreen> createState() => _VocabularysScreenState();
}

class _VocabularysScreenState extends State<VocabularysScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _focusNodeSearch = FocusNode();
  Topic _topic = Topic(title: '');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNodeSearch.unfocus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchCtrl.dispose();
    _focusNodeSearch.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isOnline = context.read<VocabularysController>().isOnline;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          AppLocalizations.of(context)!.list_vocbulary,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.filter_alt_outlined,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                if (context.read<VocabularysController>().isOnline) {
                  context.read<TopicController>().deleteTopic(_topic.id!);
                } else {
                  context.read<TopicCtrlOffline>().deleteTopic(_topic.id!);
                }
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: _searchCtrl,
                onChanged: (value) {
                  context.read<VocabularysController>().searchVocabulary(value);
                },
                focusNode: _focusNodeSearch,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.search,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchCtrl.clear();
                      _focusNodeSearch.unfocus();
                      context
                          .read<VocabularysController>()
                          .searchVocabulary("");
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<VocabularysController>(
                  builder: (context, controller, child) {
                _topic = controller.topic;
                return _topic.vocabularys.isEmpty
                    ? Center(
                        child: Text(
                            AppLocalizations.of(context)!.let_new_vocabulary),
                      )
                    : ListView.builder(
                        itemCount: _topic.vocabularys.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _topic.vocabularys.length) {
                            return const SizedBox(
                              height: 100,
                            );
                          }
                          Vocabulary data = _topic.vocabularys[index];
                          return Slidable(
                            key: Key(data.toString()),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  padding: const EdgeInsets.all(10),
                                  onPressed: (_) async {
                                    await context
                                        .read<VocabularysController>()
                                        .deleteVocabulary(data)
                                        .then((value) {
                                      if (controller.isOnline) {
                                        context
                                            .read<TopicController>()
                                            .updateTopic(_topic);
                                      } else {
                                        context
                                            .read<TopicCtrlOffline>()
                                            .updateTopic(_topic);
                                      }
                                    });
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: AppLocalizations.of(context)!.delete,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                if (isOnline)
                                  SlidableAction(
                                    padding: const EdgeInsets.all(10),
                                    onPressed: (_) {
                                      _showBottomSheetEditVocabulary(index);
                                    },
                                    backgroundColor: const Color(0xFF21B7CA),
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label: AppLocalizations.of(context)!.update,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                              ],
                            ),
                            child: ItemVocabulary(
                              vocabulary: data,
                            ),
                          );
                        },
                      );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: !isOnline
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteName.addVocabularys);
              },
              child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    ));
  }

  void _showBottomSheetEditVocabulary(int index) {
    Vocabulary vocabulary = _topic.vocabularys[index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SingleChildScrollView(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  ItemSetVocabulary(
                    vocabulary: vocabulary,
                    onChangedTerm: (value) {
                      vocabulary = vocabulary.copyWith(terms: value);
                    },
                    onChangedSpelling: (value) {
                      vocabulary = vocabulary.copyWith(spelling: value);
                    },
                    onChangedDefine: (value) {
                      vocabulary = vocabulary.copyWith(define: value);
                    },
                    onChangedExample: (value) {
                      vocabulary = vocabulary.copyWith(example: value);
                    },
                    onChangedBackgroudColor: (color) {
                      vocabulary = vocabulary.copyWith(color: color);
                    },
                    onChangedTextColor: (color) {
                      vocabulary = vocabulary.copyWith(textColor: color);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber),
                        onPressed: () async {
                          await context
                              .read<VocabularysController>()
                              .updateVocabulary(vocabulary)
                              .then((_) {
                            context.read<TopicController>().updateTopic(
                                context.read<VocabularysController>().topic);
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          AppLocalizations.of(context)!.save,
                          style: TextStyle(fontSize: 18.sp),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: TextStyle(fontSize: 18.sp),
                        )),
                  )
                ],
              ))),
    );
  }
}
