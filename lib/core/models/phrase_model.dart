// lib/core/models/phrase_model.dart

import '../../domain/entities/phrase_entity.dart';

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

  // Para compatibilidad con código existente
  String get english => idiom;
  String get spanish => realMeaning;

  // Convertir de Model a Entity
  PhraseEntity toEntity() {
    return PhraseEntity(
      id: id,
      idiom: idiom,
      literalTranslation: literalTranslation,
      realMeaning: realMeaning,
      category: category,
      pronunciation: pronunciation,
      contextExamples: contextExamples.map((e) => e.toEntity()).toList(),
    );
  }

  // Convertir de Entity a Model
  factory Phrase.fromEntity(PhraseEntity entity) {
    return Phrase(
      id: entity.id,
      idiom: entity.idiom,
      literalTranslation: entity.literalTranslation,
      realMeaning: entity.realMeaning,
      category: entity.category,
      pronunciation: entity.pronunciation,
      contextExamples: entity.contextExamples
          .map((e) => ContextExample.fromEntity(e))
          .toList(),
    );
  }

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
    id: json['id'],
    idiom: json['idiom'],
    literalTranslation: json['literalTranslation'],
    realMeaning: json['realMeaning'],
    category: json['category'],
    pronunciation: json['pronunciation'],
    contextExamples: (json['contextExamples'] as List)
        .map((e) => ContextExample.fromJson(e))
        .toList(),
  );
}

class ContextExample {
  final String emoji;
  final String context;
  final String englishExample;
  final String spanishExample;
  final String pronunciation; // ← CAMBIO: Ahora es un campo final normal

  ContextExample({
    required this.emoji,
    required this.context,
    required this.englishExample,
    required this.spanishExample,
    required this.pronunciation, // ← CAMBIO: Ya no pone String antes
  });

  // Convertir de Model a Entity
  ContextExampleEntity toEntity() {
    return ContextExampleEntity(
      emoji: emoji,
      context: context,
      englishExample: englishExample,
      spanishExample: spanishExample,
      pronunciation: pronunciation, // ← CAMBIO: Usa el campo real
    );
  }

  // Convertir de Entity a Model
  factory ContextExample.fromEntity(ContextExampleEntity entity) {
    return ContextExample(
      emoji: entity.emoji,
      context: entity.context,
      englishExample: entity.englishExample,
      spanishExample: entity.spanishExample,
      pronunciation:
          entity.pronunciation, // ← CAMBIO: Usa el campo de la entity
    );
  }

  Map<String, dynamic> toJson() => {
    'emoji': emoji,
    'context': context,
    'englishExample': englishExample,
    'spanishExample': spanishExample,
    'pronunciation': pronunciation, // ← CAMBIO: Incluido en toJson
  };

  factory ContextExample.fromJson(Map<String, dynamic> json) => ContextExample(
    emoji: json['emoji'] ?? '',
    context: json['context'] ?? '',
    englishExample: json['englishExample'] ?? '',
    spanishExample: json['spanishExample'] ?? '',
    pronunciation: json['pronunciation'] ?? '', // ← CAMBIO: Lee del json
  );
}
