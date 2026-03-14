// lib/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../../domain/entities/phrase_entity.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/models/day_progress_model.dart';
import '../../core/utils/tts_service.dart';
import '../providers/phrases_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/stats_provider.dart';
import '../providers/auth_provider.dart';
import '../../providers/ad_provider.dart';
import '../../providers/theme_provider.dart';
import '../widgets/lingo_mascot.dart';
import '../widgets/phrase_card.dart';
import '../widgets/quiz_card.dart';
import '../widgets/dialogue_quiz_card.dart';
import '../widgets/listen_write_card.dart';
import '../../domain/entities/favorite_context_entity.dart';
import '../../providers/guide_tour_provider.dart';
import '../widgets/guide_tour_overlay.dart';



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
  bool _isTogglingFavorite = false;
  bool _isTogglingContextFavorite = false;
  int _currentCardType = 0; // 0=phrase, 1=examples, 2=quiz, 3=dialogue, -1=challenge
  final Set<String> _shownMilestones = {};

  final Map<String, Map<String, String>> _explanations = {
    "will": {
      "expansion": "will",
      "explanation": "Verbo auxiliar que indica futuro: iré, harás, iremos",
      "example": "I will go = Yo iré",
    },
    "won't": {
      "expansion": "will not",
      "explanation": "Significa: no iré / no haré / no hará (futuro negativo)",
      "example": "He won't come = Él no vendrá",
    },
    "can't": {
      "expansion": "cannot",
      "explanation": "Significa: no puedo / no puede / no podemos",
      "example": "I can't swim = No puedo nadar",
    },
    "don't": {
      "expansion": "do not",
      "explanation": "Significa: no hago / no haces (presente negativo)",
      "example": "I don't know = No sé",
    },
    "doesn't": {
      "expansion": "does not",
      "explanation": "Significa: no hace (él/ella no hace - 3ra persona)",
      "example": "She doesn't like it = A ella no le gusta",
    },
    "didn't": {
      "expansion": "did not",
      "explanation": "Significa: no fui / no hice / no fue (pasado negativo)",
      "example": "I didn't go = No fui",
    },
    "isn't": {
      "expansion": "is not",
      "explanation": "Significa: no es / no está (negativo presente)",
      "example": "It isn't true = No es verdad",
    },
    "aren't": {
      "expansion": "are not",
      "explanation": "Significa: no somos / no están / no eres",
      "example": "They aren't here = No están aquí",
    },
    "wasn't": {
      "expansion": "was not",
      "explanation": "Significa: no era / no estaba (pasado singular)",
      "example": "He wasn't home = Él no estaba en casa",
    },
    "weren't": {
      "expansion": "were not",
      "explanation": "Significa: no éramos / no estaban (pasado plural)",
      "example": "We weren't ready = No estábamos listos",
    },
    "haven't": {
      "expansion": "have not",
      "explanation":
          "Significa: no he / no has / no hemos (presente perfecto negativo)",
      "example": "I haven't seen it = No lo he visto",
    },
    "hasn't": {
      "expansion": "has not",
      "explanation": "Significa: no ha (él/ella no ha - 3ra persona)",
      "example": "She hasn't arrived = Ella no ha llegado",
    },
    "hadn't": {
      "expansion": "had not",
      "explanation":
          "Significa: no había / no habías (pasado perfecto negativo)",
      "example": "They hadn't left = No se habían ido",
    },
    "wouldn't": {
      "expansion": "would not",
      "explanation": "Significa: no haría / no harías (condicional negativo)",
      "example": "I wouldn't do that = Yo no haría eso",
    },
    "couldn't": {
      "expansion": "could not",
      "explanation": "Significa: no pude / no pudimos / no podía",
      "example": "We couldn't find it = No pudimos encontrarlo",
    },
    "shouldn't": {
      "expansion": "should not",
      "explanation": "Significa: no debería / no deberías",
      "example": "You shouldn't worry = No deberías preocuparte",
    },
    "i'm": {
      "expansion": "I am",
      "explanation": "Significa: yo soy / yo estoy",
      "example": "I'm happy = Estoy feliz",
    },
    "you're": {
      "expansion": "you are",
      "explanation": "Significa: tú eres / tú estás / usted es / usted está",
      "example": "You're late = Llegas tarde",
    },
    "he's": {
      "expansion": "he is / he has",
      "explanation": "Significa: él es / él está / él ha / él tiene",
      "example": "He's tall = Él es alto",
    },
    "she's": {
      "expansion": "she is / she has",
      "explanation": "Significa: ella es / ella está / ella ha / ella tiene",
      "example": "She's smart = Ella es inteligente",
    },
    "it's": {
      "expansion": "it is / it has",
      "explanation": "Significa: es / está / hace (clima o condiciones)",
      "example": "It's cold = Hace frío",
    },
    "we're": {
      "expansion": "we are",
      "explanation": "Significa: nosotros somos / nosotros estamos",
      "example": "We're ready = Estamos listos",
    },
    "they're": {
      "expansion": "they are",
      "explanation": "Significa: ellos son / ellos están",
      "example": "They're coming = Ellos vienen",
    },
    "i'll": {
      "expansion": "I will",
      "explanation": "Significa: yo iré / yo haré (futuro simple)",
      "example": "I'll call you = Te llamaré",
    },
    "you'll": {
      "expansion": "you will",
      "explanation": "Significa: tú irás / tú harás / usted irá (futuro)",
      "example": "You'll see = Verás",
    },
    "he'll": {
      "expansion": "he will",
      "explanation": "Significa: él irá / él hará (futuro simple)",
      "example": "He'll arrive soon = Él llegará pronto",
    },
    "she'll": {
      "expansion": "she will",
      "explanation": "Significa: ella irá / ella hará (futuro simple)",
      "example": "She'll help us = Ella nos ayudará",
    },
    "we'll": {
      "expansion": "we will",
      "explanation": "Significa: nosotros iremos / nosotros haremos (futuro)",
      "example": "We'll win = Ganaremos",
    },
    "they'll": {
      "expansion": "they will",
      "explanation": "Significa: ellos irán / ellos harán (futuro)",
      "example": "They'll understand = Ellos entenderán",
    },
    "i've": {
      "expansion": "I have",
      "explanation":
          "Significa: yo he / yo tengo (presente perfecto o posesión)",
      "example": "I've been there = He estado allí",
    },
    "you've": {
      "expansion": "you have",
      "explanation": "Significa: tú has / tú tienes / usted ha / usted tiene",
      "example": "You've done it = Lo has hecho",
    },
    "we've": {
      "expansion": "we have",
      "explanation": "Significa: nosotros hemos / nosotros tenemos",
      "example": "We've finished = Hemos terminado",
    },
    "they've": {
      "expansion": "they have",
      "explanation": "Significa: ellos han / ellos tienen",
      "example": "They've left = Se han ido",
    },
    "i'd": {
      "expansion": "I would / I had",
      "explanation": "Significa: yo haría / me gustaría / yo había",
      "example": "I'd like that = Me gustaría eso",
    },
    "you'd": {
      "expansion": "you would / you had",
      "explanation": "Significa: tú harías / te gustaría / tú habías",
      "example": "You'd better go = Mejor te vas",
    },
    "he'd": {
      "expansion": "he would / he had",
      "explanation": "Significa: él haría / le gustaría / él había",
      "example": "He'd love it = Le encantaría",
    },
    "she'd": {
      "expansion": "she would / she had",
      "explanation": "Significa: ella haría / le gustaría / ella había",
      "example": "She'd agree = Ella estaría de acuerdo",
    },
    "we'd": {
      "expansion": "we would / we had",
      "explanation": "Significa: nosotros haríamos / nosotros habíamos",
      "example": "We'd go = Iríamos",
    },
    "they'd": {
      "expansion": "they would / they had",
      "explanation": "Significa: ellos harían / ellos habían",
      "example": "They'd help = Ellos ayudarían",
    },
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _initializeTts();
    _loadInitialData();
  }

  Future<void> _initializeTts() async {
    try {
      await _ttsService.initialize();
      print('✅ TTS inicializado en HomeScreen');
    } catch (e) {
      print('❌ Error inicializando TTS en HomeScreen: $e');
    }
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
      if (mounted) {
        context.read<GuideTourProvider>().initGuideTour();
      }
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

  void _onPageChanged(int index) async {
    final phrasesProvider = context.read<PhrasesProvider>();
    final adProvider = Provider.of<AdProvider>(context, listen: false);

    if (adProvider.shouldShowAd) {
      print('🔒 Bloqueando navegación - Se requiere ver anuncio');

      final userAcceptedAd = await _showAdDialog(adProvider);

      if (!userAcceptedAd) {
        print('❌ Usuario canceló - Regresando a página anterior');
        final previousIndex = phrasesProvider.currentIndex;
        _pageController.jumpToPage(previousIndex);
        return;
      }

      print('✅ Usuario vio anuncio - Permitiendo navegación');
    }

    adProvider.incrementCardView();

    phrasesProvider.changePage(index);

    // ── Milestone: tras completar 2 frases (página 10 = inicio frase 3) ──
    if (index == 10) {
      final milestoneKey = '${phrasesProvider.selectedCategory}_2ph';
      if (!_shownMilestones.contains(milestoneKey)) {
        _shownMilestones.add(milestoneKey);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _showMilestoneDialog(phrasesCompleted: 2);
        });
      }
    }

    final totalPages = (phrasesProvider.currentPhrases.length * 5) + 1;
    final currentDayNumber = phrasesProvider.selectedCategory.replaceAll(
      'Nivel ',
      '',
    );

    setState(() {
      _currentCardType = (index == totalPages - 1) ? -1 : index % 5;
    });

    if (index < totalPages - 1 && index % 5 == 0) {
      final phraseIndex = index ~/ 5;
      if (phraseIndex < phrasesProvider.currentPhrases.length) {
        final phrase = phrasesProvider.currentPhrases[phraseIndex];
        _ttsService.speak(phrase.english);
      }
    }
  }

  Future<bool> _showAdDialog(AdProvider adProvider) async {
    bool adWatched = false;

    while (!adWatched) {
      final result = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: const Color(0xFF1A1A2E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  const Icon(Icons.lock, color: Colors.amber, size: 32),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Anuncio requerido',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    icon: const Icon(Icons.close, color: Colors.white70),
                    tooltip: 'Cerrar',
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.video_library,
                    color: Colors.amber,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '¡Para continuar aprendiendo gratis, ve el siguiente anuncio.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  if (adProvider.isLoadingAd)
                    const CircularProgressIndicator(color: Colors.amber),
                ],
              ),
              actions: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: adProvider.isLoadingAd
                        ? null
                        : () async {
                            Navigator.of(context).pop(true);
                            await adProvider.showRewardedAd(context);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(
                      Icons.play_circle_filled,
                      color: Colors.black,
                    ),
                    label: const Text(
                      'Ver anuncio',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

      if (result == true) {
        adWatched = true;
        return true;
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.lock, color: Colors.white),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Debes ver el anuncio para continuar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.orange.shade700,
              duration: const Duration(seconds: 2),
            ),
          );
        }

        await Future.delayed(const Duration(milliseconds: 800));
      }
    }

    return false;
  }

  Future<void> _onCategoryChanged(String category) async {
    final phrasesProvider = context.read<PhrasesProvider>();
    final dayProgress = _progress[category];

    if (!(dayProgress?.isUnlocked ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Este nivel está bloqueado. Completa el nivel anterior primero.',
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromARGB(255, 73, 13, 211),
        ),
      );
      return;
    }

    final dayNumber = int.tryParse(category.replaceAll('Nivel ', '')) ?? 1;
    if (dayNumber > 1) {
      final previousDay = 'Nivel ${dayNumber - 1}';
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

  List<String> _findContractions(String text) {
    final words = text.split(' ');
    final found = <String>[];

    for (final word in words) {
      String cleanWord = word.toLowerCase();
      cleanWord = cleanWord.replaceAll(RegExp(r'[.,!?;:()\[\]"]+$'), '');

      if (_explanations.containsKey(cleanWord)) {
        found.add(cleanWord);
      }
    }

    return found.toSet().toList();
  }

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
              BoxShadow(color: Color(0x80673AB7), spreadRadius: 5),
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
    if (_isTogglingFavorite) return;

    setState(() {
      _isTogglingFavorite = true;
    });

    try {
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
    } finally {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        setState(() {
          _isTogglingFavorite = false;
        });
      }
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

    // ── Section complete: cada 10 niveles ──
    final dayNum = phrasesProvider.currentDayNumber;
    if (dayNum % 10 == 0) {
      await _showSectionCompleteDialog(section: dayNum ~/ 10, level: dayNum);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Text('¡Nivel marcado como completado!'),
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
    final dayNumber = phrasesProvider.currentDayNumber;

    if (phrasesProvider.isLastDay) {
      _showCongratulationsDialog();
      return;
    }

    final nextDay = 'Nivel ${dayNumber + 1}';
    final nextDayProgress = _progress[nextDay];

    if (!(nextDayProgress?.isUnlocked ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes completar el nivel actual primero'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    await _onCategoryChanged(nextDay);
  }

  Future<void> _showMilestoneDialog({required int phrasesCompleted}) async {
    if (!mounted) return;
    final authProvider = context.read<AuthProvider>();
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _MilestoneDialog(
        phrasesCompleted: phrasesCompleted,
        isSignedIn: authProvider.isSignedIn,
        onSignIn: () {
          Navigator.of(ctx).pop();
          authProvider.signInWithGoogle();
        },
      ),
    );
  }

  Future<void> _showSectionCompleteDialog({
    required int section,
    required int level,
  }) async {
    if (!mounted) return;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) =>
          _SectionCompleteDialog(section: section, level: level),
    );
  }

  void _showCongratulationsDialog() {
    final phrasesProvider = context.read<PhrasesProvider>();
    final totalDays = phrasesProvider.totalDays;
    final totalIdioms = totalDays * 8;

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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.stars, color: Colors.amber, size: 64),
            const SizedBox(height: 16),
            Text(
              '🎊 ¡Completaste todos los días!\n\n🌟 Has aprendido $totalIdioms idioms esenciales del inglés.\n\n💪 Sigue practicándolos en tu nivel a nivel para dominar el inglés como un nativo.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: Colors.white),
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

  Widget _buildExamplesCard(phrase) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Phrase header ──
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : const Color(0xFFEEEEF0),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.25)
                        : Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.shade500,
                              Colors.deepOrange.shade600,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.lightbulb_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          phrase.idiom,
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: onSurface,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '💡 ${phrase.realMeaning}',
                    style: TextStyle(
                      fontSize: 15,
                      color: isDark
                          ? Colors.orange.shade200
                          : Colors.orange.shade700,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // ── Section title ──
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 14),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 22,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: isDark
                            ? [const Color(0xFF60A5FA), const Color(0xFF3B82F6)]
                            : [Colors.blue.shade400, Colors.blue.shade600],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '📝 Ejemplos de uso en contexto',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: onSurface,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
            ...phrase.contextExamples.asMap().entries.map((entry) {
              final index = entry.key;
              final example = entry.value;
              final contextId = '${phrase.id}-$index';

              final contractions = _findContractions(
                example.englishExample,
              );
              final pronunciation = example.pronunciation;

              return _ExampleCard(
                key: ValueKey(contextId),
                contextId: contextId,
                example: example,
                pronunciation: pronunciation,
                contractions: contractions,
                colorIndex: index,
                onSpeak: () => _ttsService.speak(example.englishExample),
                onToggleFavorite: () =>
                    _toggleFavoriteContext(phrase, example, index),
                onShowContraction: _showContractionExplanation,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard(PhrasesProvider phrasesProvider) {
    final dayNumber =
        int.tryParse(phrasesProvider.selectedCategory.replaceAll('Nivel ', '')) ??
        1;
    final isLastDay = dayNumber == 100;
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
                    '🎯 ¡Resumen del Nivel!',
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
                          ? '¡Nivel Completado!'
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
                        'Pasar al Nivel ${dayNumber + 1}',
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
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: Consumer<PhrasesProvider>(
              builder: (context, phrasesProvider, _) {
                final totalPages =
                    (phrasesProvider.currentPhrases.length * 5) + 1;
                final currentDayNumber = phrasesProvider.selectedCategory
                    .replaceAll('Nivel ', '');

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
                          color: Theme.of(context).colorScheme.onSurface,
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.blue,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Nivel $currentDayNumber',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
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
                      const SizedBox(width: 8),
                      Consumer<ThemeProvider>(
                        builder: (context, themeProvider, _) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: IconButton(
                              key: ValueKey(themeProvider.isDarkMode),
                              onPressed: themeProvider.toggleTheme,
                              icon: Icon(
                                themeProvider.isDarkMode
                                    ? Icons.wb_sunny_rounded
                                    : Icons.nightlight_round,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              tooltip: themeProvider.isDarkMode
                                  ? 'Modo claro'
                                  : 'Modo oscuro',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: totalPages,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) {
                      if (index == totalPages - 1) {
                        return _buildChallengeCard(phrasesProvider);
                      }

                      final phraseIndex = index ~/ 5;
                      final cardType = index % 5; // 0=phrase, 1=examples, 2=quiz, 3=dialogue, 4=listen

                      if (phraseIndex >=
                          phrasesProvider.currentPhrases.length) {
                        return const SizedBox();
                      }

                      final phrase =
                          phrasesProvider.currentPhrases[phraseIndex];

                      if (cardType == 1) {
                        return _buildReadCard(_buildExamplesCard(phrase));
                      }

                      if (cardType == 2) {
                        return QuizCard(
                          key: ValueKey('quiz-${phrase.id}'),
                          phrase: phrase,
                          allPhrases: phrasesProvider.currentPhrases,
                          onContinue: () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          onSkip: () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                        );
                      }

                      if (cardType == 3) {
                        return DialogueQuizCard(
                          key: ValueKey('dialogue-${phrase.id}'),
                          phrase: phrase,
                          allPhrases: phrasesProvider.currentPhrases,
                          onContinue: () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          onSkip: () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                        );
                      }

                      if (cardType == 4) {
                        return ListenWriteCard(
                          key: ValueKey('listen-${phrase.id}'),
                          phrase: phrase,
                          onContinue: () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                          onSkip: () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                        );
                      }

                      return Consumer<FavoritesProvider>(
                        builder: (context, favProvider, _) {
                          return FutureBuilder<bool>(
                            future: favProvider.isFavorite(phrase),
                            builder: (context, favSnapshot) {
                              return _buildReadCard(
                                PhraseCard(
                                  phrase: phrase,
                                  gifUrl: null,
                                  isFavorite: favSnapshot.data ?? false,
                                  onSpeak: () =>
                                      _ttsService.speak(phrase.english),
                                  onToggleFavorite: () =>
                                      _toggleFavorite(phrase),
                                  onShare: () => _share(phrase),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
    const GuideTourOverlay(),
  ],
);
}



  Widget _buildReadCard(Widget card) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor =
        isDark ? const Color(0xFF2D2D4E) : const Color(0xFFE0E0E0);

    return Column(
      children: [
        Expanded(child: card),
        Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F0F1E) : Colors.white,
            border: Border(top: BorderSide(color: dividerColor, width: 1)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: () => _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  'CONTINUAR',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _toggleFavoriteContext(
    PhraseEntity phrase,
    ContextExampleEntity example,
    int index,
  ) async {
    if (_isTogglingContextFavorite) return;

    setState(() {
      _isTogglingContextFavorite = true;
    });

    try {
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
            backgroundColor: wasFavorite ? Colors.red : const Color(0xE64CAF50),
          ),
        );
      }
    } finally {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        setState(() {
          _isTogglingContextFavorite = false;
        });
      }
    }
  }
}

class _ExampleCard extends StatefulWidget {
  final String contextId;
  final dynamic example;
  final String pronunciation;
  final List<String> contractions;
  final VoidCallback onSpeak;
  final VoidCallback onToggleFavorite;
  final Function(String) onShowContraction;
  final int colorIndex;

  const _ExampleCard({
    super.key,
    required this.contextId,
    required this.example,
    required this.pronunciation,
    required this.contractions,
    required this.onSpeak,
    required this.onToggleFavorite,
    required this.onShowContraction,
    this.colorIndex = 0,
  });

  @override
  State<_ExampleCard> createState() => _ExampleCardState();
}

class _ExampleCardState extends State<_ExampleCard> {
  bool? _isFavorite;
  bool _isProcessing = false;

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
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    final currentState = _isFavorite ?? false;

    setState(() {
      _isFavorite = !currentState;
    });

    try {
      widget.onToggleFavorite();
    } catch (e) {
      if (mounted) {
        setState(() {
          _isFavorite = currentState;
        });
      }
    } finally {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  // Gradient pairs for context badges
  static const List<List<Color>> _badgeGradients = [
    [Color(0xFFD946EF), Color(0xFFA855F7)], // pink-purple
    [Color(0xFFFB923C), Color(0xFFF59E0B)], // orange-amber
    [Color(0xFF818CF8), Color(0xFF6366F1)], // indigo-blue
    [Color(0xFFF472B6), Color(0xFFEC4899)], // rose-pink
  ];

  @override
  Widget build(BuildContext context) {
    final isFavorite = _isFavorite ?? false;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors =
        _badgeGradients[widget.colorIndex % _badgeGradients.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isFavorite
              ? Colors.pink.withValues(alpha: 0.35)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : const Color(0xFFEEEEF0)),
          width: 1,
        ),
        boxShadow: [
          if (isFavorite)
            BoxShadow(
              color: Colors.pink.withValues(alpha: 0.12),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.25)
                : Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row: badge + speaker + heart ──
          Row(
            children: [
              // Gradient pill badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: gradientColors,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: gradientColors[0].withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  widget.example.context,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const Spacer(),
              // Audio button
              GestureDetector(
                onTap: widget.onSpeak,
                child: Icon(
                  Icons.volume_up_rounded,
                  color: isDark
                      ? const Color(0xFF60A5FA)
                      : const Color(0xFF3B82F6),
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // Favorite button
              GestureDetector(
                onTap: _isProcessing ? null : _handleToggleFavorite,
                child: Opacity(
                  opacity: _isProcessing ? 0.5 : 1.0,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? Colors.pink
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.35)
                            : const Color(0xFFBBBBCC)),
                    size: 26,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // ── English phrase (bold) ──
          Text(
            widget.example.englishExample,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1A1A2E),
              height: 1.45,
            ),
          ),

          // ── Pronunciation (light gray) ──
          if (widget.pronunciation.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              widget.pronunciation,
              style: TextStyle(
                fontSize: 14,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.45)
                    : const Color(0xFF9CA3AF),
                height: 1.35,
              ),
            ),
          ],

          // ── Spanish translation (bold) ──
          const SizedBox(height: 5),
          Text(
            widget.example.spanishExample,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.85)
                  : const Color(0xFF1A1A2E),
              height: 1.45,
            ),
          ),

          // ── Contraction chips ──
          if (widget.contractions.isNotEmpty) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.contractions.map((contraction) {
                return GestureDetector(
                  onTap: () => widget.onShowContraction(contraction),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [
                                const Color(0xFF7C3AED),
                                const Color(0xFF6D28D9),
                              ]
                            : [
                                Colors.purple.shade600,
                                Colors.deepPurple.shade700,
                              ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.help_outline_rounded,
                          color: Colors.white,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          contraction,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.3,
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

// ─────────────────────────────────────────────
// Milestone Dialog — tras completar N frases
// ─────────────────────────────────────────────

class _MilestoneDialog extends StatelessWidget {
  final int phrasesCompleted;
  final bool isSignedIn;
  final VoidCallback? onSignIn;

  const _MilestoneDialog({
    required this.phrasesCompleted,
    required this.isSignedIn,
    this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    final title =
        phrasesCompleted <= 2 ? '¡Increíble comienzo!' : '¡Gran progreso!';
    final subtitle =
        'Completaste tus primeras $phrasesCompleted frases con\ntodos sus ejercicios.';

    return Dialog.fullscreen(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Stack(
          children: [
            // Confetti background
            Positioned.fill(child: CustomPaint(painter: _ConfettiPainter())),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const LingoMascot(size: 160),
                  const SizedBox(height: 24),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF58CC02),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      color: const Color(0xFF666666),
                      height: 1.5,
                    ),
                  ),
                  const Spacer(flex: 2),
                  if (!isSignedIn) ...[
                    _GuardaProgresoCard(onSignIn: onSignIn),
                    const SizedBox(height: 14),
                  ],
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF58CC02),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF58CC02).withValues(alpha: 0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'CONTINUAR',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Guarda tu progreso card
// ─────────────────────────────────────────────

class _GuardaProgresoCard extends StatelessWidget {
  final VoidCallback? onSignIn;
  const _GuardaProgresoCard({this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEBFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF7C5CFA).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C5CFA).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.cloud_upload_rounded,
                  color: Color(0xFF7C5CFA),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¡Guarda tu progreso!',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF4B2ECF),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Crea una cuenta gratis y nunca pierdas tu avance.',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 13,
                        color: const Color(0xFF555555),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onSignIn,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFDDDDDD),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google G
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFDDDDDD)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'G',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4285F4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Continuar con Google',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Section Complete Dialog
// ─────────────────────────────────────────────

class _SectionCompleteDialog extends StatelessWidget {
  final int section;
  final int level;

  const _SectionCompleteDialog({
    required this.section,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _ConfettiPainter(seed: 7)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const Text('🏆', style: TextStyle(fontSize: 80)),
                  const SizedBox(height: 20),
                  Text(
                    '¡Sección $section completada!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFF59E0B),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Completaste los niveles ${level - 9} al $level.\n¡Sigue así, vas por buen camino!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      color: const Color(0xFF666666),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Stats row
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E7),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _SectionStat(
                          icon: '📚',
                          value: '${10 * 8}',
                          label: 'Frases',
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: const Color(0xFFE0E0E0),
                        ),
                        _SectionStat(
                          icon: '⭐',
                          value: '$section/10',
                          label: 'Secciones',
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: const Color(0xFFE0E0E0),
                        ),
                        _SectionStat(
                          icon: '🔥',
                          value: '$level%',
                          label: 'Completado',
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF59E0B), Color(0xFFF97316)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '¡SEGUIR APRENDIENDO!',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionStat extends StatelessWidget {
  final String icon;
  final String value;
  final String label;

  const _SectionStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 12,
            color: const Color(0xFF888888),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Confetti background painter
// ─────────────────────────────────────────────

class _ConfettiPainter extends CustomPainter {
  final int seed;
  const _ConfettiPainter({this.seed = 0});

  static const _colors = [
    Color(0xFFF59E0B),
    Color(0xFF58CC02),
    Color(0xFF60A5FA),
    Color(0xFFF472B6),
    Color(0xFFA78BFA),
    Color(0xFFFB923C),
    Color(0xFF34D399),
    Color(0xFFF87171),
  ];

  // (xRatio, yRatio, width, height, isCircle)
  static const _shapes = [
    (0.10, 0.06, 8.0, 14.0, false),
    (0.28, 0.04, 10.0, 10.0, true),
    (0.53, 0.07, 6.0, 12.0, false),
    (0.70, 0.03, 8.0, 8.0, true),
    (0.88, 0.09, 10.0, 6.0, false),
    (0.04, 0.17, 8.0, 8.0, true),
    (0.93, 0.21, 6.0, 10.0, false),
    (0.16, 0.24, 10.0, 6.0, false),
    (0.78, 0.17, 6.0, 6.0, true),
    (0.40, 0.10, 8.0, 8.0, false),
    (0.62, 0.13, 10.0, 5.0, false),
    (0.32, 0.19, 6.0, 12.0, false),
    (0.07, 0.64, 8.0, 10.0, true),
    (0.91, 0.61, 10.0, 6.0, false),
    (0.14, 0.73, 6.0, 6.0, true),
    (0.81, 0.76, 8.0, 14.0, false),
    (0.49, 0.84, 10.0, 8.0, false),
    (0.24, 0.87, 6.0, 10.0, false),
    (0.67, 0.83, 8.0, 8.0, true),
    (0.37, 0.79, 10.0, 6.0, false),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _shapes.length; i++) {
      final (xR, yR, w, h, isCircle) = _shapes[i];
      final color = _colors[(i + seed) % _colors.length];
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      final cx = size.width * xR;
      final cy = size.height * yR;
      if (isCircle) {
        canvas.drawCircle(Offset(cx, cy), w / 2, paint);
      } else {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(cx, cy), width: w, height: h),
            const Radius.circular(2),
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
