// lib/data/datasources/days/business_interviews_lesson8_datasource.dart
// Nivel 107 — Option 1: Interview Q&A Cards (Positive & Negative Skills)
// Cómo hablar de fortalezas y debilidades con honestidad estratégica

import '../../../core/models/phrase_model.dart';

class BusinessInterviewsLesson8DataSource {
  static List<Phrase> getPhrases() {
    return [
      Phrase(
        id: 'bei7-1',
        idiom: 'What is your greatest strength?',
        literalTranslation: 'Tu mayor fortaleza',
        realMeaning: 'RH evalúa: si conoces tu valor real y puedes probarlo',
        category: 'Nivel 107',
        pronunciation: 'greitest strengz',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'My greatest strength is being a hard worker.',
            pronunciation: 'mai greitest strengz',
            spanishExample: 'Mi mayor fortaleza es ser trabajador.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'Translating ambiguous goals into clear weekly milestones — my last team shipped on time 6 quarters in a row.',
            pronunciation: 'transleiting ambigus gols',
            spanishExample: 'Traducir objetivos ambiguos en milestones semanales claros — mi último equipo entregó a tiempo 6 trimestres seguidos.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Specific skill + measurable proof — not an adjective.',
            pronunciation: 'spisifik skil',
            spanishExample: 'Habilidad específica + prueba medible — no un adjetivo.',
          ),
        ],
      ),
      Phrase(
        id: 'bei7-2',
        idiom: 'What is your greatest weakness?',
        literalTranslation: 'Tu mayor debilidad',
        realMeaning: 'RH evalúa: tu autoconciencia y si activamente estás creciendo',
        category: 'Nivel 107',
        pronunciation: 'greitest wiknes',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'I am too much of a perfectionist.',
            pronunciation: 'tu moch of a perfekshanist',
            spanishExample: 'Soy demasiado perfeccionista.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'I avoid public speaking. I joined Toastmasters 6 months ago and now lead the weekly demo.',
            pronunciation: 'ai avoid pablik spiking',
            spanishExample: 'Evitaba hablar en público. Entré a Toastmasters hace 6 meses y ahora lidero la demo semanal.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Real weakness + active solution = honest and self-aware.',
            pronunciation: 'rial wiknes plas aktiv solushon',
            spanishExample: 'Debilidad real + solución activa = honesto y consciente.',
          ),
        ],
      ),
      Phrase(
        id: 'bei7-3',
        idiom: 'Tell me about a positive trait',
        literalTranslation: 'Una cualidad positiva',
        realMeaning: 'RH evalúa: si tu personalidad encaja con el equipo',
        category: 'Nivel 107',
        pronunciation: 'positiv treit',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'I am very friendly and people love working with me.',
            pronunciation: 'ai am veri frendli',
            spanishExample: 'Soy muy amigable y la gente ama trabajar conmigo.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'I stay calm in crises — when our system went down at 2 AM, I led the response without panic.',
            pronunciation: 'ai stei kam in kraisis',
            spanishExample: 'Mantengo la calma en crisis — cuando nuestro sistema cayó a las 2 AM, lideré la respuesta sin pánico.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'A trait + a moment that proves it — instantly believable.',
            pronunciation: 'a treit plas a moument',
            spanishExample: 'Cualidad + momento que la prueba — instantáneamente creíble.',
          ),
        ],
      ),
      Phrase(
        id: 'bei7-4',
        idiom: 'Tell me about a negative trait',
        literalTranslation: 'Una cualidad a mejorar',
        realMeaning: 'RH evalúa: si puedes ser honesto sin hundirte',
        category: 'Nivel 107',
        pronunciation: 'negativ treit',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Suicidio profesional',
            englishExample: 'I get bored quickly and I lose patience with slow people.',
            pronunciation: 'ai get bord kuikli',
            spanishExample: 'Me aburro rápido y pierdo la paciencia con la gente lenta.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'I tend to take on too much. I have started using a weekly capacity check before saying yes.',
            pronunciation: 'ai tend tu teik on tu moch',
            spanishExample: 'Tiendo a aceptar demasiado. Empecé a hacer un chequeo semanal de capacidad antes de decir que sí.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'A real trait + an active system = self-managed.',
            pronunciation: 'a rial treit plas an aktiv sistem',
            spanishExample: 'Cualidad real + sistema activo = te gestionas a ti mismo.',
          ),
        ],
      ),
      Phrase(
        id: 'bei7-5',
        idiom: 'How do you handle criticism?',
        literalTranslation: '¿Cómo manejas las críticas?',
        realMeaning: 'RH evalúa: madurez y capacidad de mejorar',
        category: 'Nivel 107',
        pronunciation: 'jandol kritisism',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'I love feedback — I always take it positively.',
            pronunciation: 'ai lov fidbak',
            spanishExample: 'Amo el feedback — siempre lo tomo positivamente.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'I ask one clarifying question, then I sit with it for a day before responding. It keeps me from getting defensive.',
            pronunciation: 'ai ask wan klarifaing kuestion',
            spanishExample: 'Hago una pregunta para aclarar, luego me siento con ello un día antes de responder. Me evita ponerme a la defensiva.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'A specific habit beats the generic "I love feedback".',
            pronunciation: 'a spisifik jabit',
            spanishExample: 'Un hábito específico le gana al genérico "amo el feedback".',
          ),
        ],
      ),
      Phrase(
        id: 'bei7-6',
        idiom: 'What skill do you want to develop?',
        literalTranslation: 'Una habilidad que quieres desarrollar',
        realMeaning: 'RH evalúa: si tienes ambición de crecer y un plan',
        category: 'Nivel 107',
        pronunciation: 'develop a skil',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'I want to develop everything — I love learning.',
            pronunciation: 'ai want tu develop evrizing',
            spanishExample: 'Quiero desarrollar todo — amo aprender.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'Financial modeling. I am taking a CFA prep course on weekends — exam scheduled for September.',
            pronunciation: 'fainenshial modeling',
            spanishExample: 'Modelado financiero. Estoy tomando un curso CFA los fines de semana — examen agendado para septiembre.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'One specific skill + a date = real intent.',
            pronunciation: 'wan spisifik skil plas a deit',
            spanishExample: 'Una habilidad específica + una fecha = intención real.',
          ),
        ],
      ),
      Phrase(
        id: 'bei7-7',
        idiom: 'What is a skill that surprises people?',
        literalTranslation: 'Una habilidad inesperada',
        realMeaning: 'RH evalúa: si tienes algo que te diferencia del resto',
        category: 'Nivel 107',
        pronunciation: 'sorprais pipol',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'I am good with people — that always surprises them.',
            pronunciation: 'ai am gud wiz pipol',
            spanishExample: 'Soy buena con la gente — eso siempre los sorprende.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'I built a Python script that auto-generates client reports — saved my old team 8 hours a week.',
            pronunciation: 'ai bilt a paizon script',
            spanishExample: 'Construí un script en Python que auto-genera reportes de cliente — ahorró 8 horas semanales a mi equipo anterior.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'A real, surprising skill with a concrete result = memorable.',
            pronunciation: 'a rial, sorpraising skil',
            spanishExample: 'Una habilidad real, sorprendente, con resultado concreto = memorable.',
          ),
        ],
      ),
      Phrase(
        id: 'bei7-8',
        idiom: 'Skill you decided not to pursue',
        literalTranslation: 'Una habilidad que decidiste no seguir',
        realMeaning: 'RH evalúa: si sabes priorizar y decir que no',
        category: 'Nivel 107',
        pronunciation: 'no purshu',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'I want to learn everything, so I have not given up on any skill.',
            pronunciation: 'ai want tu lern evrizing',
            spanishExample: 'Quiero aprender todo, así que no he dejado ninguna habilidad.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'I dropped graphic design last year — I prefer to partner with a designer and focus on strategy.',
            pronunciation: 'ai dropt grafik disain',
            spanishExample: 'Dejé el diseño gráfico el año pasado — prefiero asociarme con un diseñador y enfocarme en estrategia.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Knowing what NOT to do shows clarity and focus.',
            pronunciation: 'noing wat nat tu du',
            spanishExample: 'Saber qué NO hacer demuestra claridad y enfoque.',
          ),
        ],
      ),
    ];
  }

  static String getDailyChallenge() {
    return '''
💼 DESAFÍO: FORTALEZAS Y DEBILIDADES HONESTAS

1️⃣ Una fortaleza + UN número o resultado.
2️⃣ Una debilidad real + el sistema que usas para gestionarla.
3️⃣ Una habilidad que estás desarrollando + UNA fecha.

🎯 REGLA: Cero adjetivos vacíos. Solo evidencia.
''';
  }
}
