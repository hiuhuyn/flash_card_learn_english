import 'package:flash_card_learn_english/models/topic.dart';
import 'package:flutter/foundation.dart';

import '../data/db_offline/topic_sqlite_db.dart';

class TopicCtrlOffline extends ChangeNotifier {
  List<Topic> _topicAll = [];
  List<Topic> topics = [];
  Future getAll() async {
    try {
      _topicAll = List.from(await TopicSqlite.getAllTopic());
      topics = _topicAll;
      print("Topic offline: $topics");
      notifyListeners();
    } catch (e) {
      print("getAll topic sqlite error: $e");
    }
  }

  searchTopic(String value) {
    if (value.isNotEmpty) {
      topics = List.from(_topicAll.where((element) =>
          element.title.toLowerCase().contains(value.toLowerCase())));
    } else {
      topics = List.from(_topicAll);
    }
    notifyListeners();
  }

  Future deleteTopic(String idTopic) async {
    try {
      int index = _topicAll.indexWhere((element) => element.id == idTopic);
      if (index != -1) {
        await TopicSqlite.deleteTopic(_topicAll[index].id!);
        _topicAll.removeAt(index);
        topics = _topicAll;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future updateTopic(Topic value) async {
    try {
      int index = _topicAll.indexWhere((element) => element.id == value.id);
      if (index != -1) {
        _topicAll[index] = value;
        index = topics.indexWhere((element) => element.id == value.id);
        if (index != -1) {
          topics[index] = value;
        }
      }
      notifyListeners();
    } catch (e) {
      print("updateVocabulary: $e");
    }
  }
}
