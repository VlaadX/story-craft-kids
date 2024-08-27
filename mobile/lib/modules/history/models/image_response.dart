import 'dart:convert';

class ImageResponse {
  final int? created;
  final Data data;

  const ImageResponse({
    required this.created,
    required this.data,
  });

  factory ImageResponse.fromResponse(String responseBody) {
    Map<String, dynamic> parsedBody = json.decode(responseBody);

    return ImageResponse(
      created: parsedBody['created'],
      data: Data.fromJson(parsedBody['data'][0]),
    );
  }
}

class Data {
  final String revisedPrompt;
  final String url;

  const Data(this.revisedPrompt, this.url);

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      json['revised_prompt'],
      json['url'],
    );
  }
}