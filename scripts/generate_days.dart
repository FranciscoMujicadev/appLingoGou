// scripts/generate_days.dart

import 'dart:io';

void main() {
  print('🚀 Generando días 8-100...\n');

  // Lista de idioms y phrasal verbs para usar
  final idiomsPool = [
    {
      'idiom': 'A dime a dozen',
      'literal': 'Una moneda de diez centavos la docena',
      'meaning': 'Algo muy común, sin valor especial',
    },
    {
      'idiom': 'Ball is in your court',
      'literal': 'La pelota está en tu cancha',
      'meaning': 'Es tu turno de decidir o actuar',
    },
    {
      'idiom': 'Barking up the wrong tree',
      'literal': 'Ladrando al árbol equivocado',
      'meaning': 'Buscar en el lugar equivocado',
    },
    {
      'idiom': 'Bite the bullet',
      'literal': 'Morder la bala',
      'meaning': 'Enfrentar algo difícil con valentía',
    },
    {
      'idiom': 'Break a leg',
      'literal': 'Rómpete una pierna',
      'meaning': 'Buena suerte',
    },
    {
      'idiom': 'Call it a day',
      'literal': 'Llamarlo un día',
      'meaning': 'Terminar el trabajo por hoy',
    },
    {
      'idiom': 'Cut to the chase',
      'literal': 'Cortar a la persecución',
      'meaning': 'Ir al grano',
    },
    {
      'idiom': 'Hit the nail on the head',
      'literal': 'Golpear el clavo en la cabeza',
      'meaning': 'Acertar exactamente',
    },
    {
      'idiom': 'Kill two birds with one stone',
      'literal': 'Matar dos pájaros de una piedra',
      'meaning': 'Lograr dos cosas con una acción',
    },
    {
      'idiom': 'Let the cat out of the bag',
      'literal': 'Dejar salir al gato de la bolsa',
      'meaning': 'Revelar un secreto',
    },
    {
      'idiom': 'No pain, no gain',
      'literal': 'Sin dolor, sin ganancia',
      'meaning': 'Sin esfuerzo no hay recompensa',
    },
    {
      'idiom': 'On the ball',
      'literal': 'Sobre la pelota',
      'meaning': 'Alerta y eficiente',
    },
    {
      'idiom': 'Pull yourself together',
      'literal': 'Júntate a ti mismo',
      'meaning': 'Cálmate y contrólate',
    },
    {
      'idiom': 'Speak of the devil',
      'literal': 'Hablar del diablo',
      'meaning': 'Hablando del rey de Roma',
    },
    {
      'idiom': 'The best of both worlds',
      'literal': 'Lo mejor de ambos mundos',
      'meaning': 'Tener todas las ventajas',
    },
    {
      'idiom': 'Time flies',
      'literal': 'El tiempo vuela',
      'meaning': 'El tiempo pasa rápido',
    },
    {
      'idiom': 'Under the weather',
      'literal': 'Bajo el clima',
      'meaning': 'Sentirse enfermo',
    },
    {
      'idiom': 'Up in the air',
      'literal': 'Arriba en el aire',
      'meaning': 'Incierto, sin decidir',
    },
  ];

  final phrasalVerbsPool = [
    {'verb': 'Back up', 'meaning': 'Respaldar / Apoyar'},
    {'verb': 'Bring up', 'meaning': 'Mencionar un tema / Criar'},
    {'verb': 'Call off', 'meaning': 'Cancelar'},
    {'verb': 'Carry on', 'meaning': 'Continuar'},
    {'verb': 'Catch up', 'meaning': 'Ponerse al día'},
    {'verb': 'Check out', 'meaning': 'Revisar / Pagar e irse'},
    {'verb': 'Come across', 'meaning': 'Encontrarse con'},
    {'verb': 'Count on', 'meaning': 'Confiar en'},
    {'verb': 'Cut down', 'meaning': 'Reducir'},
    {'verb': 'Drop by', 'meaning': 'Visitar informalmente'},
    {'verb': 'Figure out', 'meaning': 'Resolver, descubrir'},
    {'verb': 'Fill in', 'meaning': 'Rellenar / Informar'},
    {'verb': 'Get along', 'meaning': 'Llevarse bien'},
    {'verb': 'Get rid of', 'meaning': 'Deshacerse de'},
    {'verb': 'Give in', 'meaning': 'Ceder, rendirse'},
    {'verb': 'Hand in', 'meaning': 'Entregar'},
    {'verb': 'Hold on', 'meaning': 'Esperar'},
    {'verb': 'Look after', 'meaning': 'Cuidar de'},
  ];

  // Generar días 8-100
  for (int day = 8; day <= 100; day++) {
    generateDayFile(day, idiomsPool, phrasalVerbsPool);
    print('✅ Día $day generado');
  }

  print('\n🎉 ¡Generación completa! Se crearon 93 archivos.');
  print('📝 Ahora actualiza phrases_datasource.dart con los imports.');
}

void generateDayFile(
  int dayNumber,
  List<Map<String, String>> idiomsPool,
  List<Map<String, String>> phrasalVerbsPool,
) {
  // Alternar entre idioms y phrasal verbs
  final isIdiomDay = dayNumber % 2 == 0;
  final pool = isIdiomDay ? idiomsPool : phrasalVerbsPool;

  final file = File(
    'lib/data/datasources/phrases_data/day${dayNumber}_datasource.dart',
  );

  final buffer = StringBuffer();
  buffer.writeln(
    "// lib/data/datasources/phrases_data/day${dayNumber}_datasource.dart\n",
  );
  buffer.writeln("import '../../../core/models/phrase_model.dart';\n");
  buffer.writeln("class Day${dayNumber}DataSource {");
  buffer.writeln("  static List<Phrase> getPhrases() {");
  buffer.writeln("    return [");

  // Generar 8 frases
  for (int i = 0; i < 8; i++) {
    final phraseData = pool[i % pool.length];
    final id = '$dayNumber-${i + 1}';

    if (isIdiomDay) {
      buffer.writeln(_generateIdiomPhrase(id, phraseData, 'Día $dayNumber'));
    } else {
      buffer.writeln(_generatePhrasalVerb(id, phraseData, 'Día $dayNumber'));
    }

    if (i < 7) buffer.writeln(',');
  }

  buffer.writeln("    ];");
  buffer.writeln("  }\n");
  buffer.writeln(_generateDailyChallenge(dayNumber, isIdiomDay));
  buffer.writeln("}");

  file.writeAsStringSync(buffer.toString());
}

String _generateIdiomPhrase(
  String id,
  Map<String, String> data,
  String category,
) {
  return '''
      Phrase(
        id: '$id',
        idiom: '${data['idiom']}',
        literalTranslation: '${data['literal']}',
        realMeaning: '${data['meaning']}',
        category: '$category',
        pronunciation: '${_generatePronunciation(data['idiom']!)}',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Let's use this idiom with friends!",
            pronunciation: 'lets ius dis idiom wiz frends',
            spanishExample: '¡Usemos este idiom con amigos!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Kids can learn this too!",
            pronunciation: 'kids kan lern dis tu',
            spanishExample: '¡Los niños también pueden aprender esto!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "Parents will understand this.",
            pronunciation: 'perents wil anderstand dis',
            spanishExample: 'Los papás entenderán esto.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Siblings can practice together!",
            pronunciation: 'siblins kan praktis tugeder',
            spanishExample: '¡Los hermanos pueden practicar juntos!',
          ),
        ],
      )''';
}

String _generatePhrasalVerb(
  String id,
  Map<String, String> data,
  String category,
) {
  return '''
      Phrase(
        id: '$id',
        idiom: '${data['verb']}',
        literalTranslation: 'Phrasal verb',
        realMeaning: '${data['meaning']}',
        category: '$category',
        pronunciation: '${_generatePronunciation(data['verb']!)}',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Use this phrasal verb daily!",
            pronunciation: 'ius dis fresal verb deili',
            spanishExample: '¡Usa este phrasal verb a diario!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Practice makes perfect!",
            pronunciation: 'praktis meiks perfekt',
            spanishExample: '¡La práctica hace al maestro!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "Family conversations help learning.",
            pronunciation: 'famili konverseishons jelp lernin',
            spanishExample: 'Las conversaciones familiares ayudan al aprendizaje.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Learn and share together!",
            pronunciation: 'lern and sher tugeder',
            spanishExample: '¡Aprendan y compartan juntos!',
          ),
        ],
      )''';
}

String _generatePronunciation(String text) {
  // Pronunciación simplificada
  return text
      .toLowerCase()
      .replaceAll('a', 'a')
      .replaceAll('e', 'e')
      .replaceAll('i', 'ai')
      .replaceAll('o', 'o')
      .replaceAll('u', 'iu');
}

String _generateDailyChallenge(int dayNumber, bool isIdiomDay) {
  final type = isIdiomDay ? 'idioms' : 'phrasal verbs';
  return '''
  static String getDailyChallenge() {
    return \'\'\'
🎯 DESAFÍO DEL DÍA $dayNumber

¡Excelente! Hoy aprendiste 8 $type esenciales.

📝 TU RETO: Usa cada expresión AL MENOS UNA VEZ hoy

💡 Practícalos en conversaciones reales con:
- Familia
- Amigos  
- Compañeros

✅ Marca cada expresión cuando la uses
🔓 Completa todas para desbloquear el Día ${dayNumber + 1}
\'\'\';
  }''';
}
