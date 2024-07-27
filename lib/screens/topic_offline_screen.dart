import 'package:flutter/material.dart';
import 'package:flash_card_learn_english/controllers/vocabularys_controller.dart';
import '../components/router/route_name.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../controllers/topic_controller_offline.dart';

import '../models/topic.dart';

class TopicOfflineScreen extends StatefulWidget {
  const TopicOfflineScreen({super.key});

  @override
  State<TopicOfflineScreen> createState() => _TopicOfflineScreenState();
}

class _TopicOfflineScreenState extends State<TopicOfflineScreen> {
  final TextEditingController _textSearch = TextEditingController();
  final FocusNode _focusNodeSearch = FocusNode();
  @override
  void initState() {
    context.read<TopicCtrlOffline>().getAll();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          AppLocalizations.of(context)!.topic,
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
        actions: [
          IconButton(
              onPressed: () async {
                await context.read<TopicCtrlOffline>().getAll();
              },
              icon: const Icon(Icons.restart_alt_outlined, color: Colors.black))
        ],
      ),
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
                    context.read<TopicCtrlOffline>().searchTopic(value);
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
                            context.read<TopicCtrlOffline>().searchTopic('');
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
                child: Consumer<TopicCtrlOffline>(
                    builder: (context, controller, child) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[200]),
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
                              return _itemTopic(data);
                            },
                          ),
                  );
                }),
              ),
            ],
          )),
    );
  }

  Widget _itemTopic(Topic topic) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 2, color: Colors.grey, offset: Offset(2, 2))
          ]),
      child: InkWell(
        onTap: () {
          context.read<VocabularysController>().updateTopic(topic, false);
          Navigator.pushNamed(
            context,
            RouteName.vocabularysScreen,
          );
        },
        child: Text(
          topic.title,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
