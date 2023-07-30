import 'package:flash_card_learn_english/controllers/topic_controller.dart';
import 'package:flash_card_learn_english/data/db_offline/topic_sqlite_db.dart';
import 'package:flash_card_learn_english/data/firebase/topic_db_fb.dart';
import 'package:flash_card_learn_english/models/topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../utils/notifications.dart';
import '../utils/utils.dart';

class ItemTopic extends StatefulWidget {
  ItemTopic({
    super.key,
    required this.topic,
    required this.onTap,
  });
  Topic topic;
  VoidCallback onTap;

  @override
  State<ItemTopic> createState() => _ItemTopicState();
}

class _ItemTopicState extends State<ItemTopic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 2, color: Colors.grey, offset: Offset(2, 2))
          ]),
      child: InkWell(
        onTap: widget.onTap,
        child: Row(
          children: [
            Text(
              widget.topic.title,
              style: TextStyle(fontSize: 18.sp),
            ),
            const Spacer(),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    Future.delayed(const Duration(seconds: 0), () {
                      NotificationsSystem.alertDialog(context,
                          title: Text(
                            AppLocalizations.of(context)!
                                .are_you_sure_you_want_to_download_the_vocabulary,
                            style: const TextStyle(fontSize: 16),
                          ), onTapYes: () async {
                        await TopicSqlite.addTopic(widget.topic)
                            .then((value) => Navigator.pop(context));
                      });
                    });
                  },
                  child: Text(AppLocalizations.of(context)!.download),
                ),
                PopupMenuItem(
                  onTap: () {
                    Future.delayed(const Duration(seconds: 0), () {
                      NotificationsSystem.alertDialog(context,
                          title: Text(
                            AppLocalizations.of(context)!
                                .are_you_sure_you_want_to_delete_the_topic,
                            style: const TextStyle(fontSize: 16),
                          ), onTapYes: () async {
                        await context
                            .read<TopicController>()
                            .deleteTopic(widget.topic.id!)
                            .then((value) => Navigator.pop(context));
                      });
                    });
                  },
                  child: Text(AppLocalizations.of(context)!.delete),
                ),
                PopupMenuItem(
                  onTap: () {
                    Future.delayed(const Duration(seconds: 0), () {
                      showDialogEditTopic(
                        context,
                        title: AppLocalizations.of(context)!.update +
                            AppLocalizations.of(context)!.topic,
                        initContent: widget.topic.title,
                        onTapSave: (value) async {
                          Topic topic = widget.topic.copyWith(title: value);
                          await TopicFirebase.updateTopic(topic);
                          await context
                              .read<TopicController>()
                              .updateTopic(topic);
                        },
                      );
                    });
                  },
                  child: Text(AppLocalizations.of(context)!.update),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
