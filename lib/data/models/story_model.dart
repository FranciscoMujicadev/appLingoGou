import '../../domain/entities/story.dart';

class StoryModel extends Story {
  StoryModel({
    required super.id,
    required super.title,
    required super.level,
    required super.content,
    required super.contentSpanish, // NUEVO
    required super.estimatedReadingTime,
    required super.category,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'] as int,
      title: json['title'] as String,
      level: json['level'] as String,
      content: json['content'] as String,
      contentSpanish: json['contentSpanish'] as String, // NUEVO
      estimatedReadingTime: json['estimatedReadingTime'] as int,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'level': level,
      'content': content,
      'contentSpanish': contentSpanish, // NUEVO
      'estimatedReadingTime': estimatedReadingTime,
      'category': category,
    };
  }
}
