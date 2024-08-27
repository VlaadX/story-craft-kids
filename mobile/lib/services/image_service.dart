import 'package:http/http.dart' as http;
import 'package:story_craft_kids/modules/history/models/image_response.dart';
import '../modules/history/models/chat_request.dart';
import '../modules/history/models/chat_response.dart';
import '../modules/history/models/image_request.dart';
import '../modules/home/model.dart';
import 'api_key.dart';

import 'dart:math';
import 'dart:convert';


class ImageService {
  // mocking the api to test the app
  // static final Uri imageUri = Uri.parse('https://mock_86eda6be3a9f43eaaed3ccacc63c2191.mock.insomnia.rest/v1/images/generations');
  static final Uri imageUri = Uri.parse('https://api.openai.com/v1/images/generations');
  static const model = "dall-e-3";

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

  Future<String?> request(String context, String mainCharacterDescription) async {
    String prompt = """
    Crie uma imagem agradavel para uma criança baseada no seguinte contexto:,
    contexto: ${context}
    personagem principal : ${mainCharacterDescription}

    A imagem está sendo usada para ilustrar uma história infantil.
    É muito importante que a imagem não contenha algo que possa ser considerado ofensivo ou inadequado para crianças.
    É importante que a imagem seja agradável e que a criança possa se identificar com ela.
    """;

    ImageRequest request = ImageRequest(model: model, prompt: prompt, n: 1, size: "1024x1024");

    if (prompt.isEmpty) {
      return null;
    }

    http.Response response = await http.post(
      imageUri,
      headers: headers,
      body: request.toJson(),
    );

    ImageResponse imageResponse = ImageResponse.fromResponse(response.body);

    return imageResponse.data.url;
  }
}
