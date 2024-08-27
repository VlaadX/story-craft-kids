import 'package:story_craft_kids/modules/home/model.dart';

import '../../services/chat_service.dart';
import '../../services/image_service.dart';
import '../list/history_item.dart';

class CreateHistory {
  FormModel form;
  int MAX_IMAGES = 8;

  CreateHistory({required this.form});

  Future<HistoryItem> create() async {
    String? history;

    if (form.api == "open ai") {
      history = await ChatServiceOpenAI().createHistory(form);
    } else if (form.api == "gemini"){
      history = await ChatServiceGemini().createHistory(form);
    } else {
      throw Exception("Erro ao selecionar a API de criação de histórias.");
    }

    if (history == null) {
      throw Exception("Erro ao criar a história");
    }

    String mainCharacterDescription = await generateCharacterDescriptionWithGemini();

    history = removeMarkdown(history);
    List<String> dividedHistory = divideText(splitText(history));

    List<String?> image_urls = await generateImages(dividedHistory, mainCharacterDescription);
    
    Map<int, String?> images = {};

    image_urls.asMap().forEach((index, value) {
      images[index] = value;
    });

    return HistoryItem(
        title: form.title, 
        date: DateTime.now(), 
        api: form.api, 
        body: history,
        image_1_url: images[0],
        image_2_url: images[1],
        image_3_url: images[2],
        image_4_url: images[3],
        image_5_url: images[4],
        image_6_url: images[5],
        image_7_url: images[6],
        image_8_url: images[7],
    );
  }

  Future<String> generateCharacterDescriptionWithGemini() async {
    String description = await ChatServiceGemini().generateCharacterDescription(form);
    return description;
  }

  Future<List<String?>> generateImages(List<String> dividedHistory, String mainCharacterDescription) async {
    List<String?> image_urls = [];
    for (int i = 0; i < dividedHistory.length; i++) {
      try {
        image_urls.add(await ImageService().request(dividedHistory[i], mainCharacterDescription));
      } catch (e) {
        print(e);
      }
      // image_urls.add(await ImageService().request(dividedHistory[i], mainCharacterDescription));
    }
    return image_urls;
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

  String removeMarkdown(String markdownText) {
    // Remove linhas começando com ##
    final regexHeaders = RegExp(r'##.*\n');
    String cleanedText = markdownText.replaceAll(regexHeaders, '');

    // Remove marcações de negrito **
    final regexBold = RegExp(r'\*\*(.*?)\*\*');
    cleanedText = cleanedText.replaceAllMapped(regexBold, (match) => match.group(1)!);

    // Remove outras marcações de negrito com __
    final regexBoldUnderscore = RegExp(r'__(.*?)__');
    cleanedText = cleanedText.replaceAllMapped(regexBoldUnderscore, (match) => match.group(1)!);

    return cleanedText;
  }
}