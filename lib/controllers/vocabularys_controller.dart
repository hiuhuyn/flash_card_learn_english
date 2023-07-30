import 'package:flash_card_learn_english/data/db_offline/topic_sqlite_db.dart';
import 'package:flash_card_learn_english/data/firebase/topic_db_fb.dart';
import 'package:flash_card_learn_english/models/topic.dart';
import 'package:flutter/material.dart';
import '../models/vocabulary.dart';

class VocabularysController extends ChangeNotifier {
  Topic _topic = Topic();
  Topic topic = Topic();
  bool isOnline = false;

  updateTopic(Topic value, bool isOnline) {
    _topic = value;
    topic = value;
    this.isOnline = isOnline;
    notifyListeners();
  }

  Future addVocabulary(List<Vocabulary> values) async {
    try {
      values.removeWhere((element) => element.terms == "");
      if (isOnline) {
        await TopicFirebase.addVocabularys(_topic.id!, values);
      } else {
        await Future.forEach(values, (element) async {
          await TopicSqlite.addVocabulary(_topic.id!, element);
        });
      }
      // _topic.vocabularys.addAll(values);
      for (var element in values) {
        _topic.vocabularys.add(element);
      }
      topic = _topic;
      notifyListeners();
    } catch (e) {
      print("addVocabulary: $e");
    }
  }

  Future deleteVocabulary(Vocabulary vocabulary) async {
    try {
      if (isOnline) {
        await TopicFirebase.deleteVocabularys(_topic.id!, [vocabulary]);
      } else {
        await TopicSqlite.deleteVocabulary(vocabulary.id);
      }
      _topic.vocabularys.remove(vocabulary);
      topic = _topic;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  searchVocabulary(String value) async {
    if (value.isNotEmpty) {
      var list = _topic.vocabularys.where((element) =>
          element.terms.toLowerCase().contains(value.toLowerCase()));
      topic = _topic.copyWith(vocabularys: List.from(list));
    } else {
      topic = _topic;
    }
    notifyListeners();
  }

  Future updateVocabulary(Vocabulary value) async {
    int index =
        _topic.vocabularys.indexWhere((element) => element.id == value.id);
    if (index != -1) {
      if (isOnline) {
        try {
          final Vocabulary before = _topic.vocabularys[index];
          await TopicFirebase.deleteVocabularys(_topic.id!, [before]);
          try {
            await TopicFirebase.addVocabularys(_topic.id!, [value]);
          } catch (e) {
            print("add fail: $e");
          }
        } catch (e) {
          print("delete failed: $e");
        }
      } else {
        await TopicSqlite.updateVocabulary(value);
      }

      _topic.vocabularys[index] = value;
      topic = _topic;
      notifyListeners();
    }
  }
}
