import 'package:flutter/material.dart';

class AchievementEntity {
  final String title;
  final String description;
  final IconData icon;
  final bool isUnlocked;
  final double progress;

  const AchievementEntity({
    required this.title,
    required this.description,
    required this.icon,
    required this.isUnlocked,
    this.progress = 0.0,
  });

  AchievementEntity copyWith({
    String? title,
    String? description,
    IconData? icon,
    bool? isUnlocked,
    double? progress,
  }) {
    return AchievementEntity(
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      progress: progress ?? this.progress,
    );
  }
}
