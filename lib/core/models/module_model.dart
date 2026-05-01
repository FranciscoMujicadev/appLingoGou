// lib/core/models/module_model.dart

import 'package:flutter/material.dart';

class ModuleSection {
  final String title;
  final Color color;
  const ModuleSection({required this.title, required this.color});
}

class AppModule {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final int startLevel;
  final int endLevel;
  final List<ModuleSection> sections;

  const AppModule({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.startLevel,
    required this.endLevel,
    required this.sections,
  });

  bool containsLevel(int level) => level >= startLevel && level <= endLevel;

  /// Devuelve el título de la sección a la que pertenece [level].
  /// Si el módulo no tiene secciones o el nivel está fuera de rango, devuelve null.
  String? sectionTitleForLevel(int level) {
    if (sections.isEmpty || !containsLevel(level)) return null;
    final totalLevels = endLevel - startLevel + 1;
    final relativeLevel = level - startLevel;
    final sectionIndex =
        (relativeLevel * sections.length ~/ totalLevels).clamp(0, sections.length - 1);
    return sections[sectionIndex].title;
  }
}
