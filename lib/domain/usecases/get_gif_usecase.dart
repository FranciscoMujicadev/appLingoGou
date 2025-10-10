import '../repositories/gif_repository.dart';

class GetGifUseCase {
  final GifRepository repository;

  GetGifUseCase({required this.repository});

  Future<String?> call(String category, int index) async {
    return await repository.getGifForCategory(category, index);
  }
}
