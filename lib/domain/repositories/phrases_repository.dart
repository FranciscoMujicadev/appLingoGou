import '../entities/phrase_entity.dart';
import '../entities/category_entity.dart';
import '../../core/models/day_progress_model.dart';

abstract class PhrasesRepository {
  List<CategoryEntity> getCategories();
  List<PhraseEntity> getPhrasesByCategory(String category);
  List<PhraseEntity> getAllPhrases();
  String getDailyChallenge(String day);
  Future<Map<String, DayProgressModel>> getDaysProgress();
  Future<void> markPhraseAsUsed(String dayId, int phraseIndex);
  Future<String> getInitialDay();

  Future<void> completeDayAndUnlockNext(String currentDay);
  Future<void> confirmDayChallenge(String dayId);
}
