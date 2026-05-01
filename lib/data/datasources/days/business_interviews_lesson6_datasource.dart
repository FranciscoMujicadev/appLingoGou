// lib/data/datasources/days/business_interviews_lesson6_datasource.dart
// Nivel 105 — Option 1: Interview Q&A Cards (Describing Yourself)
// Cómo responder a "Háblame de ti" y derivadas

import '../../../core/models/phrase_model.dart';

class BusinessInterviewsLesson6DataSource {
  static List<Phrase> getPhrases() {
    return [
      Phrase(
        id: 'bei5-1',
        idiom: 'Tell me about yourself',
        literalTranslation: 'Háblame de ti',
        realMeaning: 'RH evalúa: si puedes resumir tu valor en 60 segundos sin divagar',
        category: 'Nivel 105',
        pronunciation: 'tel mi abaut yor-self',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample: 'I was born in 1995, I love dogs, I studied marketing because I always liked creativity...',
            pronunciation: 'ai was born in nainti-naif',
            spanishExample: 'Nací en 1995, amo los perros, estudié marketing porque siempre me gustó la creatividad...',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo (Past · Present · Future)',
            englishExample: 'I built B2B campaigns at a SaaS startup for 5 years. Right now I lead a 4-person team. Next, I want to own go-to-market strategy at a global scale.',
            pronunciation: 'ai bilt bi-tu-bi kampeins',
            spanishExample: 'Construí campañas B2B en una startup SaaS por 5 años. Actualmente lidero un equipo de 4. Ahora quiero liderar estrategia go-to-market a escala global.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Past + Present + Future formula = clear narrative in 60 seconds.',
            pronunciation: 'past, presend, fiucher',
            spanishExample: 'Fórmula Pasado + Presente + Futuro = narrativa clara en 60 segundos.',
          ),
        ],
      ),
      Phrase(
        id: 'bei5-2',
        idiom: 'How would you describe yourself in 3 words?',
        literalTranslation: 'Descríbete en 3 palabras',
        realMeaning: 'RH evalúa: si puedes ser específico bajo presión',
        category: 'Nivel 105',
        pronunciation: 'zri werds',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample: 'Hardworking, passionate, and a team player.',
            pronunciation: 'jardworking, pashonet',
            spanishExample: 'Trabajador, apasionado y jugador de equipo.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample: 'Analytical, direct, and curious. Analytical because I led 3 data projects. Direct in feedback. Curious about new tools.',
            pronunciation: 'analítikal, dairekt, and kiuriós',
            spanishExample: 'Analítica, directa y curiosa. Analítica porque lideré 3 proyectos de datos. Directa en el feedback. Curiosa con herramientas nuevas.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Each word has a one-line proof — no empty adjectives.',
            pronunciation: 'ich werd jas a wan-lain pruf',
            spanishExample: 'Cada palabra tiene una prueba de una línea — sin adjetivos vacíos.',
          ),
        ],
      ),
      Phrase(
        id: 'bei5-3',
        idiom: 'Walk me through your CV',
        literalTranslation: 'Cuéntame tu CV',
        realMeaning: 'RH evalúa: cómo conectas tu trayectoria con el puesto que aplicas',
        category: 'Nivel 105',
        pronunciation: 'wok mi zru yor si-vi',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample: 'Reading every job title and date on your resume out loud.',
            pronunciation: 'riding evri yob taitol',
            spanishExample: 'Leer cada puesto y fecha del CV en voz alta.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample: 'I started in customer support, moved into product analytics, and now lead growth — each step deepened my data instincts. That is what brought me here.',
            pronunciation: 'ai started in kostomer sapport',
            spanishExample: 'Empecé en soporte al cliente, pasé a product analytics y ahora lidero growth — cada paso afinó mi instinto con datos. Eso es lo que me trajo aquí.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Connect the dots — show why each step led to this role.',
            pronunciation: 'konekt de dots',
            spanishExample: 'Conecta los puntos — muestra por qué cada paso lleva a este puesto.',
          ),
        ],
      ),
      Phrase(
        id: 'bei5-4',
        idiom: 'What makes you unique?',
        literalTranslation: '¿Qué te hace diferente?',
        realMeaning: 'RH evalúa: si tienes algo que los otros 50 candidatos no tienen',
        category: 'Nivel 105',
        pronunciation: 'wat meiks yu yunik',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample: 'I am unique because I always give 110%.',
            pronunciation: 'ai am yunik bikos',
            spanishExample: 'Soy único porque siempre doy el 110%.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample: 'I am bilingual and I have built marketing teams in both Mexico and the US — I bridge two markets.',
            pronunciation: 'ai am bilingüal',
            spanishExample: 'Soy bilingüe y he construido equipos de marketing en México y EE.UU. — soy puente entre dos mercados.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'A real combination, not a personality claim.',
            pronunciation: 'a rial kombineishon',
            spanishExample: 'Una combinación real, no una afirmación de personalidad.',
          ),
        ],
      ),
      Phrase(
        id: 'bei5-5',
        idiom: 'What are your strengths?',
        literalTranslation: 'Tus fortalezas',
        realMeaning: 'RH evalúa: si tus fortalezas se alinean con el puesto',
        category: 'Nivel 105',
        pronunciation: 'strengz',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample: 'My strengths are leadership, communication, and being detail-oriented.',
            pronunciation: 'mai strengz ar lidershiip',
            spanishExample: 'Mis fortalezas son liderazgo, comunicación y atención al detalle.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample: 'My biggest strength is turning data into stories executives can act on. Last quarter, my dashboard drove a pricing change that added 12% margin.',
            pronunciation: 'turning data intu stories',
            spanishExample: 'Mi mayor fortaleza es convertir datos en historias accionables para ejecutivos. El trimestre pasado, mi dashboard impulsó un cambio de precios que sumó 12% de margen.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'One strength + one story + one number beats three adjectives.',
            pronunciation: 'wan strengz plas wan stori',
            spanishExample: 'Una fortaleza + una historia + un número le ganan a tres adjetivos.',
          ),
        ],
      ),
      Phrase(
        id: 'bei5-6',
        idiom: 'Describe your ideal work environment',
        literalTranslation: 'Tu ambiente de trabajo ideal',
        realMeaning: 'RH evalúa: si encajas con la cultura real de la empresa',
        category: 'Nivel 105',
        pronunciation: 'aidial work enviorment',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta peligrosa',
            englishExample: 'I prefer to work alone with no meetings and full freedom.',
            pronunciation: 'ai prifer tu work alon',
            spanishExample: 'Prefiero trabajar solo, sin reuniones y con plena libertad.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample: 'A team that ships fast and gives direct feedback — I do my best work when expectations are clear.',
            pronunciation: 'a tim dat shipos fast',
            spanishExample: 'Un equipo que entrega rápido y da feedback directo — doy lo mejor cuando las expectativas son claras.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Aligns with most modern company cultures — without being generic.',
            pronunciation: 'alains wiz kompani kalchurs',
            spanishExample: 'Se alinea con la mayoría de culturas modernas — sin ser genérico.',
          ),
        ],
      ),
      Phrase(
        id: 'bei5-7',
        idiom: 'How do others describe you?',
        literalTranslation: '¿Cómo te describen los demás?',
        realMeaning: 'RH evalúa: tu autoconciencia y cómo te ven en equipo',
        category: 'Nivel 105',
        pronunciation: 'jau du aders diskraib yu',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample: 'They say I am hardworking and a great person.',
            pronunciation: 'dei sei ai am jardworking',
            spanishExample: 'Dicen que soy trabajadora y buena persona.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample: 'My last manager told me: "You are the calmest person in a crisis." That stuck with me.',
            pronunciation: 'mai last manayer told mi',
            spanishExample: 'Mi última jefa me dijo: "Eres la persona más tranquila en una crisis". Eso me quedó.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'A direct quote from a manager > your own opinion of yourself.',
            pronunciation: 'a dairekt kuout from a manayer',
            spanishExample: 'Una cita directa de un jefe > tu propia opinión de ti.',
          ),
        ],
      ),
      Phrase(
        id: 'bei5-8',
        idiom: 'Build your elevator pitch',
        literalTranslation: 'Tu elevator pitch',
        realMeaning: 'La fórmula de 30 segundos: rol · logro · objetivo',
        category: 'Nivel 105',
        pronunciation: 'eleveitor pich',
        contextExamples: [
          ContextExample(
            emoji: '🎤',
            context: 'Fórmula',
            englishExample: '[Role] for [years] · helped [company/result] · now looking to [goal].',
            pronunciation: 'rol, yirs, jelp, nau',
            spanishExample: '[Rol] por [años] · ayudé a [empresa/resultado] · ahora busco [objetivo].',
          ),
          ContextExample(
            emoji: '🎤',
            context: 'Ejemplo aplicado',
            englishExample: 'Product designer for 6 years. Helped a fintech grow signups 4x. Now looking to lead design at a mission-driven company.',
            pronunciation: 'product disainer for siks yirs',
            spanishExample: 'Diseñadora de producto por 6 años. Ayudé a una fintech a crecer signups 4x. Ahora busco liderar diseño en una empresa con propósito.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Práctica',
            englishExample: 'Time yourself — your pitch must fit in 30 seconds out loud.',
            pronunciation: 'taim yor-self',
            spanishExample: 'Cronométrate — tu pitch debe caber en 30 segundos en voz alta.',
          ),
        ],
      ),
    ];
  }

  static String getDailyChallenge() {
    return '''
💼 DESAFÍO: TU ELEVATOR PITCH EN 30 SEGUNDOS

Usa la fórmula:
[Rol] por [años] · ayudé a [logro] · ahora busco [objetivo].

1️⃣ Escríbelo (3 oraciones).
2️⃣ Léelo en voz alta — ¿cabe en 30 segundos?
3️⃣ Grábate. ¿Suena natural o memorizado?
4️⃣ Practícalo 3 veces hasta que fluya sin pensar.

🎯 META: Que cualquiera entienda tu valor en 30 segundos.
''';
  }
}
