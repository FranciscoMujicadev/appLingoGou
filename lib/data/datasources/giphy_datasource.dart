import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

abstract class GiphyDataSource {
  Future<String?> getRandomGif(String query);
  Future<String?> getGifForCategory(String category, int index);
}

class GiphyDataSourceImpl implements GiphyDataSource {
  static const String _apiKey = 'nFwTeqDOz1ihfk3wapH59mdAnr69qbtD';
  static const String _baseUrl = 'https://api.giphy.com/v1/gifs';
  final Map<String, List<String>> _gifCache = {};

  @override
  Future<String?> getRandomGif(String query) async {
    try {
      // Verificar cache
      if (_gifCache.containsKey(query) && _gifCache[query]!.isNotEmpty) {
        final random = Random();
        return _gifCache[query]![random.nextInt(_gifCache[query]!.length)];
      }

      // Hacer petición a la API
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/search?api_key=$_apiKey&q=$query&limit=20&rating=g',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> gifs = data['data'];

        if (gifs.isNotEmpty) {
          _gifCache[query] = gifs
              .map<String>(
                (gif) => gif['images']['fixed_height']['url'] as String,
              )
              .toList();

          final random = Random();
          return _gifCache[query]![random.nextInt(_gifCache[query]!.length)];
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<String?> getGifForCategory(String category, int index) async {
    const queries = {
      'Con hijos': ['children', 'kids', 'parenting'],
      'En pareja': ['couple', 'romance', 'relationship'],
      'Trabajo': ['office', 'work', 'business', 'meeting'],
      'Viajes': ['travel', 'vacation', 'adventure'],
    };

    final categoryQueries = queries[category] ?? ['learning'];
    final query = categoryQueries[index % categoryQueries.length];
    return await getRandomGif(query);
  }
}
