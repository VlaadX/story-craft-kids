import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class History {
  final int id;
  final String title;
  final String api;
  final String body;

  const History({
    required this.id,
    required this.title,
    required this.api,
    required this.body,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'api': api,
      'body': body,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'History{id: $id, title: $title, api: $api, body: $body}';
  }

  Future<List<History>> dogs() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'histories_database.db'),
    );
    final db = await database;

    // Query the table for all the dogs.
    final List<Map<String, Object?>> Histories = await db.query('dogs');

    // Convert the list of each dog's fields into a list of `Dog` objects.
    return [
      for (final {
      'id': id as int,
      'title': title as String,
      'api': api as String,
      'body': body as String,
      } in Histories)
        History(id: id, title: title, api: api, body: body),
    ];
  }

  Future<void> insertDog(History history) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'histories_database.db'),
    );
    final db = await database;

    await db.insert(
      'histories',
      history.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}