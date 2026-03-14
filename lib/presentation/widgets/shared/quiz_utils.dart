// lib/presentation/widgets/shared/quiz_utils.dart

/// Extrae palabras clave de un texto para comparación de similitud.
/// Normaliza a minúsculas y elimina stop-words comunes en español.
List<String> quizKeywords(String text) {
  const stopWords = {
    'el', 'la', 'los', 'las', 'un', 'una', 'unos', 'unas',
    'de', 'del', 'al', 'a', 'en', 'con', 'por', 'para',
    'y', 'o', 'e', 'u', 'que', 'es', 'se', 'no', 'si',
    'lo', 'le', 'me', 'te', 'nos', 'su', 'sus', 'mi', 'tu',
    'muy', 'más', 'ya', 'como', 'pero', 'ser', 'estar',
    'the', 'an', 'is', 'are', 'was', 'were', 'to', 'of',
    'in', 'on', 'at', 'for', 'and', 'or', 'it', 'he', 'she',
  };

  return text
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w\sáéíóúñü]'), '')
      .split(RegExp(r'\s+'))
      .where((w) => w.length > 1 && !stopWords.contains(w))
      .toList();
}

/// Calcula la similitud de Jaccard entre dos listas de palabras clave.
/// Retorna un valor entre 0.0 (sin similitud) y 1.0 (idénticas).
double jaccardSimilarity(List<String> kw1, List<String> kw2) {
  if (kw1.isEmpty && kw2.isEmpty) return 1.0;
  if (kw1.isEmpty || kw2.isEmpty) return 0.0;

  final set1 = kw1.toSet();
  final set2 = kw2.toSet();

  final intersection = set1.intersection(set2).length;
  final union = set1.union(set2).length;

  return union == 0 ? 0.0 : intersection / union;
}
