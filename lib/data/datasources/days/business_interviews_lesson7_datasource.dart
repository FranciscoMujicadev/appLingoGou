// lib/data/datasources/days/business_interviews_lesson7_datasource.dart
// Nivel 106 — Option 5: Dialogue Cards (Experience & Education)
// Cómo hablar de trayectoria sin sonar a CV leído

import '../../../core/models/phrase_model.dart';

class BusinessInterviewsLesson7DataSource {
  static List<Phrase> getPhrases() {
    return [
      Phrase(
        id: 'bei6-1',
        idiom: 'Diálogo: Walk me through your experience',
        literalTranslation: 'Cuéntame tu experiencia',
        realMeaning: 'Conectar puestos con un hilo narrativo, no un timeline',
        category: 'Nivel 106',
        pronunciation: 'wok mi zru yor eksperiens',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'Walk me through your work experience.',
            pronunciation: 'wok mi zru yor work eksperiens',
            spanishExample: 'Cuéntame tu experiencia laboral.',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu respuesta',
            englishExample: 'I started in support, moved to ops, then product. Each step gave me a deeper view of the customer — that is why I am here.',
            pronunciation: 'ai started in sapport',
            spanishExample: 'Empecé en soporte, pasé a operaciones, luego a producto. Cada paso me dio una vista más profunda del cliente — por eso estoy aquí.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Análisis',
            englishExample: 'Connect-the-dots story — not a timeline reading.',
            pronunciation: 'konekt-de-dots stori',
            spanishExample: 'Historia de "conectar los puntos" — no leer una línea de tiempo.',
          ),
        ],
      ),
      Phrase(
        id: 'bei6-2',
        idiom: 'Diálogo: Why did you study X?',
        literalTranslation: 'Hablar de tu carrera',
        realMeaning: 'Tu carrera no tiene que dictar tu rol — explica el puente',
        category: 'Nivel 106',
        pronunciation: 'wai did yu stadi',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'You studied biology — why are you in marketing now?',
            pronunciation: 'yu stadid baioloji',
            spanishExample: 'Estudiaste biología — ¿por qué ahora estás en marketing?',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu respuesta',
            englishExample: 'Biology trained me to read data and run experiments — exactly what modern marketing needs.',
            pronunciation: 'baioloji treind mi tu rid data',
            spanishExample: 'Biología me entrenó a leer datos y correr experimentos — exactamente lo que el marketing moderno necesita.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Análisis',
            englishExample: 'Reframe your degree as a transferable skill set.',
            pronunciation: 'rifreim yor digrí',
            spanishExample: 'Reencuadra tu carrera como un conjunto de habilidades transferibles.',
          ),
        ],
      ),
      Phrase(
        id: 'bei6-3',
        idiom: 'Diálogo: Job gap on your CV',
        literalTranslation: 'Hueco en tu CV',
        realMeaning: 'No te disculpes por un gap — explícalo con propósito',
        category: 'Nivel 106',
        pronunciation: 'yob gap',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'I see a 9-month gap in 2024 — what happened?',
            pronunciation: 'ai si a nain-monz gap',
            spanishExample: 'Veo un gap de 9 meses en 2024 — ¿qué pasó?',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu respuesta',
            englishExample: 'I took deliberate time off — completed two certifications and consulted on three small projects. I came back sharper.',
            pronunciation: 'ai tuk deliberat taim of',
            spanishExample: 'Tomé un tiempo deliberado — completé dos certificaciones y asesoré 3 proyectos pequeños. Volví más afilado.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Análisis',
            englishExample: 'Own the gap. Frame it as growth, not absence.',
            pronunciation: 'on de gap',
            spanishExample: 'Apropia el gap. Enmárcalo como crecimiento, no ausencia.',
          ),
        ],
      ),
      Phrase(
        id: 'bei6-4',
        idiom: 'Diálogo: Most relevant experience',
        literalTranslation: 'Tu experiencia más relevante',
        realMeaning: 'Mapear UNA experiencia exacta a UN requisito del puesto',
        category: 'Nivel 106',
        pronunciation: 'most relevant eksperiens',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'What experience makes you the best fit for this role?',
            pronunciation: 'wat eksperiens meiks yu best fit',
            spanishExample: '¿Qué experiencia te hace el mejor candidato para este puesto?',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu respuesta',
            englishExample: 'You need someone who can scale onboarding. Last year I cut our onboarding time from 14 to 5 days. Same playbook applies here.',
            pronunciation: 'yu nid samwan ju kan skeil',
            spanishExample: 'Necesitan alguien que pueda escalar el onboarding. El año pasado bajé nuestro onboarding de 14 a 5 días. El mismo playbook aplica aquí.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Análisis',
            englishExample: 'Match a real result to a stated need — direct fit.',
            pronunciation: 'mach a rial risolt',
            spanishExample: 'Alinea un resultado real con una necesidad declarada — encaje directo.',
          ),
        ],
      ),
      Phrase(
        id: 'bei6-5',
        idiom: 'Diálogo: Overqualified concerns',
        literalTranslation: 'Cuando dicen "estás sobrecalificado"',
        realMeaning: 'Tranquilizar la preocupación de que te irás pronto',
        category: 'Nivel 106',
        pronunciation: 'overkualifaid',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'Honestly, you seem overqualified. Why this role?',
            pronunciation: 'yu sim overkualifaid',
            spanishExample: 'Honestamente pareces sobrecalificado. ¿Por qué este puesto?',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu respuesta',
            englishExample: 'I am choosing depth over title. This role is in the industry I want to grow in — for the next 3-5 years.',
            pronunciation: 'ai am chusing depz over taitol',
            spanishExample: 'Estoy eligiendo profundidad sobre título. Este puesto es en el sector donde quiero crecer — los próximos 3-5 años.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Análisis',
            englishExample: 'Address the real fear: "Will you leave?" — answer with timeline.',
            pronunciation: 'adres de rial fir',
            spanishExample: 'Aborda el miedo real: "¿Te irás pronto?" — responde con timeline.',
          ),
        ],
      ),
      Phrase(
        id: 'bei6-6',
        idiom: 'Diálogo: Underqualified concerns',
        literalTranslation: 'Cuando te falta experiencia',
        realMeaning: 'Compensa con evidencia de aprendizaje rápido',
        category: 'Nivel 106',
        pronunciation: 'anderkualifaid',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'You only have 2 years of experience — the role asks for 5.',
            pronunciation: 'yu onli jav tu yirs',
            spanishExample: 'Solo tienes 2 años de experiencia — el puesto pide 5.',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu respuesta',
            englishExample: 'In 2 years I owned what most people own in 5 — full P&L for a \$2M product line. I learn faster than the average curve.',
            pronunciation: 'in tu yirs ai ond',
            spanishExample: 'En 2 años he tenido la responsabilidad que muchos tienen en 5 — P&L completo de una línea de producto de \$2M. Aprendo más rápido que la curva promedio.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Análisis',
            englishExample: 'Argue density of experience over years on paper.',
            pronunciation: 'argiu densiti',
            spanishExample: 'Argumenta densidad de experiencia sobre años en papel.',
          ),
        ],
      ),
      Phrase(
        id: 'bei6-7',
        idiom: 'Diálogo: Career change',
        literalTranslation: 'Cambio de carrera',
        realMeaning: 'Conectar el "antes" con el "después" sin pedir disculpas',
        category: 'Nivel 106',
        pronunciation: 'karir cheinch',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'Why are you switching from teaching to UX design?',
            pronunciation: 'wai ar yu suiching',
            spanishExample: '¿Por qué estás cambiando de enseñanza a diseño UX?',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu respuesta',
            englishExample: 'Teaching trained me to listen and simplify — UX is the same skill applied to products. I have completed a 6-month bootcamp and shipped 3 case studies.',
            pronunciation: 'tiching treind mi tu lisen',
            spanishExample: 'Enseñar me entrenó a escuchar y simplificar — UX es la misma habilidad aplicada a productos. Completé un bootcamp de 6 meses y publiqué 3 case studies.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Análisis',
            englishExample: 'Show transferable skill + concrete proof of new commitment.',
            pronunciation: 'sho transferabol skil',
            spanishExample: 'Muestra habilidad transferible + evidencia concreta del nuevo compromiso.',
          ),
        ],
      ),
      Phrase(
        id: 'bei6-8',
        idiom: 'Diálogo: Continuous learning',
        literalTranslation: 'Aprendizaje continuo',
        realMeaning: 'Demostrar que sigues aprendiendo activamente, no solo en tu CV',
        category: 'Nivel 106',
        pronunciation: 'kontinuos lerning',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'How do you stay updated in your field?',
            pronunciation: 'jau du yu stei apdeitid',
            spanishExample: '¿Cómo te mantienes actualizado en tu campo?',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu respuesta',
            englishExample: 'I read 2 industry newsletters weekly, finished a Coursera course on AI last month, and run a Slack group with 12 peers.',
            pronunciation: 'ai rid tu industri niusleters',
            spanishExample: 'Leo 2 newsletters semanales, terminé un curso de Coursera sobre IA el mes pasado y modero un Slack con 12 colegas.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Análisis',
            englishExample: 'Specific habits + recent action = proof, not platitude.',
            pronunciation: 'spisifik jabits',
            spanishExample: 'Hábitos específicos + acción reciente = prueba, no cliché.',
          ),
        ],
      ),
    ];
  }

  static String getDailyChallenge() {
    return '''
💼 DESAFÍO: TU NARRATIVA DE TRAYECTORIA

1️⃣ Escribe en 3 oraciones cómo cada paso de tu carrera te trajo hasta hoy.
2️⃣ Identifica UNA habilidad que se transfirió entre 2 puestos diferentes.
3️⃣ Si tienes un gap o un cambio brusco — practica cómo lo explicas con propósito.

🎯 META: Que tu trayectoria suene a una decisión, no a un accidente.
''';
  }
}
