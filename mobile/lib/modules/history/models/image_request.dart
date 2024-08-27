import 'dart:convert';

class ImageRequest {
  final String model;
  final String prompt;
  final int n;
  final String size;

  ImageRequest({
    required this.model,
    required this.prompt,
    required this.n,
    required this.size,
  });

  String toJson() {
    Map<String, dynamic> jsonBody = {
      'model': model,
      'prompt': prompt,
      'n': n,
      'size': size,
    };

    return json.encode(jsonBody);
  }
}
