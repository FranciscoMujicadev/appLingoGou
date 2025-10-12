// lib/data/models/phrase_model.dart

class Phrase {
  final String id;
  final String idiom;
  final String literalTranslation;
  final String realMeaning;
  final String category;
  final String pronunciation;
  final List<ContextExample> contextExamples;

  Phrase({
    required this.id,
    required this.idiom,
    required this.literalTranslation,
    required this.realMeaning,
    required this.category,
    required this.pronunciation,
    required this.contextExamples,
  });

  // Getters para compatibilidad con código existente
  String get english => idiom;
  String get spanish => realMeaning;

  Map<String, dynamic> toJson() => {
    'id': id,
    'idiom': idiom,
    'literalTranslation': literalTranslation,
    'realMeaning': realMeaning,
    'category': category,
    'pronunciation': pronunciation,
    'contextExamples': contextExamples.map((e) => e.toJson()).toList(),
  };

  factory Phrase.fromJson(Map<String, dynamic> json) => Phrase(
    id: json['id'] ?? '',
    idiom: json['idiom'] ?? '',
    literalTranslation: json['literalTranslation'] ?? '',
    realMeaning: json['realMeaning'] ?? '',
    category: json['category'] ?? '',
    pronunciation: json['pronunciation'] ?? '',
    contextExamples: json['contextExamples'] != null
        ? (json['contextExamples'] as List)
              .map((e) => ContextExample.fromJson(e))
              .toList()
        : [],
  );
}

class ContextExample {
  final String emoji;
  final String context;
  final String englishExample;
  final String spanishExample;
  final String pronunciation; // ← Campo agregado como final

  ContextExample({
    required this.emoji,
    required this.context,
    required this.englishExample,
    required this.spanishExample,
    required this.pronunciation, // ← Ahora es un campo normal
  });

  Map<String, dynamic> toJson() => {
    'emoji': emoji,
    'context': context,
    'englishExample': englishExample,
    'spanishExample': spanishExample,
    'pronunciation': pronunciation, // ← Incluido en toJson
  };

  factory ContextExample.fromJson(Map<String, dynamic> json) => ContextExample(
    emoji: json['emoji'] ?? '',
    context: json['context'] ?? '',
    englishExample: json['englishExample'] ?? '',
    spanishExample: json['spanishExample'] ?? '',
    pronunciation: json['pronunciation'] ?? '', // ← Incluido en fromJson
  );
}
