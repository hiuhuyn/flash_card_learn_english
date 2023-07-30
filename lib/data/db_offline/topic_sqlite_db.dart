import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:flash_card_learn_english/models/topic.dart';
import 'package:flash_card_learn_english/models/vocabulary.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

const kDbFileDatabase = 'app_flash_card_db.db';
const kDbTableTopic = 'topic';
const kDbTableVocabulary = 'vocabulary';

class TopicSqlite {
  static late Database _db;
  static Future deleteTable() async {
    await _db.execute('DROP TABLE IF EXISTS $kDbTableTopic;');
    await _db.execute('DROP TABLE IF EXISTS $kDbTableVocabulary;');
  }

  static Future initDB() async {
    try {
      final dbFolder = await getDatabasesPath();
      if (!await Directory(dbFolder).exists()) {
        await Directory(dbFolder).create(recursive: true);
      }
      final dbPath = join(dbFolder, kDbFileDatabase);
      _db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''CREATE TABLE $kDbTableTopic (
              idTopic TEXT PRIMARY KEY,
              title TEXT
              )''');
          await db.execute('''create table $kDbTableVocabulary (
          idVocabulary TEXT PRIMARY KEY,
          idTopic text,
          terms text,
          spelling text,
          define text,
          example text,
          color INTEGER,
          textColor INTEGER
        )''');
        },
      );
    } catch (e) {
      print("initDB failed: $e");
    }
  }

  static Future<List<Topic>> getAllTopic() async {
    if (!_db.isOpen) {
      await initDB();
    }
    final jsons = await _db.rawQuery('select * from $kDbTableTopic');
    print("result sqlite: $jsons");

    List<Topic> result = jsons.map((e) {
      Map<String, dynamic> item = Map.from(e);
      item['id'] = item['idTopic'];
      return Topic.fromMap2(item);
    }).toList();
    print("result 2: $result ");
    for (int i = 0; i < result.length; i++) {
      result[i].vocabularys =
          List.from(await getVocabularyFromTopic(result[i].id!));
    }

    return result;
  }

  static Future addTopic(Topic topic) async {
    if (!_db.isOpen) {
      await initDB();
    }
    int id1 = await _db.rawInsert(
        "INSERT INTO $kDbTableTopic(idTopic, title) VALUES(?, ?)",
        [topic.id, topic.title]);
    await Future.forEach(topic.vocabularys, (element) async {
      await addVocabulary(topic.id!, element);
    });
  }

  static Future deleteTopic(String id) async {
    await _db.rawDelete('delete from $kDbTableTopic where idTopic = ?', [id]);
    await deleteVocabularys(id);
  }

  static Future addVocabulary(String idTopic, Vocabulary value) async {
    try {
      await _db.rawInsert(
          '''insert into $kDbTableVocabulary (idVocabulary, idTopic,terms ,spelling, define, example, color, textColor) 
        values (
          ?, ?, ?, ?, ?, ?, ?, ?
        )''',
          [
            value.id,
            idTopic,
            value.terms,
            value.spelling,
            value.define,
            value.example,
            value.color,
            value.textColor,
          ]);
    } catch (e) {
      print("addVocabulary failed: $e");
    }
  }

  static Future deleteVocabulary(String idVocabulary) async {
    await _db.rawDelete(
        'delete from $kDbTableVocabulary where idVocabulary = ?',
        [idVocabulary]);
  }

  static Future deleteVocabularys(String idTopic) async {
    await _db.rawDelete(
        'delete from $kDbTableVocabulary where idTopic = ?', [idTopic]);
  }

  static Future<List<Vocabulary>> getVocabularyFromTopic(String idTopic) async {
    var ref = await _db.rawQuery(
        "select * from $kDbTableVocabulary where idTopic = ?", [idTopic]);
    List<Vocabulary> result = [];
    for (var element in ref) {
      Map<String, dynamic> item = Map.from(element);

      item['id'] = item['idVocabulary'];
      result.add(Vocabulary.fromMap(item));
    }
    return result;
  }

  static Future<Vocabulary?> getVocabulary(String idVocabulary) async {
    var ref = await _db.rawQuery(
        "select * from $kDbTableVocabulary where idVocabulary = ?",
        [idVocabulary]);
    if (ref.isEmpty) {
      return null;
    }
    Map<String, dynamic> item = Map.from(ref.first);
    item['id'] = item['idVocabulary'];

    return Vocabulary.fromMap(item);
  }

  static Future updateVocabulary(Vocabulary value) async {
    await _db.rawUpdate(
        '''update $kDbTableVocabulary 
    set terms = ?,spelling= ?,define= ?,example= ?,color= ?, textColor = ? where idVocabulary = ?''',
        [
          value.terms,
          value.spelling,
          value.define,
          value.example,
          value.color,
          value.textColor,
          value.id
        ]);
  }
}
