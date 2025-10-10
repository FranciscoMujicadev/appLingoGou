import '../../domain/repositories/gif_repository.dart';
import '../datasources/giphy_datasource.dart';

class GifRepositoryImpl implements GifRepository {
  final GiphyDataSource dataSource;

  GifRepositoryImpl({required this.dataSource});

  @override
  Future<String?> getGifForCategory(String category, int index) async {
    return await dataSource.getGifForCategory(category, index);
  }
}
