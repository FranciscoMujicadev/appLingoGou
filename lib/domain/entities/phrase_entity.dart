class PhraseEntity {
  final String id;
  final String idiom;
  final String literalTranslation;
  final String realMeaning;
  final String category;
  final String pronunciation;
  final List<ContextExampleEntity> contextExamples;

  const PhraseEntity({
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
  int get index => int.tryParse(id.split('-').last) ?? 0;

  // Método para comparar frases
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PhraseEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class ContextExampleEntity {
  final String emoji;
  final String context;
  final String englishExample;
  final String spanishExample;
  final String pronunciation;

  const ContextExampleEntity({
    required this.emoji,
    required this.context,
    required this.englishExample,
    required this.spanishExample,
    required this.pronunciation,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ContextExampleEntity &&
        other.emoji == emoji &&
        other.context == context &&
        other.englishExample == englishExample &&
        other.spanishExample == spanishExample;
  }

  @override
  int get hashCode =>
      emoji.hashCode ^
      context.hashCode ^
      englishExample.hashCode ^
      spanishExample.hashCode;
}
