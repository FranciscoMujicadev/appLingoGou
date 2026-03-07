// scripts/update_phrases_datasource.dart

import 'dart:io';

void main() {
  print('🔧 Actualizando phrases_datasource.dart...\n');

  final buffer = StringBuffer();

  // Imports iniciales
  buffer.writeln("// lib/data/datasources/phrases_datasource.dart\n");
  buffer.writeln("import 'package:flutter/material.dart';");
  buffer.writeln("import '../../core/models/phrase_model.dart';");
  buffer.writeln("import '../../core/models/category_model.dart';");
  buffer.writeln("import '../../core/models/day_progress_model.dart';");
  buffer.writeln("import '../../../core/service/progress_service.dart';\n");

  // Imports de días 1-100
  buffer.writeln("// Importar todos los datasources de días");
  for (int i = 1; i <= 100; i++) {
    buffer.writeln("import 'days/day${i}_datasource.dart';");
  }

  buffer.writeln("\nabstract class PhrasesDataSource {");
  buffer.writeln("  List<CategoryModel> getCategories();");
  buffer.writeln("  List<Phrase> getPhrasesByCategory(String category);");
  buffer.writeln("  List<Phrase> getAllPhrases();");
  buffer.writeln("  String getDailyChallenge(String day);");
  buffer.writeln("  Future<Map<String, DayProgressModel>> getDaysProgress();");
  buffer.writeln(
    "  Future<void> markPhraseAsUsed(String dayId, int phraseIndex);",
  );
  buffer.writeln("  Future<String> getInitialDay();");
  buffer.writeln("  Future<void> completeDayAndUnlockNext(String currentDay);");
  buffer.writeln("  Future<void> confirmDayChallenge(String dayId);");
  buffer.writeln("}\n");

  buffer.writeln("class PhrasesDataSourceImpl implements PhrasesDataSource {");
  buffer.writeln(
    "  final ProgressService _progressService = ProgressService();\n",
  );

  // Mapa de frases
  buffer.writeln("  // Mapa centralizado que obtiene las frases de cada día");
  buffer.writeln("  final Map<String, List<Phrase>> _phrasesByCategory = {");
  for (int i = 1; i <= 100; i++) {
    buffer.writeln("    'Día $i': Day${i}DataSource.getPhrases(),");
  }
  buffer.writeln("  };\n");

  // Mapa de desafíos
  buffer.writeln("  // Mapa de desafíos diarios");
  buffer.writeln("  final Map<String, String> _dailyChallenges = {");
  for (int i = 1; i <= 100; i++) {
    buffer.writeln("    'Día $i': Day${i}DataSource.getDailyChallenge(),");
  }
  buffer.writeln("  };\n");

  // Método getCategories con iconos
  buffer.writeln("  @override");
  buffer.writeln("  List<CategoryModel> getCategories() {");
  buffer.writeln("    return const [");

  // Días con iconos específicos (1-9 tienen iconos especiales)
  final iconMap = {
    1: 'Icons.looks_one',
    2: 'Icons.looks_two',
    3: 'Icons.looks_3',
    4: 'Icons.looks_4',
    5: 'Icons.looks_5',
    6: 'Icons.looks_6',
    7: 'Icons.number_7',
    8: 'Icons.number_8',
    9: 'Icons.number_9',
  };

  for (int i = 1; i <= 100; i++) {
    final icon = iconMap[i] ?? 'Icons.calendar_today';
    buffer.writeln("      CategoryModel(name: 'Día $i', icon: $icon),");
  }

  buffer.writeln("    ];");
  buffer.writeln("  }\n");

  // Resto de métodos
  buffer.writeln("  @override");
  buffer.writeln("  List<Phrase> getPhrasesByCategory(String category) {");
  buffer.writeln("    return _phrasesByCategory[category] ?? [];");
  buffer.writeln("  }\n");

  buffer.writeln("  @override");
  buffer.writeln("  List<Phrase> getAllPhrases() {");
  buffer.writeln(
    "    return _phrasesByCategory.values.expand((phrases) => phrases).toList();",
  );
  buffer.writeln("  }\n");

  buffer.writeln("  @override");
  buffer.writeln("  String getDailyChallenge(String day) {");
  buffer.writeln(
    "    return _dailyChallenges[day] ?? 'Practica los idioms de hoy en situaciones reales.';",
  );
  buffer.writeln("  }\n");

  buffer.writeln("  @override");
  buffer.writeln(
    "  Future<Map<String, DayProgressModel>> getDaysProgress() async {",
  );
  buffer.writeln("    return await _progressService.getProgress();");
  buffer.writeln("  }\n");

  buffer.writeln("  @override");
  buffer.writeln(
    "  Future<void> markPhraseAsUsed(String dayId, int phraseIndex) async {",
  );
  buffer.writeln(
    "    await _progressService.markPhraseAsUsed(dayId, phraseIndex);",
  );
  buffer.writeln("  }\n");

  buffer.writeln("  @override");
  buffer.writeln("  Future<String> getInitialDay() async {");
  buffer.writeln("    return await _progressService.getFirstUnlockedDay();");
  buffer.writeln("  }\n");

  buffer.writeln("  @override");
  buffer.writeln(
    "  Future<void> completeDayAndUnlockNext(String currentDay) async {",
  );
  buffer.writeln(
    "    await _progressService.completeDayAndUnlockNext(currentDay);",
  );
  buffer.writeln("  }\n");

  buffer.writeln("  @override");
  buffer.writeln("  Future<void> confirmDayChallenge(String dayId) async {");
  buffer.writeln("    await _progressService.confirmDayChallenge(dayId);");
  buffer.writeln("  }");
  buffer.writeln("}");

  // Escribir archivo
  final file = File('lib/data/datasources/phrases_datasource.dart');
  file.writeAsStringSync(buffer.toString());

  print('✅ phrases_datasource.dart actualizado con 100 días!');
}
