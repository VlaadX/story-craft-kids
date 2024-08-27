import 'package:flutter/material.dart';
import 'package:story_craft_kids/modules/home/create_history.dart';
import 'package:story_craft_kids/modules/home/model.dart';
import 'package:story_craft_kids/modules/list/history_item.dart';

import '../../db_helper.dart';

enum InfoStateList { start, loading, success, error }

class HomeController {
  final state = ValueNotifier<InfoStateList>(InfoStateList.start);
  final homeFormKey = GlobalKey<FormState>();

  FormModel model = FormModel(title: 'Title example', api: 'gemini');

  void onChange({String? title, String? place, String? mainCharacter, String? mainCharacterDescription, String? context, String? problem, String? mainGoal, String? details, String? api}) {
    model = model.copyWith(
      title: title,
      place: place,
      mainCharacter: mainCharacter,
      mainCharacterDescription: mainCharacterDescription,
      context: context,
      problem: problem,
      mainGoal: mainGoal,
      details: details,
      api: api
    );
  }

  Future<void> start() async {
    state.value = InfoStateList.loading;
    try {
      state.value = InfoStateList.success;
    } catch (e) {
      state.value = InfoStateList.error;
    }
  }

  Future<int?> createHistory() async {
    state.value = InfoStateList.loading;

    try {
      DatabaseHelper db_instance = DatabaseHelper();

      CreateHistory createHistory = CreateHistory(form: model);

      HistoryItem historyItem = await createHistory.create();

      HistoryItem item = await db_instance.create(historyItem);

      return item.id;
    } catch (e) {
      state.value = InfoStateList.error;
      throw Exception(e);
    }
  }
}