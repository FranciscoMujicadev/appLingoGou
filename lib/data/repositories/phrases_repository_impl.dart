import '../../domain/entities/phrase_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/phrases_repository.dart';
import '../../core/models/day_progress_model.dart';
import '../datasources/phrases_datasource.dart';

class PhrasesRepositoryImpl implements PhrasesRepository {
  final PhrasesDataSource dataSource;

  PhrasesRepositoryImpl({required this.dataSource});

  @override
  List<CategoryEntity> getCategories() {
    return dataSource.getCategories().map((model) => model.toEntity()).toList();
  }

  @override
  List<PhraseEntity> getPhrasesByCategory(String category) {
    return dataSource
        .getPhrasesByCategory(category)
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  List<PhraseEntity> getAllPhrases() {
    return dataSource.getAllPhrases().map((model) => model.toEntity()).toList();
  }

  @override
  String getDailyChallenge(String day) {
    return dataSource.getDailyChallenge(day);
  }

  @override
  Future<Map<String, DayProgressModel>> getDaysProgress() async {
    return await dataSource.getDaysProgress();
  }

  @override
  Future<void> markPhraseAsUsed(String dayId, int phraseIndex) async {
    await dataSource.markPhraseAsUsed(dayId, phraseIndex);
  }

  @override
  Future<String> getInitialDay() async {
    return await dataSource.getInitialDay();
  }

  @override
  Future<void> completeDayAndUnlockNext(String currentDay) async {
    await dataSource.completeDayAndUnlockNext(currentDay);
  }

  @override
  Future<void> confirmDayChallenge(String dayId) async {
    await dataSource.confirmDayChallenge(dayId);
  }
}
