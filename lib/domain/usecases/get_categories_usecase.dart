import '../entities/category_entity.dart';
import '../repositories/phrases_repository.dart';

class GetCategoriesUseCase {
  final PhrasesRepository repository;

  GetCategoriesUseCase({required this.repository});

  List<CategoryEntity> call() {
    return repository.getCategories();
  }
}
