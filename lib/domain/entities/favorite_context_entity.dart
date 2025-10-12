// lib/domain/entities/favorite_context_entity.dart

class FavoriteContextEntity {
  final String id;
  final String phraseId;
  final String phraseIdiom;
  final String emoji;
  final String context;
  final String englishExample;
  final String spanishExample;
  final String pronunciation;
  final String category;

  const FavoriteContextEntity({
    required this.id,
    required this.phraseId,
    required this.phraseIdiom,
    required this.emoji,
    required this.context,
    required this.englishExample,
    required this.spanishExample,
    required this.pronunciation,
    required this.category,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FavoriteContextEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phraseId': phraseId,
      'phraseIdiom': phraseIdiom,
      'emoji': emoji,
      'context': context,
      'englishExample': englishExample,
      'spanishExample': spanishExample,
      'pronunciation': pronunciation,
      'category': category,
    };
  }

  factory FavoriteContextEntity.fromJson(Map<String, dynamic> json) {
    return FavoriteContextEntity(
      id: json['id'] as String,
      phraseId: json['phraseId'] as String,
      phraseIdiom: json['phraseIdiom'] as String,
      emoji: json['emoji'] as String,
      context: json['context'] as String,
      englishExample: json['englishExample'] as String,
      spanishExample: json['spanishExample'] as String,
      pronunciation: json['pronunciation'] as String,
      category: json['category'] as String,
    );
  }
}
