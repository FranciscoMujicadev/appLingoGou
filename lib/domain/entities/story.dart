class Story {
  final int id;
  final String title;
  final String level;
  final String content;
  final String contentSpanish; // NUEVO - Traducción al español
  final int estimatedReadingTime;
  final String category;

  Story({
    required this.id,
    required this.title,
    required this.level,
    required this.content,
    required this.contentSpanish, // NUEVO
    required this.estimatedReadingTime,
    required this.category,
  });
}
