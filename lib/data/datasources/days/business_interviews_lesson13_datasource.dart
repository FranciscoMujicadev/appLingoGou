// lib/data/datasources/days/business_interviews_lesson13_datasource.dart
// Nivel 112 — Option 5: Dialogue Cards (Trial Interview con IA)
// Cada tarjeta: 🤖 IA pregunta · 🗣️ Respuesta candidato · 📝 Feedback IA

import '../../../core/models/phrase_model.dart';

class BusinessInterviewsLesson13DataSource {
  static List<Phrase> getPhrases() {
    return [
      Phrase(
        id: 'bei12-1',
        idiom: 'Setup: Activar el modo entrevista',
        literalTranslation: 'Cómo iniciar la simulación con IA',
        realMeaning: 'Dale a la IA un rol claro: entrevistador estricto para tu puesto',
        category: 'Nivel 112',
        pronunciation: 'setup',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'Prompt inicial sugerido',
            englishExample: 'Act as a strict HR interviewer for a [Marketing Manager] role at a tech company.',
            pronunciation: 'akt as a strikt eich-ar interviuwer',
            spanishExample: 'Actúa como un entrevistador de RH estricto para un rol de [Gerente de Marketing] en una empresa tech.',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu instrucción',
            englishExample: 'Ask me 5 questions, one at a time. Wait for my answer before the next.',
            pronunciation: 'ask mi faiv kuestions, wan at a taim',
            spanishExample: 'Hazme 5 preguntas, una a la vez. Espera mi respuesta antes de la siguiente.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Cierre del prompt',
            englishExample: 'After all answers, give me feedback on clarity, confidence, and content.',
            pronunciation: 'after ol ansers, guiv mi fidbak',
            spanishExample: 'Al final, dame retroalimentación sobre claridad, confianza y contenido.',
          ),
        ],
      ),
      Phrase(
        id: 'bei12-2',
        idiom: 'Diálogo 1: Tell me about yourself',
        literalTranslation: 'Háblame de ti',
        realMeaning: 'Practicar el elevator pitch en 60 segundos',
        category: 'Nivel 112',
        pronunciation: 'tel mi abaut yor-self',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'IA pregunta',
            englishExample: 'Tell me about yourself in 60 seconds.',
            pronunciation: 'tel mi abaut yor-self in siksti sekonds',
            spanishExample: 'Háblame de ti en 60 segundos.',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu respuesta',
            englishExample: 'I am a marketing professional with 5 years building B2B campaigns. Last year I grew lead volume 3x at a SaaS startup.',
            pronunciation: 'ai am a marketing profeshional wiz faiv yirs',
            spanishExample: 'Soy una profesional de marketing con 5 años en campañas B2B. El año pasado tripliqué el volumen de leads en una startup SaaS.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Feedback IA típico',
            englishExample: 'Strong opening. Add one sentence on why this role next.',
            pronunciation: 'strong opening. ad wan sentens',
            spanishExample: 'Buen inicio. Agrega una oración sobre por qué este puesto sigue.',
          ),
        ],
      ),
      Phrase(
        id: 'bei12-3',
        idiom: 'Diálogo 2: Greatest weakness',
        literalTranslation: 'Tu mayor debilidad',
        realMeaning: 'Mostrar autoconciencia sin clichés',
        category: 'Nivel 112',
        pronunciation: 'greitest wiknes',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'IA pregunta',
            englishExample: 'What is your greatest weakness?',
            pronunciation: 'wat is yor greitest wiknes',
            spanishExample: '¿Cuál es tu mayor debilidad?',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu respuesta',
            englishExample: 'Public speaking. I joined Toastmasters six months ago and now lead our weekly demo.',
            pronunciation: 'pablik spiking',
            spanishExample: 'Hablar en público. Entré a Toastmasters hace 6 meses y ahora lidero la demo semanal.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Feedback IA típico',
            englishExample: 'Excellent — real weakness with active proof of growth.',
            pronunciation: 'ekselent — rial wiknes wiz aktiv pruf',
            spanishExample: 'Excelente — debilidad real con evidencia activa de crecimiento.',
          ),
        ],
      ),
      Phrase(
        id: 'bei12-4',
        idiom: 'Diálogo 3: Conflict story',
        literalTranslation: 'Historia de conflicto',
        realMeaning: 'Aplicar el método STAR (Situation · Task · Action · Result)',
        category: 'Nivel 112',
        pronunciation: 'konflikt stori',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'IA pregunta',
            englishExample: 'Tell me about a time you had conflict with a coworker.',
            pronunciation: 'tel mi abaut a taim yu jad konflikt',
            spanishExample: 'Cuéntame de una vez que tuviste conflicto con un colega.',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu respuesta (STAR)',
            englishExample: 'A peer and I disagreed on launch dates. I set up a 1-on-1, listened first, then we co-built one timeline. We shipped on day one.',
            pronunciation: 'a pir and ai disagrid on lonch deits',
            spanishExample: 'Un colega y yo no coincidíamos en fechas. Agendé un 1-a-1, escuché primero y construimos un plan juntos. Entregamos a tiempo.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Feedback IA típico',
            englishExample: 'Solid STAR. Add one line on what you learned.',
            pronunciation: 'solid star. ad wan lain',
            spanishExample: 'STAR sólido. Agrega una línea sobre qué aprendiste.',
          ),
        ],
      ),
      Phrase(
        id: 'bei12-5',
        idiom: 'Diálogo 4: Why this company?',
        literalTranslation: '¿Por qué esta empresa?',
        realMeaning: 'Demostrar que investigaste, no que aplicas a todo',
        category: 'Nivel 112',
        pronunciation: 'wai dis compani',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'IA pregunta',
            englishExample: 'Why do you want to work here?',
            pronunciation: 'wai du yu want tu work jir',
            spanishExample: '¿Por qué quieres trabajar aquí?',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu respuesta',
            englishExample: 'I read your Q1 report — your move into Latin America fits exactly where I want to contribute.',
            pronunciation: 'ai red yor kiu-wan riport',
            spanishExample: 'Leí su reporte del Q1 — su entrada a Latinoamérica encaja con donde quiero contribuir.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Feedback IA típico',
            englishExample: 'Specific and personal — no generic praise. Strong.',
            pronunciation: 'spisifik and personal',
            spanishExample: 'Específico y personal — sin halagos genéricos. Fuerte.',
          ),
        ],
      ),
      Phrase(
        id: 'bei12-6',
        idiom: 'Diálogo 5: Pregunta del candidato',
        literalTranslation: 'Tu turno de preguntar',
        realMeaning: 'Cerrar la entrevista con una pregunta inteligente',
        category: 'Nivel 112',
        pronunciation: 'kandidet kuestion',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'IA pregunta',
            englishExample: 'Do you have any questions for me?',
            pronunciation: 'du yu jav eni kuestions for mi',
            spanishExample: '¿Tienes alguna pregunta para mí?',
          ),
          ContextExample(
            emoji: '🗣️',
            context: 'Tu pregunta',
            englishExample: 'What does success look like in this role at the 90-day mark?',
            pronunciation: 'wat das sakses luk laik in dis rol',
            spanishExample: '¿Cómo se ve el éxito en este puesto a los 90 días?',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Feedback IA típico',
            englishExample: 'Great question — shows you think in outcomes, not tasks.',
            pronunciation: 'greit kuestion',
            spanishExample: 'Excelente pregunta — muestras que piensas en resultados, no tareas.',
          ),
        ],
      ),
      Phrase(
        id: 'bei12-7',
        idiom: 'Pedir feedback estructurado',
        literalTranslation: 'Cómo pedir retroalimentación útil',
        realMeaning: 'No pidas "qué tal lo hice" — pide feedback en 3 ejes específicos',
        category: 'Nivel 112',
        pronunciation: 'fidbak strakchurd',
        contextExamples: [
          ContextExample(
            emoji: '🗣️',
            context: 'Tu prompt a la IA',
            englishExample: 'Rate me 1-10 on clarity, confidence, and content. Show me my weakest answer.',
            pronunciation: 'reit mi wan tu ten',
            spanishExample: 'Califícame 1-10 en claridad, confianza y contenido. Muéstrame mi respuesta más débil.',
          ),
          ContextExample(
            emoji: '🤖',
            context: 'Feedback IA modelo',
            englishExample: 'Clarity 8/10. Confidence 7/10. Content 6/10 — your weakness answer used a cliche.',
            pronunciation: 'klariti eit aut of ten',
            spanishExample: 'Claridad 8/10. Confianza 7/10. Contenido 6/10 — tu respuesta de debilidad usó un cliché.',
          ),
          ContextExample(
            emoji: '📝',
            context: 'Tu siguiente paso',
            englishExample: 'Now rewrite my weakness answer using a real example with one number.',
            pronunciation: 'nau riruait mai wiknes anser',
            spanishExample: 'Ahora reescribe mi respuesta de debilidad usando un ejemplo real con un número.',
          ),
        ],
      ),
      Phrase(
        id: 'bei12-8',
        idiom: 'Repetir hasta sonar natural',
        literalTranslation: 'La regla de las 3 rondas',
        realMeaning: 'No basta una simulación — hazla 3 veces hasta que fluya sin pensar',
        category: 'Nivel 112',
        pronunciation: 'zri raunds',
        contextExamples: [
          ContextExample(
            emoji: '1️⃣',
            context: 'Ronda 1',
            englishExample: 'First round: focus only on content — does the answer make sense?',
            pronunciation: 'ferst raund',
            spanishExample: 'Primera ronda: enfócate solo en contenido — ¿tiene sentido la respuesta?',
          ),
          ContextExample(
            emoji: '2️⃣',
            context: 'Ronda 2',
            englishExample: 'Second round: focus on confidence — slow down, no filler words.',
            pronunciation: 'sekond raund',
            spanishExample: 'Segunda ronda: enfócate en confianza — pausa, sin muletillas.',
          ),
          ContextExample(
            emoji: '3️⃣',
            context: 'Ronda 3',
            englishExample: 'Third round: record yourself. If it sounds memorized, rewrite it shorter.',
            pronunciation: 'zerd raund',
            spanishExample: 'Tercera ronda: grábate. Si suena memorizado, reescríbelo más corto.',
          ),
        ],
      ),
    ];
  }

  static String getDailyChallenge() {
    return '''
💼 DESAFÍO: ENTREVISTA SIMULADA CON IA

1️⃣ Abre tu IA preferida (ChatGPT, Claude, Gemini).
2️⃣ Pega este prompt:
   "Act as a strict HR interviewer for a [TU ROL]. Ask me 5 questions one at a time. Then rate me 1-10 on clarity, confidence, and content."
3️⃣ Responde EN VOZ ALTA (no escribas).
4️⃣ Pídele que reescriba tu peor respuesta.
5️⃣ Repite la simulación con esa respuesta corregida.

🎯 META: 3 rondas. Al final, tu respuesta debe sonar natural, no memorizada.
''';
  }
}
