import 'package:flash_card_learn_english/controllers/vocabularys_controller.dart';

import '../components/router/route_name.dart';
import '../controllers/topic_controller.dart';
import 'package:flutter/material.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../components/widgets/item_topic.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  final TextEditingController _textSearch = TextEditingController();
  final FocusNode _focusNodeSearch = FocusNode();
  @override
  void initState() {
    context.read<TopicController>().getData();
    _focusNodeSearch.unfocus();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textSearch.dispose();
    _focusNodeSearch.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (value) {
                    context.read<TopicController>().searchTopic(value);
                  },
                  controller: _textSearch,
                  maxLines: 1,
                  focusNode: _focusNodeSearch,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.search,
                      hintStyle: const TextStyle(fontSize: 16),
                      icon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _textSearch.clear();
                            _focusNodeSearch.unfocus();
                            context.read<TopicController>().searchTopic('');
                          },
                          icon: const Icon(
                            Icons.clear_rounded,
                            color: Colors.black,
                          )),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Consumer<TopicController>(
                    builder: (context, controller, child) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[100]),
                    child: controller.topics.isEmpty
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context)!.no_topic,
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        : ListView.builder(
                            itemCount: controller.topics.length,
                            itemBuilder: (ctx, index) {
                              var data = controller.topics[index];
                              return ItemTopic(
                                onTap: () {
                                  context
                                      .read<VocabularysController>()
                                      .updateTopic(data, true);
                                  Navigator.pushNamed(
                                    context,
                                    RouteName.vocabularysScreen,
                                  );
                                },
                                topic: data,
                              );
                            },
                          ),
                  );
                }),
              ),
            ],
          )),
    );
  }
}
