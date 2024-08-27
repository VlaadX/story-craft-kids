import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';

import '../modules/history/models/chat_request.dart';
import '../modules/history/models/chat_response.dart';
import '../modules/home/model.dart';
import 'api_key.dart';

import 'dart:math';
import 'dart:convert';

class ChatServiceOpenAI {
  static final Uri chatUri = Uri.parse('https://api.openai.com/v1/chat/completions');
  static const model = "gpt-3.5-turbo";

  static final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${ApiKey.openAIApiKey}',
  };

  // Just to test
  String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) =>  random.nextInt(255));
    return base64UrlEncode(values);
  }

  Future<String?> createHistory(FormModel info) async {
    String titleParam = "Título: ${info.title}";
    String placeParam = (info.place != null && info.place != "") ? "Lugar: ${info.place}" : "";
    String mainCharacterParam = (info.mainCharacter != null && info.mainCharacter != "") ? "Personagem Principal: ${info.mainCharacter}" : "";
    String mainCharacterDescriptionParam = (info.mainCharacterDescription != null && info.mainCharacterDescription != "") ? "Descrição do Personagem Principal: ${info.mainCharacterDescription}" : "";
    String contextParam = (info.context != null && info.context != "") ? "Contexto: ${info.context}" : "";
    String problemParam = (info.problem != null && info.problem != "") ? "Problema: ${info.problem}" : "";
    String mainGoalParam = (info.mainGoal != null && info.mainGoal != "") ? "Objetivo Final: ${info.mainGoal}" : "";

    String prompt = """
    Crie uma grande história infantil fantasiosa e com alguns detalhes na qual uma criança irá gostar.
    A história deve conter os seguintes elementos:
    $titleParam
    $placeParam
    $mainCharacterParam
    $mainCharacterDescriptionParam
    $contextParam
    $problemParam
    $mainGoalParam
    Seja detalhista e criativo.
    """;

    ChatRequest request = ChatRequest(model: model, messages: [Message(role: "system", content: prompt)]);
    if (prompt.isEmpty) {
      return null;
    }
    http.Response response = await http.post(
      chatUri,
      headers: headers,
      body: request.toJson(),
    );
    ChatResponse chatResponse = ChatResponse.fromResponse(response);
    return chatResponse.choices?[0].message?.content;
  }
}

class ChatServiceGemini {
  Future<String> createHistory(FormModel info) async {
    String titleParam = "Título: ${info.title}";
    String placeParam = (info.place != null && info.place != "") ? "Lugar: ${info.place}" : "";
    String mainCharacterParam = (info.mainCharacter != null && info.mainCharacter != "") ? "Personagem Principal: ${info.mainCharacter}" : "";
    String mainCharacterDescriptionParam = (info.mainCharacterDescription != null && info.mainCharacterDescription != "") ? "Descrição do Personagem Principal: ${info.mainCharacterDescription}" : "";
    String contextParam = (info.context != null && info.context != "") ? "Contexto: ${info.context}" : "";
    String problemParam = (info.problem != null && info.problem != "") ? "Problema: ${info.problem}" : "";
    String mainGoalParam = (info.mainGoal != null && info.mainGoal != "") ? "Objetivo Final: ${info.mainGoal}" : "";

    String prompt = """
    Crie uma grande história infantil fantasiosa e com alguns detalhes na qual uma criança irá gostar.
    A história deve conter os seguintes elementos:
    $titleParam
    $placeParam
    $mainCharacterParam
    $mainCharacterDescriptionParam
    $contextParam
    $problemParam
    $mainGoalParam
    Seja detalhista e criativo.
    """;

    final apiKey = "AIzaSyCUBfZjojIrLQ4CvTNRo9u4FTWvIVZx4F0";

    // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    print(response.text);
    return response.text!;
  }

  Future<String> generateCharacterDescription(FormModel info) async {
    String prompt = """
    Crie uma descrição física com mais detalhes para o personagem principal de uma história infantil.
    A descrição deve ser basear nessas informações: ${info.mainCharacterDescription}.
    """;

    final apiKey = "AIzaSyCUBfZjojIrLQ4CvTNRo9u4FTWvIVZx4F0";

    // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    return response.text!;
  }
}