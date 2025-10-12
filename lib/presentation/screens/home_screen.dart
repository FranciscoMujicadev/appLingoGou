import 'package:app_counter/domain/entities/phrase_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/models/day_progress_model.dart';
import '../../core/utils/tts_service.dart';
import '../providers/phrases_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/stats_provider.dart';
import '../widgets/category_filters.dart';
import '../widgets/phrase_card.dart';
import '../../domain/entities/favorite_context_entity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  final TtsService _ttsService = TtsService();
  Map<String, DayProgressModel> _progress = {};
  bool _isLoading = true;

  // Diccionario de contracciones y expresiones comunes
  final Map<String, Map<String, String>> _explanations = {
    "will": {
      "expansion": "will",
      "explanation": "Verbo auxiliar para formar el futuro",
      "example": "I will go = Yo iré",
    },
    "won't": {
      "expansion": "will not",
      "explanation": "Contracción negativa de 'will'",
      "example": "He won't come = Él no vendrá",
    },
    "can't": {
      "expansion": "cannot",
      "explanation": "Contracción negativa de 'can' (no poder)",
      "example": "I can't swim = No puedo nadar",
    },
    "don't": {
      "expansion": "do not",
      "explanation": "Contracción negativa de 'do'",
      "example": "I don't know = No sé",
    },
    "doesn't": {
      "expansion": "does not",
      "explanation": "Contracción negativa de 'does' (3ra persona)",
      "example": "She doesn't like it = A ella no le gusta",
    },
    "didn't": {
      "expansion": "did not",
      "explanation": "Contracción negativa de 'did' (pasado)",
      "example": "I didn't go = No fui",
    },
    "isn't": {
      "expansion": "is not",
      "explanation": "Contracción negativa de 'is'",
      "example": "It isn't true = No es verdad",
    },
    "aren't": {
      "expansion": "are not",
      "explanation": "Contracción negativa de 'are'",
      "example": "They aren't here = No están aquí",
    },
    "wasn't": {
      "expansion": "was not",
      "explanation": "Contracción negativa de 'was' (pasado)",
      "example": "He wasn't home = Él no estaba en casa",
    },
    "weren't": {
      "expansion": "were not",
      "explanation": "Contracción negativa de 'were' (pasado)",
      "example": "We weren't ready = No estábamos listos",
    },
    "haven't": {
      "expansion": "have not",
      "explanation": "Contracción negativa de 'have'",
      "example": "I haven't seen it = No lo he visto",
    },
    "hasn't": {
      "expansion": "has not",
      "explanation": "Contracción negativa de 'has' (3ra persona)",
      "example": "She hasn't arrived = Ella no ha llegado",
    },
    "hadn't": {
      "expansion": "had not",
      "explanation": "Contracción negativa de 'had' (pasado perfecto)",
      "example": "They hadn't left = No se habían ido",
    },
    "wouldn't": {
      "expansion": "would not",
      "explanation": "Contracción negativa de 'would'",
      "example": "I wouldn't do that = Yo no haría eso",
    },
    "couldn't": {
      "expansion": "could not",
      "explanation": "Contracción negativa de 'could'",
      "example": "We couldn't find it = No pudimos encontrarlo",
    },
    "shouldn't": {
      "expansion": "should not",
      "explanation": "Contracción negativa de 'should'",
      "example": "You shouldn't worry = No deberías preocuparte",
    },
    "i'm": {
      "expansion": "I am",
      "explanation": "Contracción de 'I am' (yo soy/estoy)",
      "example": "I'm happy = Estoy feliz",
    },
    "you're": {
      "expansion": "you are",
      "explanation": "Contracción de 'you are' (tú eres/estás)",
      "example": "You're late = Llegas tarde",
    },
    "he's": {
      "expansion": "he is / he has",
      "explanation": "Contracción de 'he is' o 'he has'",
      "example": "He's tall = Él es alto",
    },
    "she's": {
      "expansion": "she is / she has",
      "explanation": "Contracción de 'she is' o 'she has'",
      "example": "She's smart = Ella es inteligente",
    },
    "it's": {
      "expansion": "it is / it has",
      "explanation": "Contracción de 'it is' o 'it has'",
      "example": "It's cold = Hace frío",
    },
    "we're": {
      "expansion": "we are",
      "explanation": "Contracción de 'we are' (nosotros somos/estamos)",
      "example": "We're ready = Estamos listos",
    },
    "they're": {
      "expansion": "they are",
      "explanation": "Contracción de 'they are' (ellos son/están)",
      "example": "They're coming = Ellos vienen",
    },
    "i'll": {
      "expansion": "I will",
      "explanation": "Contracción de 'I will' (yo iré/haré)",
      "example": "I'll call you = Te llamaré",
    },
    "you'll": {
      "expansion": "you will",
      "explanation": "Contracción de 'you will' (tú irás/harás)",
      "example": "You'll see = Verás",
    },
    "he'll": {
      "expansion": "he will",
      "explanation": "Contracción de 'he will'",
      "example": "He'll arrive soon = Él llegará pronto",
    },
    "she'll": {
      "expansion": "she will",
      "explanation": "Contracción de 'she will'",
      "example": "She'll help us = Ella nos ayudará",
    },
    "we'll": {
      "expansion": "we will",
      "explanation": "Contracción de 'we will'",
      "example": "We'll win = Ganaremos",
    },
    "they'll": {
      "expansion": "they will",
      "explanation": "Contracción de 'they will'",
      "example": "They'll understand = Ellos entenderán",
    },
    "i've": {
      "expansion": "I have",
      "explanation": "Contracción de 'I have'",
      "example": "I've been there = He estado allí",
    },
    "you've": {
      "expansion": "you have",
      "explanation": "Contracción de 'you have'",
      "example": "You've done it = Lo has hecho",
    },
    "we've": {
      "expansion": "we have",
      "explanation": "Contracción de 'we have'",
      "example": "We've finished = Hemos terminado",
    },
    "they've": {
      "expansion": "they have",
      "explanation": "Contracción de 'they have'",
      "example": "They've left = Se han ido",
    },
    "i'd": {
      "expansion": "I would / I had",
      "explanation": "Contracción de 'I would' o 'I had'",
      "example": "I'd like that = Me gustaría eso",
    },
    "you'd": {
      "expansion": "you would / you had",
      "explanation": "Contracción de 'you would' o 'you had'",
      "example": "You'd better go = Mejor te vas",
    },
    "he'd": {
      "expansion": "he would / he had",
      "explanation": "Contracción de 'he would' o 'he had'",
      "example": "He'd love it = Le encantaría",
    },
    "she'd": {
      "expansion": "she would / she had",
      "explanation": "Contracción de 'she would' o 'she had'",
      "example": "She'd agree = Ella estaría de acuerdo",
    },
    "we'd": {
      "expansion": "we would / we had",
      "explanation": "Contracción de 'we would' o 'we had'",
      "example": "We'd go = Iríamos",
    },
    "they'd": {
      "expansion": "they would / they had",
      "explanation": "Contracción de 'they would' o 'they had'",
      "example": "They'd help = Ellos ayudarían",
    },
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _ttsService.initialize();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final phrasesProvider = context.read<PhrasesProvider>();
    final progress = await phrasesProvider.getDaysProgress();
    final initialDay = await phrasesProvider.getInitialDay();

    setState(() {
      _progress = progress;
      _isLoading = false;
    });

    phrasesProvider.changeCategory(initialDay);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (phrasesProvider.currentPhrase != null) {
        _ttsService.speak(phrasesProvider.currentPhrase!.english);
      }
    });
  }

  Future<void> _refreshProgress() async {
    final phrasesProvider = context.read<PhrasesProvider>();
    final progress = await phrasesProvider.getDaysProgress();
    setState(() {
      _progress = progress;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _ttsService.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    final phrasesProvider = context.read<PhrasesProvider>();
    phrasesProvider.changePage(index);

    final totalPages = (phrasesProvider.currentPhrases.length * 2) + 1;

    if (index < totalPages - 1 && index % 2 == 0) {
      final phraseIndex = index ~/ 2;
      if (phraseIndex < phrasesProvider.currentPhrases.length) {
        final phrase = phrasesProvider.currentPhrases[phraseIndex];
        _ttsService.speak(phrase.english);
      }
    }
  }

  Future<void> _onCategoryChanged(String category) async {
    final phrasesProvider = context.read<PhrasesProvider>();
    final dayProgress = _progress[category];

    if (!(dayProgress?.isUnlocked ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Este día está bloqueado. Completa el día anterior primero.',
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final dayNumber = int.tryParse(category.replaceAll('Día ', '')) ?? 1;
    if (dayNumber > 1) {
      final previousDay = 'Día ${dayNumber - 1}';
      final previousProgress = _progress[previousDay];

      if (previousProgress?.isCompleted == true &&
          previousProgress?.challengeConfirmed != true) {
        final confirmed = await _showChallengeConfirmationDialog(previousDay);
        if (!confirmed) {
          return;
        }
      }
    }

    phrasesProvider.changeCategory(category);
    _pageController.jumpToPage(0);

    if (phrasesProvider.currentPhrase != null) {
      _ttsService.speak(phrasesProvider.currentPhrase!.english);
    }
  }

  Future<bool> _showChallengeConfirmationDialog(String previousDay) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Row(
          children: [
            const Icon(
              Icons.assignment_turned_in,
              color: Colors.orange,
              size: 28,
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                '¿Completaste el reto?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        content: Text(
          '¿Usaste los idioms del $previousDay en situaciones reales con tus familiares o amigos?\n\nEs importante practicar para aprender mejor.',
          style: const TextStyle(color: Colors.white70, fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Aún no', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              '¡Sí, los usé!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final phrasesProvider = context.read<PhrasesProvider>();
      await phrasesProvider.confirmDayChallenge(previousDay);
      await _refreshProgress();
    }

    return confirmed ?? false;
  }

  // Método para detectar contracciones en el texto
  List<String> _findContractions(String text) {
    final words = text.split(' ');
    final found = <String>[];

    for (final word in words) {
      String cleanWord = word.toLowerCase();
      // Remover puntuación al final
      cleanWord = cleanWord.replaceAll(RegExp(r'[.,!?;:()\[\]"]+$'), '');

      if (_explanations.containsKey(cleanWord)) {
        found.add(cleanWord);
      }
    }

    return found.toSet().toList();
  }

  // Modal para explicar contracciones
  void _showContractionExplanation(String contraction) {
    final explanation = _explanations[contraction.toLowerCase()];
    if (explanation == null) return;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple.shade900, Colors.blue.shade900],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Color(0x80673AB7),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.school,
                        color: Colors.amber,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        contraction.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0x4DFFFFFF),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.unfold_more,
                            color: Colors.amber,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Forma completa:',
                            style: TextStyle(
                              color: Color(0xB3FFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        explanation['expansion']!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0x332196F3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Explicación:',
                            style: TextStyle(
                              color: Color(0xB3FFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        explanation['explanation']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0x334CAF50),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Ejemplo:',
                            style: TextStyle(
                              color: Color(0xB3FFFFFF),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        explanation['example']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          height: 1.4,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '¡Entendido!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _toggleFavorite(PhraseEntity phrase) async {
    final favoritesProvider = context.read<FavoritesProvider>();
    final statsProvider = context.read<StatsProvider>();

    final wasFavorite = await favoritesProvider.isFavorite(phrase);

    await favoritesProvider.toggleFavorite(phrase);
    await statsProvider.updateAchievements(favoritesProvider.favoritesCount);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            wasFavorite ? 'Eliminado de favoritos' : 'Agregado a favoritos',
          ),
          duration: const Duration(seconds: 1),
          backgroundColor: wasFavorite ? Colors.red : const Color(0xE64CAF50),
        ),
      );
    }
  }

  void _share(PhraseEntity phrase) {
    final statsProvider = context.read<StatsProvider>();

    statsProvider.incrementShare();

    final shareText =
        '''
🇺🇸 ${phrase.english}
📖 Literal: ${phrase.literalTranslation}
💡 Significa: ${phrase.spanish}
🗣️ ${phrase.pronunciation}

📚 Categoría: ${phrase.category}
📱 Aprendiendo idioms con LingoGou
    ''';

    Share.share(shareText, subject: 'Idiom en inglés');
  }

  Future<void> _markDayAsCompleted() async {
    final phrasesProvider = context.read<PhrasesProvider>();
    final selectedCategory = phrasesProvider.selectedCategory;

    await phrasesProvider.completeDayAndUnlockNext(selectedCategory);
    await _refreshProgress();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('¡Día marcado como completado!'),
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _goToNextDay() async {
    final phrasesProvider = context.read<PhrasesProvider>();
    final selectedCategory = phrasesProvider.selectedCategory;
    final dayNumber =
        int.tryParse(selectedCategory.replaceAll('Día ', '')) ?? 1;

    if (dayNumber >= 5) {
      _showCongratulationsDialog();
      return;
    }

    final nextDay = 'Día ${dayNumber + 1}';
    final nextDayProgress = _progress[nextDay];

    if (!(nextDayProgress?.isUnlocked ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes completar el día actual primero'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    await _onCategoryChanged(nextDay);
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Row(
          children: [
            Icon(Icons.emoji_events, color: Colors.amber, size: 32),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                '¡Felicidades!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.stars, color: Colors.amber, size: 64),
            SizedBox(height: 16),
            Text(
              '🎊 ¡Completaste todos los días!\n\n🌟 Has aprendido 40 idioms esenciales del inglés.\n\n💪 Sigue practicándolos en tu día a día para dominar el inglés como un nativo.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            child: const Text('Cerrar', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  // Método para obtener la pronunciación del ejemplo

  String _getExamplePronunciation(dynamic example) {
    // Intentar obtener la pronunciación de diferentes formas
    try {
      // Si es un objeto con propiedad pronunciation
      if (example.pronunciation != null) {
        return example.pronunciation as String;
      }
    } catch (e) {
      // Si falla, intentar como Map
      try {
        if (example is Map && example.containsKey('pronunciation')) {
          return example['pronunciation'] as String? ?? '';
        }
      } catch (e2) {
        return '';
      }
    }
    return '';
  }

  Widget _buildExamplesCard(phrase) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange.shade900, Colors.deepOrange.shade900],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x4DFF9800), blurRadius: 20, spreadRadius: 5),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lightbulb, color: Colors.amber, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    phrase.idiom,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '💡 ${phrase.realMeaning}',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xE6FFFFFF),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '📝 Ejemplos de uso en contexto:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ...phrase.contextExamples.asMap().entries.map((entry) {
              final index = entry.key;
              final example = entry.value;
              final contextId = '${phrase.id}-$index';

              final contractions = _findContractions(example.englishExample);
              final pronunciation = _getExamplePronunciation(example);

              return _ExampleCard(
                key: ValueKey(contextId),
                contextId: contextId,
                example: example,
                pronunciation: pronunciation,
                contractions: contractions,
                onSpeak: () => _ttsService.speak(example.englishExample),
                onToggleFavorite: () =>
                    _toggleFavoriteContext(phrase, example, index),
                onShowContraction: _showContractionExplanation,
              );
            }).toList(),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0x334CAF50),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '¡Practica usando este idiom hoy en conversaciones reales!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard(PhrasesProvider phrasesProvider) {
    final dayNumber =
        int.tryParse(phrasesProvider.selectedCategory.replaceAll('Día ', '')) ??
        1;
    final isLastDay = dayNumber == 5;
    final phrases = phrasesProvider.currentPhrases;
    final dayProgress = _progress[phrasesProvider.selectedCategory];
    final isCompleted = dayProgress?.isCompleted ?? false;

    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue.shade900, Colors.purple.shade900],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x4D2196F3), blurRadius: 20, spreadRadius: 5),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.emoji_events, color: Colors.amber, size: 32),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '🎯 ¡Resumen del Día!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0x1AFFFFFF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Hoy aprendiste ${phrases.length} frases nuevas con sus ejemplos contextuales. ¡Es hora de ponerlos en práctica!',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '📚 Idioms de hoy:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ...phrases.asMap().entries.map((entry) {
              final phrase = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0x4D000000),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0x33FFFFFF)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${entry.key + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            phrase.idiom,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            phrase.realMeaning,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xB3FFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0x33FF9800),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: const Row(
                children: [
                  Icon(Icons.tips_and_updates, color: Colors.orange, size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Úsalos con tus papás, hermanos, amigos o en situaciones cotidianas.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isCompleted ? null : _markDayAsCompleted,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCompleted ? Colors.grey : Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isCompleted
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isCompleted
                          ? '¡Día Completado!'
                          : 'Marcar como Completado',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (!isLastDay)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: isCompleted ? _goToNextDay : null,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(
                      color: isCompleted ? Colors.blue : Colors.grey,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: isCompleted ? Colors.blue : Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Pasar al Día ${dayNumber + 1}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isCompleted ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (isLastDay && isCompleted)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showCongratulationsDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_events, color: Colors.black),
                      SizedBox(width: 12),
                      Text(
                        '¡Ver Logro Final!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.blue)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Consumer<PhrasesProvider>(
          builder: (context, phrasesProvider, _) {
            final totalPages = (phrasesProvider.currentPhrases.length * 2) + 1;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        'LingoGou',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x332196F3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${phrasesProvider.currentIndex + 1}/$totalPages',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CategoryFilters(
                  categories: phrasesProvider.categories,
                  selectedCategory: phrasesProvider.selectedCategory,
                  onCategoryChanged: _onCategoryChanged,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: totalPages,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) {
                      if (index == totalPages - 1) {
                        return _buildChallengeCard(phrasesProvider);
                      }

                      final phraseIndex = index ~/ 2;
                      final isExampleCard = index % 2 == 1;

                      if (phraseIndex >=
                          phrasesProvider.currentPhrases.length) {
                        return const SizedBox();
                      }

                      final phrase =
                          phrasesProvider.currentPhrases[phraseIndex];

                      if (isExampleCard) {
                        return _buildExamplesCard(phrase);
                      }

                      return Consumer<FavoritesProvider>(
                        builder: (context, favProvider, _) {
                          return FutureBuilder<bool>(
                            future: favProvider.isFavorite(phrase),
                            builder: (context, favSnapshot) {
                              return PhraseCard(
                                phrase: phrase,
                                gifUrl: null,
                                isFavorite: favSnapshot.data ?? false,
                                onSpeak: () =>
                                    _ttsService.speak(phrase.english),
                                onToggleFavorite: () => _toggleFavorite(phrase),
                                onShare: () => _share(phrase),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(totalPages, (index) {
                      final isChallengeCard = index == totalPages - 1;
                      final isExampleCard = !isChallengeCard && index % 2 == 1;
                      return Container(
                        width: isChallengeCard ? 12 : (isExampleCard ? 6 : 8),
                        height: isChallengeCard ? 12 : (isExampleCard ? 6 : 8),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == phrasesProvider.currentIndex
                              ? (isChallengeCard
                                    ? Colors.amber
                                    : (isExampleCard
                                          ? Colors.orange
                                          : Colors.white))
                              : const Color(0x66FFFFFF),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Método para manejar favoritos de contexto
  Future<void> _toggleFavoriteContext(
    PhraseEntity phrase,
    ContextExampleEntity example,
    int index,
  ) async {
    final favoritesProvider = context.read<FavoritesProvider>();
    final contextId = '${phrase.id}-$index';

    final favoriteContext = FavoriteContextEntity(
      id: contextId,
      phraseId: phrase.id,
      phraseIdiom: phrase.idiom,
      emoji: example.emoji,
      context: example.context,
      englishExample: example.englishExample,
      spanishExample: example.spanishExample,
      pronunciation: example.pronunciation,
      category: phrase.category,
    );

    final wasFavorite = await favoritesProvider.isFavoriteContext(contextId);

    await favoritesProvider.toggleFavoriteContext(favoriteContext);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            wasFavorite
                ? 'Ejemplo eliminado de favoritos'
                : 'Ejemplo agregado a favoritos',
          ),
          duration: const Duration(seconds: 1),
          backgroundColor: wasFavorite ? Colors.red : const Color(0xE6EC407A),
        ),
      );
    }
  }
}

// AGREGAR ESTE WIDGET FUERA DE LA CLASE _HomeScreenState (después del último })

class _ExampleCard extends StatefulWidget {
  final String contextId;
  final dynamic example;
  final String pronunciation;
  final List<String> contractions;
  final VoidCallback onSpeak;
  final VoidCallback onToggleFavorite;
  final Function(String) onShowContraction;

  const _ExampleCard({
    super.key,
    required this.contextId,
    required this.example,
    required this.pronunciation,
    required this.contractions,
    required this.onSpeak,
    required this.onToggleFavorite,
    required this.onShowContraction,
  });

  @override
  State<_ExampleCard> createState() => _ExampleCardState();
}

class _ExampleCardState extends State<_ExampleCard> {
  bool? _isFavorite;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final favProvider = context.read<FavoritesProvider>();
    final isFav = await favProvider.isFavoriteContext(widget.contextId);
    if (mounted) {
      setState(() {
        _isFavorite = isFav;
      });
    }
  }

  void _handleToggleFavorite() async {
    // Cambiar inmediatamente el estado visual
    setState(() {
      _isFavorite = !(_isFavorite ?? false);
    });

    // Ejecutar la acción
    widget.onToggleFavorite();
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = _isFavorite ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x4D000000),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFavorite
              ? Colors.pink.withOpacity(0.5)
              : const Color(0x33FFFFFF),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.example.emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.example.context,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade300,
                  ),
                ),
              ),
              GestureDetector(
                onTap: widget.onSpeak,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFFFFF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0x33FFFFFF),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.volume_up,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _handleToggleFavorite,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isFavorite
                        ? Colors.pink.withOpacity(0.2)
                        : const Color(0x1AFFFFFF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isFavorite ? Colors.pink : const Color(0x33FFFFFF),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.pink : Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0x1AFFFFFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '"${widget.example.englishExample}"',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (widget.pronunciation.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x33FF9800),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0x4DFF9800),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.record_voice_over,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.pronunciation,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0x1A4CAF50),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('🇲🇽 ', style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Text(
                          widget.example.spanishExample,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xE6FFFFFF),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.contractions.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.contractions.map((contraction) {
                return GestureDetector(
                  onTap: () => widget.onShowContraction(contraction),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple.shade700, Colors.blue.shade700],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0x4DFFFFFF),
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x4D9C27B0),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.help_outline,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          contraction,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
