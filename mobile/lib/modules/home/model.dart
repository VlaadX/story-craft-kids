class FormModel {
  final String title;
  final String? place;
  final String? mainCharacter;
  final String? mainCharacterDescription;
  final String? context;
  final String? problem;
  final String? mainGoal;
  final String? details;
  final String api;

  FormModel({
    required this.title,
    this.place,
    this.mainCharacter,
    this.mainCharacterDescription,
    this.context,
    this.problem,
    this.mainGoal,
    this.details,
    required this.api
  });

  FormModel copyWith({
    String? title,
    String? place,
    String? mainCharacter,
    String? mainCharacterDescription,
    String? context,
    String? problem,
    String? mainGoal,
    String? details,
    String? api
  }) {
    return FormModel(
      title: title ?? this.title,
      place: place ?? this.place,
      mainCharacter: mainCharacter ?? this.mainCharacter,
      mainCharacterDescription: mainCharacterDescription ?? this.mainCharacterDescription,
      context: context ?? this.context,
      problem: problem ?? this.problem,
      mainGoal: mainGoal ?? this.mainGoal,
      details: details ?? this.details,
      api: api ?? this.api
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'place': place,
      'mainCharacter': mainCharacter,
      'mainCharacterDescription': mainCharacterDescription,
      'context': context,
      'problem': problem,
      'mainGoal': mainGoal,
      'details': details,
      'api': api
    };
  }

  factory FormModel.fromMap(Map<String, dynamic> map) {
    return FormModel(
      title: map['title'],
      place: map['place'],
      mainCharacter: map['mainCharacter'],
      mainCharacterDescription: map['mainCharacterDescription'],
      context: map['context'],
      problem: map['problem'],
      mainGoal: map['mainGoal'],
      details: map['details'],
      api: map['api']
    );
  }
}