// lib/data/datasources/phrases_datasource.dart

import 'package:flutter/material.dart';
import '../../core/models/phrase_model.dart';
import '../../core/models/category_model.dart';
import '../../core/models/day_progress_model.dart';
import '../../core/service/progress_service.dart';

// Importar todos los datasources de días
import 'days/day1_datasource.dart';
import 'days/day2_datasource.dart';
import 'days/day3_datasource.dart';
import 'days/day4_datasource.dart';
import 'days/day5_datasource.dart';
import 'days/day6_datasource.dart';
import 'days/day7_datasource.dart';
import 'days/day8_datasource.dart';
import 'days/day9_datasource.dart';
import 'days/day10_datasource.dart';
import 'days/day11_datasource.dart';
import 'days/day12_datasource.dart';
import 'days/day13_datasource.dart';
import 'days/day14_datasource.dart';
import 'days/day15_datasource.dart';
import 'days/day16_datasource.dart';
import 'days/day17_datasource.dart';
import 'days/day18_datasource.dart';
import 'days/day19_datasource.dart';
import 'days/day20_datasource.dart';
import 'days/day21_datasource.dart';
import 'days/day22_datasource.dart';
import 'days/day23_datasource.dart';
import 'days/day24_datasource.dart';
import 'days/day25_datasource.dart';
import 'days/day26_datasource.dart';
import 'days/day27_datasource.dart';
import 'days/day28_datasource.dart';
import 'days/day29_datasource.dart';
import 'days/day30_datasource.dart';
import 'days/day31_datasource.dart';
import 'days/day32_datasource.dart';
import 'days/day33_datasource.dart';
import 'days/day34_datasource.dart';
import 'days/day35_datasource.dart';
import 'days/day36_datasource.dart';
import 'days/day37_datasource.dart';
import 'days/day38_datasource.dart';
import 'days/day39_datasource.dart';
import 'days/day40_datasource.dart';
import 'days/day41_datasource.dart';
import 'days/day42_datasource.dart';
import 'days/day43_datasource.dart';
import 'days/day44_datasource.dart';
import 'days/day45_datasource.dart';
import 'days/day46_datasource.dart';
import 'days/day47_datasource.dart';
import 'days/day48_datasource.dart';
import 'days/day49_datasource.dart';
import 'days/day50_datasource.dart';
import 'days/day51_datasource.dart';
import 'days/day52_datasource.dart';
import 'days/day53_datasource.dart';
import 'days/day54_datasource.dart';
import 'days/day55_datasource.dart';
import 'days/day56_datasource.dart';
import 'days/day57_datasource.dart';
import 'days/day58_datasource.dart';
import 'days/day59_datasource.dart';
import 'days/day60_datasource.dart';
import 'days/day61_datasource.dart';
import 'days/day62_datasource.dart';
import 'days/day63_datasource.dart';
import 'days/day64_datasource.dart';
import 'days/day65_datasource.dart';
import 'days/day66_datasource.dart';
import 'days/day67_datasource.dart';
import 'days/day68_datasource.dart';
import 'days/day69_datasource.dart';
import 'days/day70_datasource.dart';
import 'days/day71_datasource.dart';
import 'days/day72_datasource.dart';
import 'days/day73_datasource.dart';
import 'days/day74_datasource.dart';
import 'days/day75_datasource.dart';
import 'days/day76_datasource.dart';
import 'days/day77_datasource.dart';
import 'days/day78_datasource.dart';
import 'days/day79_datasource.dart';
import 'days/day80_datasource.dart';
import 'days/day81_datasource.dart';
import 'days/day82_datasource.dart';
import 'days/day83_datasource.dart';
import 'days/day84_datasource.dart';
import 'days/day85_datasource.dart';
import 'days/day86_datasource.dart';
import 'days/day87_datasource.dart';
import 'days/day88_datasource.dart';
import 'days/day89_datasource.dart';
import 'days/day90_datasource.dart';
import 'days/day91_datasource.dart';
import 'days/day92_datasource.dart';
import 'days/day93_datasource.dart';
import 'days/day94_datasource.dart';
import 'days/day95_datasource.dart';
import 'days/day96_datasource.dart';
import 'days/day97_datasource.dart';
import 'days/day98_datasource.dart';
import 'days/day99_datasource.dart';
import 'days/day100_datasource.dart';
import 'days/business_interviews_datasource.dart';
import 'days/business_interviews_lesson3_datasource.dart';
import 'days/business_interviews_lesson4_datasource.dart';
import 'days/business_interviews_lesson5_datasource.dart';
import 'days/business_interviews_lesson6_datasource.dart';
import 'days/business_interviews_lesson7_datasource.dart';
import 'days/business_interviews_lesson8_datasource.dart';
import 'days/business_interviews_lesson9_datasource.dart';
import 'days/business_interviews_lesson10_datasource.dart';
import 'days/business_interviews_lesson11_datasource.dart';
import 'days/business_interviews_lesson12_datasource.dart';
import 'days/business_interviews_lesson13_datasource.dart';
import 'days/business_interviews_lesson14_datasource.dart';
import 'days/business_interviews_lesson15_datasource.dart';
import 'days/business_interviews_lesson16_datasource.dart';
import 'days/business_interviews_lesson17_datasource.dart';
import 'days/business_interviews_lesson18_datasource.dart';

abstract class PhrasesDataSource {
  List<CategoryModel> getCategories();
  List<Phrase> getPhrasesByCategory(String category);
  List<Phrase> getAllPhrases();
  String getDailyChallenge(String day);
  Future<Map<String, DayProgressModel>> getDaysProgress();
  Future<void> markPhraseAsUsed(String dayId, int phraseIndex);
  Future<String> getInitialDay();
  Future<void> completeDayAndUnlockNext(String currentDay);
  Future<void> confirmDayChallenge(String dayId);
}

class PhrasesDataSourceImpl implements PhrasesDataSource {
  final ProgressService _progressService = ProgressService();

  // Mapa centralizado que obtiene las frases de cada nivel desde sus archivos individuales
  final Map<String, List<Phrase>> _phrasesByCategory = {
    'Nivel 1': Day15DataSource.getPhrases(),
    'Nivel 2': Day17DataSource.getPhrases(),
    'Nivel 3': Day24DataSource.getPhrases(),
    'Nivel 4': Day81DataSource.getPhrases(),
    'Nivel 5': Day2DataSource.getPhrases(),
    'Nivel 6': Day28DataSource.getPhrases(),
    'Nivel 7': Day4DataSource.getPhrases(),
    'Nivel 8': Day48DataSource.getPhrases(),
    'Nivel 9': Day49DataSource.getPhrases(),
    'Nivel 10': Day50DataSource.getPhrases(),
    'Nivel 11': Day68DataSource.getPhrases(),
    'Nivel 12': Day71DataSource.getPhrases(),
    'Nivel 13': Day72DataSource.getPhrases(),
    'Nivel 14': Day73DataSource.getPhrases(),
    'Nivel 15': Day74DataSource.getPhrases(),
    'Nivel 16': Day26DataSource.getPhrases(),
    'Nivel 17': Day70DataSource.getPhrases(),
    'Nivel 18': Day8DataSource.getPhrases(),
    'Nivel 19': Day16DataSource.getPhrases(),
    'Nivel 20': Day19DataSource.getPhrases(),
    'Nivel 21': Day45DataSource.getPhrases(),
    'Nivel 22': Day30DataSource.getPhrases(),
    'Nivel 23': Day5DataSource.getPhrases(),
    'Nivel 24': Day63DataSource.getPhrases(),
    'Nivel 25': Day64DataSource.getPhrases(),
    'Nivel 26': Day69DataSource.getPhrases(),
    'Nivel 27': Day13DataSource.getPhrases(),
    'Nivel 28': Day76DataSource.getPhrases(),
    'Nivel 29': Day20DataSource.getPhrases(),
    'Nivel 30': Day23DataSource.getPhrases(),
    'Nivel 31': Day47DataSource.getPhrases(),
    'Nivel 32': Day18DataSource.getPhrases(),
    'Nivel 33': Day21DataSource.getPhrases(),
    'Nivel 34': Day40DataSource.getPhrases(),
    'Nivel 35': Day75DataSource.getPhrases(),
    'Nivel 36': Day87DataSource.getPhrases(),
    'Nivel 37': Day39DataSource.getPhrases(),
    'Nivel 38': Day61DataSource.getPhrases(),
    'Nivel 39': Day62DataSource.getPhrases(),
    'Nivel 40': Day34DataSource.getPhrases(),
    'Nivel 41': Day37DataSource.getPhrases(),
    'Nivel 42': Day38DataSource.getPhrases(),
    'Nivel 43': Day41DataSource.getPhrases(),
    'Nivel 44': Day57DataSource.getPhrases(),
    'Nivel 45': Day65DataSource.getPhrases(),
    'Nivel 46': Day66DataSource.getPhrases(),
    'Nivel 47': Day55DataSource.getPhrases(),
    'Nivel 48': Day89DataSource.getPhrases(),
    'Nivel 49': Day31DataSource.getPhrases(),
    'Nivel 50': Day51DataSource.getPhrases(),
    'Nivel 51': Day54DataSource.getPhrases(),
    'Nivel 52': Day56DataSource.getPhrases(),
    'Nivel 53': Day58DataSource.getPhrases(),
    'Nivel 54': Day6DataSource.getPhrases(),
    'Nivel 55': Day1DataSource.getPhrases(),
    'Nivel 56': Day22DataSource.getPhrases(),
    'Nivel 57': Day25DataSource.getPhrases(),
    'Nivel 58': Day85DataSource.getPhrases(),
    'Nivel 59': Day11DataSource.getPhrases(),
    'Nivel 60': Day52DataSource.getPhrases(),
    'Nivel 61': Day98DataSource.getPhrases(),
    'Nivel 62': Day10DataSource.getPhrases(),
    'Nivel 63': Day33DataSource.getPhrases(),
    'Nivel 64': Day53DataSource.getPhrases(),
    'Nivel 65': Day60DataSource.getPhrases(),
    'Nivel 66': Day32DataSource.getPhrases(),
    'Nivel 67': Day46DataSource.getPhrases(),
    'Nivel 68': Day77DataSource.getPhrases(),
    'Nivel 69': Day82DataSource.getPhrases(),
    'Nivel 70': Day83DataSource.getPhrases(),
    'Nivel 71': Day88DataSource.getPhrases(),
    'Nivel 72': Day90DataSource.getPhrases(),
    'Nivel 73': Day27DataSource.getPhrases(),
    'Nivel 74': Day67DataSource.getPhrases(),
    'Nivel 75': Day79DataSource.getPhrases(),
    'Nivel 76': Day9DataSource.getPhrases(),
    'Nivel 77': Day93DataSource.getPhrases(),
    'Nivel 78': Day44DataSource.getPhrases(),
    'Nivel 79': Day84DataSource.getPhrases(),
    'Nivel 80': Day96DataSource.getPhrases(),
    'Nivel 81': Day3DataSource.getPhrases(),
    'Nivel 82': Day35DataSource.getPhrases(),
    'Nivel 83': Day43DataSource.getPhrases(),
    'Nivel 84': Day78DataSource.getPhrases(),
    'Nivel 85': Day100DataSource.getPhrases(),
    'Nivel 86': Day36DataSource.getPhrases(),
    'Nivel 87': Day7DataSource.getPhrases(),
    'Nivel 88': Day86DataSource.getPhrases(),
    'Nivel 89': Day91DataSource.getPhrases(),
    'Nivel 90': Day92DataSource.getPhrases(),
    'Nivel 91': Day94DataSource.getPhrases(),
    'Nivel 92': Day97DataSource.getPhrases(),
    'Nivel 93': Day80DataSource.getPhrases(),
    'Nivel 94': Day12DataSource.getPhrases(),
    'Nivel 95': Day99DataSource.getPhrases(),
    'Nivel 96': Day59DataSource.getPhrases(),
    'Nivel 97': Day29DataSource.getPhrases(),
    'Nivel 98': Day42DataSource.getPhrases(),
    'Nivel 99': Day95DataSource.getPhrases(),
    'Nivel 100': Day14DataSource.getPhrases(),
    'Nivel 101': BusinessInterviewsDataSource.getPhrases(),
    'Nivel 102': BusinessInterviewsLesson3DataSource.getPhrases(),
    'Nivel 103': BusinessInterviewsLesson4DataSource.getPhrases(),
    'Nivel 104': BusinessInterviewsLesson5DataSource.getPhrases(),
    'Nivel 105': BusinessInterviewsLesson6DataSource.getPhrases(),
    'Nivel 106': BusinessInterviewsLesson7DataSource.getPhrases(),
    'Nivel 107': BusinessInterviewsLesson8DataSource.getPhrases(),
    'Nivel 108': BusinessInterviewsLesson9DataSource.getPhrases(),
    'Nivel 109': BusinessInterviewsLesson10DataSource.getPhrases(),
    'Nivel 110': BusinessInterviewsLesson11DataSource.getPhrases(),
    'Nivel 111': BusinessInterviewsLesson12DataSource.getPhrases(),
    'Nivel 112': BusinessInterviewsLesson13DataSource.getPhrases(),
    'Nivel 113': BusinessInterviewsLesson14DataSource.getPhrases(),
    'Nivel 114': BusinessInterviewsLesson15DataSource.getPhrases(),
    'Nivel 115': BusinessInterviewsLesson16DataSource.getPhrases(),
    'Nivel 116': BusinessInterviewsLesson17DataSource.getPhrases(),
    'Nivel 117': BusinessInterviewsLesson18DataSource.getPhrases(),
  };

  // Mapa de desafíos diarios
  final Map<String, String> _dailyChallenges = {
    'Nivel 1': Day15DataSource.getDailyChallenge(),
    'Nivel 2': Day17DataSource.getDailyChallenge(),
    'Nivel 3': Day24DataSource.getDailyChallenge(),
    'Nivel 4': Day81DataSource.getDailyChallenge(),
    'Nivel 5': Day2DataSource.getDailyChallenge(),
    'Nivel 6': Day28DataSource.getDailyChallenge(),
    'Nivel 7': Day4DataSource.getDailyChallenge(),
    'Nivel 8': Day48DataSource.getDailyChallenge(),
    'Nivel 9': Day49DataSource.getDailyChallenge(),
    'Nivel 10': Day50DataSource.getDailyChallenge(),
    'Nivel 11': Day68DataSource.getDailyChallenge(),
    'Nivel 12': Day71DataSource.getDailyChallenge(),
    'Nivel 13': Day72DataSource.getDailyChallenge(),
    'Nivel 14': Day73DataSource.getDailyChallenge(),
    'Nivel 15': Day74DataSource.getDailyChallenge(),
    'Nivel 16': Day26DataSource.getDailyChallenge(),
    'Nivel 17': Day70DataSource.getDailyChallenge(),
    'Nivel 18': Day8DataSource.getDailyChallenge(),
    'Nivel 19': Day16DataSource.getDailyChallenge(),
    'Nivel 20': Day19DataSource.getDailyChallenge(),
    'Nivel 21': Day45DataSource.getDailyChallenge(),
    'Nivel 22': Day30DataSource.getDailyChallenge(),
    'Nivel 23': Day5DataSource.getDailyChallenge(),
    'Nivel 24': Day63DataSource.getDailyChallenge(),
    'Nivel 25': Day64DataSource.getDailyChallenge(),
    'Nivel 26': Day69DataSource.getDailyChallenge(),
    'Nivel 27': Day13DataSource.getDailyChallenge(),
    'Nivel 28': Day76DataSource.getDailyChallenge(),
    'Nivel 29': Day20DataSource.getDailyChallenge(),
    'Nivel 30': Day23DataSource.getDailyChallenge(),
    'Nivel 31': Day47DataSource.getDailyChallenge(),
    'Nivel 32': Day18DataSource.getDailyChallenge(),
    'Nivel 33': Day21DataSource.getDailyChallenge(),
    'Nivel 34': Day40DataSource.getDailyChallenge(),
    'Nivel 35': Day75DataSource.getDailyChallenge(),
    'Nivel 36': Day87DataSource.getDailyChallenge(),
    'Nivel 37': Day39DataSource.getDailyChallenge(),
    'Nivel 38': Day61DataSource.getDailyChallenge(),
    'Nivel 39': Day62DataSource.getDailyChallenge(),
    'Nivel 40': Day34DataSource.getDailyChallenge(),
    'Nivel 41': Day37DataSource.getDailyChallenge(),
    'Nivel 42': Day38DataSource.getDailyChallenge(),
    'Nivel 43': Day41DataSource.getDailyChallenge(),
    'Nivel 44': Day57DataSource.getDailyChallenge(),
    'Nivel 45': Day65DataSource.getDailyChallenge(),
    'Nivel 46': Day66DataSource.getDailyChallenge(),
    'Nivel 47': Day55DataSource.getDailyChallenge(),
    'Nivel 48': Day89DataSource.getDailyChallenge(),
    'Nivel 49': Day31DataSource.getDailyChallenge(),
    'Nivel 50': Day51DataSource.getDailyChallenge(),
    'Nivel 51': Day54DataSource.getDailyChallenge(),
    'Nivel 52': Day56DataSource.getDailyChallenge(),
    'Nivel 53': Day58DataSource.getDailyChallenge(),
    'Nivel 54': Day6DataSource.getDailyChallenge(),
    'Nivel 55': Day1DataSource.getDailyChallenge(),
    'Nivel 56': Day22DataSource.getDailyChallenge(),
    'Nivel 57': Day25DataSource.getDailyChallenge(),
    'Nivel 58': Day85DataSource.getDailyChallenge(),
    'Nivel 59': Day11DataSource.getDailyChallenge(),
    'Nivel 60': Day52DataSource.getDailyChallenge(),
    'Nivel 61': Day98DataSource.getDailyChallenge(),
    'Nivel 62': Day10DataSource.getDailyChallenge(),
    'Nivel 63': Day33DataSource.getDailyChallenge(),
    'Nivel 64': Day53DataSource.getDailyChallenge(),
    'Nivel 65': Day60DataSource.getDailyChallenge(),
    'Nivel 66': Day32DataSource.getDailyChallenge(),
    'Nivel 67': Day46DataSource.getDailyChallenge(),
    'Nivel 68': Day77DataSource.getDailyChallenge(),
    'Nivel 69': Day82DataSource.getDailyChallenge(),
    'Nivel 70': Day83DataSource.getDailyChallenge(),
    'Nivel 71': Day88DataSource.getDailyChallenge(),
    'Nivel 72': Day90DataSource.getDailyChallenge(),
    'Nivel 73': Day27DataSource.getDailyChallenge(),
    'Nivel 74': Day67DataSource.getDailyChallenge(),
    'Nivel 75': Day79DataSource.getDailyChallenge(),
    'Nivel 76': Day9DataSource.getDailyChallenge(),
    'Nivel 77': Day93DataSource.getDailyChallenge(),
    'Nivel 78': Day44DataSource.getDailyChallenge(),
    'Nivel 79': Day84DataSource.getDailyChallenge(),
    'Nivel 80': Day96DataSource.getDailyChallenge(),
    'Nivel 81': Day3DataSource.getDailyChallenge(),
    'Nivel 82': Day35DataSource.getDailyChallenge(),
    'Nivel 83': Day43DataSource.getDailyChallenge(),
    'Nivel 84': Day78DataSource.getDailyChallenge(),
    'Nivel 85': Day100DataSource.getDailyChallenge(),
    'Nivel 86': Day36DataSource.getDailyChallenge(),
    'Nivel 87': Day7DataSource.getDailyChallenge(),
    'Nivel 88': Day86DataSource.getDailyChallenge(),
    'Nivel 89': Day91DataSource.getDailyChallenge(),
    'Nivel 90': Day92DataSource.getDailyChallenge(),
    'Nivel 91': Day94DataSource.getDailyChallenge(),
    'Nivel 92': Day97DataSource.getDailyChallenge(),
    'Nivel 93': Day80DataSource.getDailyChallenge(),
    'Nivel 94': Day12DataSource.getDailyChallenge(),
    'Nivel 95': Day99DataSource.getDailyChallenge(),
    'Nivel 96': Day59DataSource.getDailyChallenge(),
    'Nivel 97': Day29DataSource.getDailyChallenge(),
    'Nivel 98': Day42DataSource.getDailyChallenge(),
    'Nivel 99': Day95DataSource.getDailyChallenge(),
    'Nivel 100': Day14DataSource.getDailyChallenge(),
    'Nivel 101': BusinessInterviewsDataSource.getDailyChallenge(),
    'Nivel 102': BusinessInterviewsLesson3DataSource.getDailyChallenge(),
    'Nivel 103': BusinessInterviewsLesson4DataSource.getDailyChallenge(),
    'Nivel 104': BusinessInterviewsLesson5DataSource.getDailyChallenge(),
    'Nivel 105': BusinessInterviewsLesson6DataSource.getDailyChallenge(),
    'Nivel 106': BusinessInterviewsLesson7DataSource.getDailyChallenge(),
    'Nivel 107': BusinessInterviewsLesson8DataSource.getDailyChallenge(),
    'Nivel 108': BusinessInterviewsLesson9DataSource.getDailyChallenge(),
    'Nivel 109': BusinessInterviewsLesson10DataSource.getDailyChallenge(),
    'Nivel 110': BusinessInterviewsLesson11DataSource.getDailyChallenge(),
    'Nivel 111': BusinessInterviewsLesson12DataSource.getDailyChallenge(),
    'Nivel 112': BusinessInterviewsLesson13DataSource.getDailyChallenge(),
    'Nivel 113': BusinessInterviewsLesson14DataSource.getDailyChallenge(),
    'Nivel 114': BusinessInterviewsLesson15DataSource.getDailyChallenge(),
    'Nivel 115': BusinessInterviewsLesson16DataSource.getDailyChallenge(),
    'Nivel 116': BusinessInterviewsLesson17DataSource.getDailyChallenge(),
    'Nivel 117': BusinessInterviewsLesson18DataSource.getDailyChallenge(),
  };

  @override
  List<CategoryModel> getCategories() {
    // Generar 100 categorías dinámicamente
    return List.generate(117, (index) {
      final dayNumber = index + 1;
      IconData icon;

      // Asignar iconos específicos para los primeros días
      if (dayNumber == 1) {
        icon = Icons.looks_one;
      } else if (dayNumber == 2) {
        icon = Icons.looks_two;
      } else if (dayNumber == 3) {
        icon = Icons.looks_3;
      } else if (dayNumber == 4) {
        icon = Icons.looks_4;
      } else if (dayNumber == 5) {
        icon = Icons.looks_5;
      } else if (dayNumber == 6) {
        icon = Icons.looks_6;
      } else {
        icon = Icons.calendar_today;
      }

      return CategoryModel(name: 'Nivel $dayNumber', icon: icon);
    });
  }

  @override
  List<Phrase> getPhrasesByCategory(String category) {
    return _phrasesByCategory[category] ?? [];
  }

  @override
  List<Phrase> getAllPhrases() {
    return _phrasesByCategory.values.expand((phrases) => phrases).toList();
  }

  @override
  String getDailyChallenge(String day) {
    return _dailyChallenges[day] ??
        'Practica los idioms de hoy en situaciones reales.';
  }

  @override
  Future<Map<String, DayProgressModel>> getDaysProgress() async {
    return await _progressService.getProgress();
  }

  @override
  Future<void> markPhraseAsUsed(String dayId, int phraseIndex) async {
    await _progressService.markPhraseAsUsed(dayId, phraseIndex);
  }

  @override
  Future<String> getInitialDay() async {
    return await _progressService.getFirstUnlockedDay();
  }

  @override
  Future<void> completeDayAndUnlockNext(String currentDay) async {
    await _progressService.completeDayAndUnlockNext(currentDay);
  }

  @override
  Future<void> confirmDayChallenge(String dayId) async {
    await _progressService.confirmDayChallenge(dayId);
  }
}
