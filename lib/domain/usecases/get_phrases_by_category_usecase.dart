import '../entities/phrase_entity.dart';
import '../repositories/phrases_repository.dart';

class GetPhrasesByCategoryUseCase {
  final PhrasesRepository repository;

  GetPhrasesByCategoryUseCase({required this.repository});

  List<PhraseEntity> call(String category) {
    return repository.getPhrasesByCategory(category);
  }
}
