import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/topic.dart';
import '../../models/vocabulary.dart';

class TopicFirebase {
  static final db = FirebaseFirestore.instance;

  static Future<String> createTopic(Topic topic) async {
    var res = await db.collection("topics").add(topic.toMapAdd());
    return res.id;
  }

  static Future updateTopic(Topic topic) async {
    await db.collection("topics").doc(topic.id).set(topic.toMap());
  }

  static Future deleteTopic(Topic topic) async {
    await db.collection("topics").doc(topic.id).delete();
  }

  static Future<List<Topic>> getTopics(String email) async {
    List<Topic> topics = [];
    await db
        .collection("topics")
        .where('email', isEqualTo: email)
        // .orderBy("initAt", descending: true)
        .get()
        .then((value) {
      for (var item in value.docs) {
        Topic topic = Topic.fromMap(id: item.id, map: item.data());
        topics.add(topic);
      }
    });
    return topics;
  }

  static Future addVocabularys(String idTopic, List<Vocabulary> data) async {
    await db.collection('topics').doc(idTopic).update({
      "vocabularys": FieldValue.arrayUnion(data.map((e) => e.toMap()).toList())
    });
  }

  static Future deleteVocabularys(String idTopic, List<Vocabulary> data) async {
    print("Deleting vocabulary: $data");
    await db.collection('topics').doc(idTopic).update({
      "vocabularys": FieldValue.arrayRemove(data.map((e) => e.toMap()).toList())
    });
  }
}
