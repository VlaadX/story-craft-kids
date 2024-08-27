import 'package:flutter/material.dart';
import 'package:story_craft_kids/modules/list/history_item.dart';

import '../../db_helper.dart';

enum InfoStateList { start, loading, success, error }

class ListController {
  final state = ValueNotifier<InfoStateList>(InfoStateList.start);
  final homeFormKey = GlobalKey<FormState>();
  List<HistoryItem> histories = [];

  Future<void> start() async {
    state.value = InfoStateList.loading;
    await refreshHistories();
    state.value = InfoStateList.success;
  }

  refreshHistories() async {
    DatabaseHelper db_instance = DatabaseHelper();

    histories = await db_instance.readAll();
  }
}