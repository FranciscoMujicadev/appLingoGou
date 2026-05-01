// lib/data/datasources/days/business_interviews_lesson11_datasource.dart
// Nivel 110 — Option 2: Vocabulary in Business Context (Analyze Questions with AI)
// Vocabulario para descomponer y mejorar respuestas con IA

import '../../../core/models/phrase_model.dart';

class BusinessInterviewsLesson11DataSource {
  static List<Phrase> getPhrases() {
    return [
      Phrase(
        id: 'bei10-1',
        idiom: 'Break down',
        literalTranslation: 'Descomponer',
        realMeaning: 'Dividir una pregunta o respuesta en partes analizables',
        category: 'Nivel 110',
        pronunciation: 'breik daun',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'Prompt a la IA',
            englishExample: 'Break down what this interviewer is really asking when they say "Why this role?"',
            pronunciation: 'breik daun wat dis interviuwer',
            spanishExample: 'Descompón qué pregunta realmente el entrevistador al decir "¿Por qué este puesto?"',
          ),
          ContextExample(
            emoji: '📧',
            context: 'En email',
            englishExample: 'I broke down the brief into 3 deliverables — see attached.',
            pronunciation: 'ai broki daun de brif',
            spanishExample: 'Descompuse el brief en 3 entregables — ver adjunto.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'En reunión',
            englishExample: 'Let us break down the project before assigning owners.',
            pronunciation: 'lets breik daun de proyekt',
            spanishExample: 'Descompongamos el proyecto antes de asignar dueños.',
          ),
        ],
      ),
      Phrase(
        id: 'bei10-2',
        idiom: 'Underlying intent',
        literalTranslation: 'Intención subyacente',
        realMeaning: 'Lo que realmente quieren saber detrás de la pregunta literal',
        category: 'Nivel 110',
        pronunciation: 'anderlaing intent',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'Prompt a la IA',
            englishExample: 'What is the underlying intent behind "Tell me about a failure"?',
            pronunciation: 'wat is de anderlaing intent',
            spanishExample: '¿Cuál es la intención subyacente de "Cuéntame de un fracaso"?',
          ),
          ContextExample(
            emoji: '📧',
            context: 'En análisis',
            englishExample: 'The underlying intent of his email was to push back on the deadline.',
            pronunciation: 'de anderlaing intent of jis imeil',
            spanishExample: 'La intención subyacente de su email era empujar el plazo.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'En negociación',
            englishExample: 'Listen for the underlying intent — not the literal words.',
            pronunciation: 'lisen for de anderlaing intent',
            spanishExample: 'Escucha la intención subyacente — no las palabras literales.',
          ),
        ],
      ),
      Phrase(
        id: 'bei10-3',
        idiom: 'STAR method',
        literalTranslation: 'Método STAR',
        realMeaning: 'Situation · Task · Action · Result — la estructura para historias',
        category: 'Nivel 110',
        pronunciation: 'star mezod',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'Prompt a la IA',
            englishExample: 'Rewrite my answer using the STAR method — keep it under 90 seconds.',
            pronunciation: 'riruait mai anser yusing de star',
            spanishExample: 'Reescribe mi respuesta usando el método STAR — máximo 90 segundos.',
          ),
          ContextExample(
            emoji: '📧',
            context: 'En coaching',
            englishExample: 'Use the STAR method for behavioral questions — it gives structure.',
            pronunciation: 'yus de star mezod',
            spanishExample: 'Usa el método STAR para preguntas conductuales — da estructura.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'En sesión de práctica',
            englishExample: 'Your answer is missing the Result — finish the STAR.',
            pronunciation: 'yor anser is mising de risolt',
            spanishExample: 'A tu respuesta le falta el Resultado — completa el STAR.',
          ),
        ],
      ),
      Phrase(
        id: 'bei10-4',
        idiom: 'Red flags',
        literalTranslation: 'Banderas rojas',
        realMeaning: 'Cosas que en una respuesta hacen que RH te descarte',
        category: 'Nivel 110',
        pronunciation: 'red flags',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'Prompt a la IA',
            englishExample: 'List the red flags in my answer to "Why did you leave your last job?"',
            pronunciation: 'list de red flags',
            spanishExample: 'Lista las banderas rojas en mi respuesta a "¿Por qué dejaste tu último trabajo?"',
          ),
          ContextExample(
            emoji: '📧',
            context: 'En revisión de CV',
            englishExample: 'A 3-month tenure followed by a 4-month gap is a red flag for many recruiters.',
            pronunciation: 'a zri-monz tenyur',
            spanishExample: 'Una estancia de 3 meses seguida de un gap de 4 es una bandera roja para muchos reclutadores.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'En decisión de equipo',
            englishExample: 'I saw two red flags in the interview — let us discuss before extending an offer.',
            pronunciation: 'ai so tu red flags',
            spanishExample: 'Vi dos banderas rojas en la entrevista — discutámoslo antes de hacer oferta.',
          ),
        ],
      ),
      Phrase(
        id: 'bei10-5',
        idiom: 'Strengthen',
        literalTranslation: 'Fortalecer',
        realMeaning: 'Pedirle a la IA que mejore una parte específica',
        category: 'Nivel 110',
        pronunciation: 'strenzen',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'Prompt a la IA',
            englishExample: 'Strengthen the second paragraph — it sounds vague and generic.',
            pronunciation: 'strenzen de sekond paragraf',
            spanishExample: 'Fortalece el segundo párrafo — suena vago y genérico.',
          ),
          ContextExample(
            emoji: '📧',
            context: 'En revisión',
            englishExample: 'I strengthened the closing with one more concrete example.',
            pronunciation: 'ai strenzend de klousing',
            spanishExample: 'Fortalecí el cierre con un ejemplo concreto más.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'En reunión',
            englishExample: 'Let us strengthen the proposal before sending it to the client.',
            pronunciation: 'lets strenzen de proposal',
            spanishExample: 'Fortalezcamos la propuesta antes de enviarla al cliente.',
          ),
        ],
      ),
      Phrase(
        id: 'bei10-6',
        idiom: 'Concrete example',
        literalTranslation: 'Ejemplo concreto',
        realMeaning: 'Una historia real con cifras, no una afirmación abstracta',
        category: 'Nivel 110',
        pronunciation: 'konkret eksampol',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'Prompt a la IA',
            englishExample: 'Replace adjectives with one concrete example per claim.',
            pronunciation: 'ripleis adyetivs',
            spanishExample: 'Reemplaza los adjetivos por un ejemplo concreto por cada afirmación.',
          ),
          ContextExample(
            emoji: '📧',
            context: 'En email',
            englishExample: 'Could you give me a concrete example of what good looks like here?',
            pronunciation: 'kud yu guiv mi a konkret eksampol',
            spanishExample: '¿Podrías darme un ejemplo concreto de cómo se ve "bien" aquí?',
          ),
          ContextExample(
            emoji: '👥',
            context: 'En reunión',
            englishExample: 'Skip the theory — give me one concrete example from last quarter.',
            pronunciation: 'skip de zeori',
            spanishExample: 'Sáltate la teoría — dame un ejemplo concreto del trimestre pasado.',
          ),
        ],
      ),
      Phrase(
        id: 'bei10-7',
        idiom: 'Score me',
        literalTranslation: 'Califícame',
        realMeaning: 'Pedir una evaluación numérica honesta de tu respuesta',
        category: 'Nivel 110',
        pronunciation: 'skor mi',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'Prompt a la IA',
            englishExample: 'Score me 1-10 on clarity, confidence, and content. No flattery.',
            pronunciation: 'skor mi wan tu ten',
            spanishExample: 'Califícame del 1 al 10 en claridad, confianza y contenido. Sin halagos.',
          ),
          ContextExample(
            emoji: '📧',
            context: 'En coaching',
            englishExample: 'Score my pitch and tell me which slide is the weakest.',
            pronunciation: 'skor mai pich',
            spanishExample: 'Califica mi pitch y dime qué slide es la más débil.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'En sesión',
            englishExample: 'Score the team on execution this quarter — be honest.',
            pronunciation: 'skor de tim',
            spanishExample: 'Califica al equipo en ejecución este trimestre — sé honesto.',
          ),
        ],
      ),
      Phrase(
        id: 'bei10-8',
        idiom: 'Iterate',
        literalTranslation: 'Iterar',
        realMeaning: 'Mejorar en ciclos cortos — la primera versión nunca es la final',
        category: 'Nivel 110',
        pronunciation: 'íterait',
        contextExamples: [
          ContextExample(
            emoji: '🤖',
            context: 'Prompt a la IA',
            englishExample: 'Let us iterate — show me 3 versions of this answer, each shorter.',
            pronunciation: 'lets íterait',
            spanishExample: 'Iteremos — muéstrame 3 versiones de esta respuesta, cada una más corta.',
          ),
          ContextExample(
            emoji: '📧',
            context: 'En email',
            englishExample: 'I will iterate on the design and send v3 by Thursday.',
            pronunciation: 'ai wil íterait',
            spanishExample: 'Iteraré en el diseño y enviaré la v3 el jueves.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'En reunión',
            englishExample: 'We will iterate weekly until the metric moves.',
            pronunciation: 'wi wil íterait wikli',
            spanishExample: 'Iteraremos semanalmente hasta que la métrica se mueva.',
          ),
        ],
      ),
    ];
  }

  static String getDailyChallenge() {
    return '''
💼 DESAFÍO: ANÁLISIS PROFUNDO CON IA

Toma una pregunta difícil de entrevista (ej: "¿Por qué deberíamos contratarte?"):

1️⃣ "Break down the underlying intent of this question."
2️⃣ "Score my draft answer 1-10 on clarity, confidence, content."
3️⃣ "List red flags and strengthen the weakest part with a concrete example."
4️⃣ Itera hasta llegar a 9/10 en los 3 ejes.

🎯 META: Convertir respuestas vagas en respuestas que cierran la oferta.
''';
  }
}
