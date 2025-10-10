// Archivo: lib/core/models/day_progress_model.dart

class DayProgressModel {
  final String dayId;
  final bool isUnlocked;
  final bool isCompleted;
  final List<bool> phrasesUsed;
  final DateTime? completedAt;
  final bool challengeConfirmed; // ← LÍNEA NUEVA

  const DayProgressModel({
    required this.dayId,
    this.isUnlocked = false,
    this.isCompleted = false,
    this.phrasesUsed = const [false, false, false, false, false],
    this.completedAt,
    this.challengeConfirmed = false, // ← LÍNEA NUEVA
  });

  DayProgressModel copyWith({
    String? dayId,
    bool? isUnlocked,
    bool? isCompleted,
    List<bool>? phrasesUsed,
    DateTime? completedAt,
    bool? challengeConfirmed, // ← LÍNEA NUEVA
  }) {
    return DayProgressModel(
      dayId: dayId ?? this.dayId,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isCompleted: isCompleted ?? this.isCompleted,
      phrasesUsed: phrasesUsed ?? this.phrasesUsed,
      completedAt: completedAt ?? this.completedAt,
      challengeConfirmed:
          challengeConfirmed ?? this.challengeConfirmed, // ← LÍNEA NUEVA
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayId': dayId,
      'isUnlocked': isUnlocked,
      'isCompleted': isCompleted,
      'phrasesUsed': phrasesUsed,
      'completedAt': completedAt?.toIso8601String(),
      'challengeConfirmed': challengeConfirmed, // ← LÍNEA NUEVA
    };
  }

  factory DayProgressModel.fromJson(Map<String, dynamic> json) {
    return DayProgressModel(
      dayId: json['dayId'] as String,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      phrasesUsed:
          (json['phrasesUsed'] as List<dynamic>?)
              ?.map((e) => e as bool)
              .toList() ??
          [false, false, false, false, false],
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      challengeConfirmed:
          json['challengeConfirmed'] as bool? ?? false, // ← LÍNEA NUEVA
    );
  }

  bool get allPhrasesUsed {
    return phrasesUsed.every((used) => used);
  }

  int get progressPercentage {
    final usedCount = phrasesUsed.where((used) => used).length;
    return (usedCount / phrasesUsed.length * 100).round();
  }
}
