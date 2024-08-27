class HistoryItem {
  final int? id;
  final String title;
  final DateTime date;
  final String api;
  final String body;
  final String? image_1_url;
  final String? image_2_url;
  final String? image_3_url;
  final String? image_4_url;
  final String? image_5_url;
  final String? image_6_url;
  final String? image_7_url;
  final String? image_8_url;


  HistoryItem({
    this.id,
    required this.title,
    required this.date,
    required this.api,
    required this.body,
    this.image_1_url,
    this.image_2_url,
    this.image_3_url,
    this.image_4_url,
    this.image_5_url,
    this.image_6_url,
    this.image_7_url,
    this.image_8_url
  });

  HistoryItem copyWith({
    int? id,
    String? title,
    DateTime? date,
    String? api,
    String? body,
    String? image_url_1,
    String? image_2_url,
    String? image_3_url,
    String? image_4_url,
    String? image_5_url,
    String? image_6_url,
    String? image_7_url,
    String? image_8_url
  }) {
    return HistoryItem(
        id: id ?? this.id,
        title: title ?? this.title,
        date: date ?? this.date,
        api: api ?? this.api,
        body: body ?? this.body,
        image_1_url: image_url_1 ?? this.image_1_url,
        image_2_url: image_2_url ?? this.image_2_url,
        image_3_url: image_3_url ?? this.image_3_url,
        image_4_url: image_4_url ?? this.image_4_url,
        image_5_url: image_5_url ?? this.image_5_url,
        image_6_url: image_6_url ?? this.image_6_url,
        image_7_url: image_7_url ?? this.image_7_url,
        image_8_url: image_8_url ?? this.image_8_url
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'api': api,
      'body': body,
      'image_base64_1': image_1_url,
      'image_base64_2': image_2_url,
      'image_base64_3': image_3_url,
      'image_base64_4': image_4_url,
      'image_base64_5': image_5_url,
      'image_base64_6': image_6_url,
      'image_base64_7': image_7_url,
      'image_base64_8': image_8_url
    };
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
        id: map['id'],
        title: map['title'],
        date: DateTime.parse(map['date']),
        api: map['api'],
        body: map['body'],
        image_1_url: map['image_1_url'],
        image_2_url: map['image_2_url'],
        image_3_url: map['image_3_url'],
        image_4_url: map['image_4_url'],
        image_5_url: map['image_5_url'],
        image_6_url: map['image_6_url'],
        image_7_url: map['image_7_url'],
        image_8_url: map['image_8_url']
    );
  }

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
        id: json['id'],
        title: json['title'],
        date: DateTime.tryParse(json['date']) ?? DateTime.now(),
        api: json['api'],
        body: json['body'],
        image_1_url: json['image_1_url'],
        image_2_url: json['image_2_url'],
        image_3_url: json['image_3_url'],
        image_4_url: json['image_4_url'],
        image_5_url: json['image_5_url'],
        image_6_url: json['image_6_url'],
        image_7_url: json['image_7_url'],
        image_8_url: json['image_8_url']
    );
  }

  // tojson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'api': api,
      'body': body,
      'image_1_url': image_1_url,
      'image_2_url': image_2_url,
      'image_3_url': image_3_url,
      'image_4_url': image_4_url,
      'image_5_url': image_5_url,
      'image_6_url': image_6_url,
      'image_7_url': image_7_url,
      'image_8_url': image_8_url
    };
  }
}