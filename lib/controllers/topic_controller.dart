import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/firebase/auth.dart';
import '../data/firebase/topic_db_fb.dart';
import '../models/topic.dart';

class TopicController extends ChangeNotifier {
  List<Topic> _topicAll = [];
  List<Topic> topics = [];

  searchTopic(String value) {
    if (value.isNotEmpty) {
      topics = List.from(_topicAll.where((element) =>
          element.title.toLowerCase().contains(value.toLowerCase())));
    } else {
      topics = List.from(_topicAll);
    }
    notifyListeners();
  }

  Future getData() async {
    try {
      User? user = Auth.currentUser;
      if (user != null && user.email != null) {
        _topicAll = List.from(await TopicFirebase.getTopics(user.email!));
        topics = _topicAll;
        notifyListeners();
      } else {
        print("User not found");
      }
    } catch (e) {
      print(e);
    }
  }

  Future deleteTopic(String idTopic) async {
    try {
      int index = _topicAll.indexWhere((element) => element.id == idTopic);
      if (index != -1) {
        await TopicFirebase.deleteTopic(_topicAll[index]);
        _topicAll.removeAt(index);
        topics = _topicAll;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future createData(Topic topic) async {
    try {
      // create all
      topic.email = Auth.currentUser!.email!.toString();
      topic.initAt = DateTime.now().millisecondsSinceEpoch;
      await TopicFirebase.createTopic(topic).then((value) {
        topic.id = value;
        _topicAll.add(topic);
        topics = List.from(_topicAll);
        notifyListeners();
      });
    } catch (e) {
      print("createData error: $e");
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
