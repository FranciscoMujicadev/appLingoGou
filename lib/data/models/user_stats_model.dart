class UserStatsModel {
  final int phrasesViewed;
  final int shareAttempts;
  final Set<String> exploredCategories;
  final Set<String> viewedPhrases;

  const UserStatsModel({
    required this.phrasesViewed,
    required this.shareAttempts,
    required this.exploredCategories,
    required this.viewedPhrases,
  });

  // Crear desde JSON
  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    return UserStatsModel(
      phrasesViewed: json['phrasesViewed'] as int? ?? 0,
      shareAttempts: json['shareAttempts'] as int? ?? 0,
      exploredCategories: Set<String>.from(
        json['exploredCategories'] as List<dynamic>? ?? [],
      ),
      viewedPhrases: Set<String>.from(
        json['viewedPhrases'] as List<dynamic>? ?? [],
      ),
    );
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'phrasesViewed': phrasesViewed,
      'shareAttempts': shareAttempts,
      'exploredCategories': exploredCategories.toList(),
      'viewedPhrases': viewedPhrases.toList(),
    };
  }

  // Crear instancia vacía
  factory UserStatsModel.empty() {
    return const UserStatsModel(
      phrasesViewed: 0,
      shareAttempts: 0,
      exploredCategories: {},
      viewedPhrases: {},
    );
  }

  // Copiar con modificaciones
  UserStatsModel copyWith({
    int? phrasesViewed,
    int? shareAttempts,
    Set<String>? exploredCategories,
    Set<String>? viewedPhrases,
  }) {
    return UserStatsModel(
      phrasesViewed: phrasesViewed ?? this.phrasesViewed,
      shareAttempts: shareAttempts ?? this.shareAttempts,
      exploredCategories: exploredCategories ?? this.exploredCategories,
      viewedPhrases: viewedPhrases ?? this.viewedPhrases,
    );
  }
}
