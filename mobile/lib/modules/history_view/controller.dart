import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../db_helper.dart';
import '../list/history_item.dart';

enum InfoStateHistoryView { start, loading, success, error }

class HistoryViewController {

  final state = ValueNotifier<InfoStateHistoryView>(InfoStateHistoryView.start);

  HistoryItem? historyItem;

  List<String> dividedHistory = [];
  List<String?> image_urls = [];
  List<String> splitedHistory = [];

  final int MAX_IMAGES = 8;

  Future<void> start(int? historyId) async {
    WidgetsFlutterBinding.ensureInitialized();

    state.value = InfoStateHistoryView.loading;

    if (historyId != null) {
      state.value = InfoStateHistoryView.error;
    }

    try {
      DatabaseHelper db_instance = DatabaseHelper();

      historyItem = await db_instance.read(historyId!);

      dividedHistory = divideText(splitText(historyItem!.body));

      if (historyItem?.image_1_url != null) {
        image_urls.add(historyItem?.image_1_url);
      }
      if (historyItem?.image_2_url != null) {
        image_urls.add(historyItem?.image_2_url);
      }
      if (historyItem?.image_3_url != null) {
        image_urls.add(historyItem?.image_3_url);
      }
      if (historyItem?.image_4_url != null) {
        image_urls.add(historyItem?.image_4_url);
      }
      if (historyItem?.image_5_url != null) {
        image_urls.add(historyItem?.image_5_url);
      }
      if (historyItem?.image_6_url != null) {
        image_urls.add(historyItem?.image_6_url);
      }
      if (historyItem?.image_7_url != null) {
        image_urls.add(historyItem?.image_7_url);
      }
      if (historyItem?.image_8_url != null) {
        image_urls.add(historyItem?.image_8_url);
      }
    } catch (e) {
      state.value = InfoStateHistoryView.error;
      throw Exception(e);
    }

    state.value = InfoStateHistoryView.success;
  }

  List<String> divideText(List<String> splitedText) {
    List<String> dividedText = [];

    // Calcular o tamanho de cada parte
    int partSize = (splitedText.length / MAX_IMAGES).ceil();

    for (int i = 0; i < splitedText.length; i += partSize) {
      // Juntar os parágrafos da parte atual
      String part = splitedText.sublist(i, (i + partSize).clamp(0, splitedText.length)).join("\n\n");
      dividedText.add(part);
    }

    return dividedText;
  }

  // // Split the list in maxImages items
  // List<String> divideText(List<String> splitedText) {
  //   List<String> dividedText = [];
  //   String firstItem = "";
  //
  //   int firstItems =  splitedText.length - maxImages + 1;
  //
  //   for (int i = 0; i < firstItems; i++) {
  //     firstItem += splitedText[i] + "\n";
  //   }
  //
  //   dividedText.add(firstItem);
  //
  //   for(int i = firstItems; i < splitedText.length; i++) {
  //     dividedText.add("\n\n" + splitedText[i]);
  //   }
  //
  //   return dividedText;
  // }

  List<String> splitText(String text) {
    List<String> splited = text.split('\n\n');
    List<String> splited_clean = [];

    for (String text in splited) {
      text = text.trim();
      if (text.isNotEmpty) {
        splited_clean.add(text + "\n");
      }
    }

    return splited_clean;
  }
}