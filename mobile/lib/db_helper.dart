import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:story_craft_kids/modules/home/model.dart';
import 'package:story_craft_kids/modules/list/history_item.dart';

class DatabaseHelper {
  Database? _db;

  String dbName = "story_craft_kids.db";
  String tableHistories = "histories";

  Future get database async {
    if (_db != null) return _db;
    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = join(docsDirectory.path, dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future<void> _onCreateDB(Database db, int version) async {
    await db.execute(
        """CREATE TABLE histories (
        id INTEGER PRIMARY KEY NOT NULL,
        title TEXT NOT NULL,
        date INTEGER NOT NULL,
        api TEXT NOT NULL,
        body TEXT NOT NULL,
        image_1_url TEXT,
        image_2_url TEXT,
        image_3_url TEXT,
        image_4_url TEXT,
        image_5_url TEXT,
        image_6_url TEXT,
        image_7_url TEXT,
        image_8_url TEXT
      )"""
    );
  }

  Future<HistoryItem> create(HistoryItem item) async {
    final db = await database;
    final id = await db.insert(tableHistories, item.toJson());
    return item.copyWith(id: id);
  }

  Future<List<HistoryItem>> readAll() async {
    final db = await database;
    const orderBy = 'date DESC';
    final List<Map<String, dynamic>> maps = await db.query(tableHistories, orderBy: orderBy);
    return List.generate(maps.length, (i) {
      return HistoryItem(
        id: maps[i]['id'],
        title: maps[i]['title'],
        date: DateTime.parse(maps[i]['date']),
        api: maps[i]['api'],
        body: maps[i]['body']
      );
    });
  }

  Future<HistoryItem> read(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableHistories, where: 'id = ?', whereArgs: [id]);
    return HistoryItem(
      id: maps[0]['id'],
      title: maps[0]['title'],
      date: DateTime.parse(maps[0]['date']),
      api: maps[0]['api'],
      body: maps[0]['body'],
      image_1_url: maps[0]['image_1_url'],
      image_2_url: maps[0]['image_2_url'],
      image_3_url: maps[0]['image_3_url'],
      image_4_url: maps[0]['image_4_url'],
      image_5_url: maps[0]['image_5_url'],
      image_6_url: maps[0]['image_6_url'],
      image_7_url: maps[0]['image_7_url'],
      image_8_url: maps[0]['image_8_url']
    );
  }

  Future insertData(HistoryItem historyItem) async {
    final db = await database;
    final id = await db.insert(tableHistories, historyItem.toJson());
    return historyItem.copyWith(id: id);
  }

  Future updateData(int id, String title, DateTime date, String api, body) async {
    final db = await database;
    return await db.update(tableHistories, {'title': title, 'date': date.toIso8601String(), 'api': api, 'body': body}, where: 'id = ?', whereArgs: [id]);
  }

  Future deleteData(int id) async {
    final db = await database;
    return await db.delete(tableHistories, where: 'id = ?', whereArgs: [id]);
  }

  Future queryData() async {
    final db = await database;
    return await db.query(tableHistories);
  }

  Future querySpecificData(int id) async {
    final db = await database;
    return await db.query(tableHistories, where: "id = ?", whereargs: [id]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}