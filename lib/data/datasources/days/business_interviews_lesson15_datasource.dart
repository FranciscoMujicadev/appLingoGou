// lib/data/datasources/days/business_interviews_lesson15_datasource.dart
// Nivel 114 — Option 1: Interview Q&A Cards (Parte 2)
// Más preguntas trampa con respuesta cliché vs modelo

import '../../../core/models/phrase_model.dart';

class BusinessInterviewsLesson15DataSource {
  static List<Phrase> getPhrases() {
    return [
      Phrase(
        id: 'bei14-1',
        idiom: 'Where do you see yourself in 5 years?',
        literalTranslation: '¿Dónde te ves en 5 años?',
        realMeaning: 'RH evalúa: si estarás en la empresa en 2 años o si te irás pronto',
        category: 'Nivel 114',
        pronunciation: 'wer du yu si yor-self in faiv yirs',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché peligroso',
            englishExample: 'Honestly, in 5 years I want to start my own company.',
            pronunciation: 'in faiv yirs ai want tu start mai on compani',
            spanishExample: 'Honestamente, en 5 años quiero tener mi propia empresa.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'Leading a team that owns a key product line — ideally growing into a director-level role here.',
            pronunciation: 'liding a tim',
            spanishExample: 'Liderando un equipo dueño de una línea de producto clave — idealmente creciendo a director aquí.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Ambitious + tied to this company = no flight risk.',
            pronunciation: 'ambishas plas taid tu dis kompani',
            spanishExample: 'Ambicioso + atado a esta empresa = no eres riesgo de fuga.',
          ),
        ],
      ),
      Phrase(
        id: 'bei14-2',
        idiom: 'Tell me about a time you failed',
        literalTranslation: 'Una vez que fracasaste',
        realMeaning: 'RH evalúa: humildad y capacidad de aprender',
        category: 'Nivel 114',
        pronunciation: 'tel mi abaut a feliur',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'Honestly, I cannot think of a real failure right now.',
            pronunciation: 'ai kanot zink of a rial feliur',
            spanishExample: 'Honestamente, no se me ocurre un fracaso real ahora.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo (STAR)',
            englishExample: 'I launched a campaign without A/B testing. It underperformed by 30%. Now I always run a test on 10% of traffic first.',
            pronunciation: 'ai lonchd a kampein',
            spanishExample: 'Lancé una campaña sin A/B test. Bajó 30%. Ahora siempre testeo en 10% del tráfico primero.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Real failure + measurable impact + permanent fix.',
            pronunciation: 'rial feliur plas mezurabol impakt',
            spanishExample: 'Fracaso real + impacto medible + corrección permanente.',
          ),
        ],
      ),
      Phrase(
        id: 'bei14-3',
        idiom: 'How do you prioritize?',
        literalTranslation: '¿Cómo priorizas?',
        realMeaning: 'RH evalúa: si tienes un sistema o reaccionas al ruido',
        category: 'Nivel 114',
        pronunciation: 'jau du yu praioritais',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'I just do the most important things first.',
            pronunciation: 'ai yast du de most important',
            spanishExample: 'Hago lo más importante primero.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'I use Eisenhower: urgent vs important. Every Monday I pick 3 weekly priorities and protect them with calendar blocks.',
            pronunciation: 'ai yus aizenjauer',
            spanishExample: 'Uso Eisenhower: urgente vs importante. Cada lunes elijo 3 prioridades semanales y las protejo con bloques de calendario.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Named system + concrete habit = real prioritization.',
            pronunciation: 'neimd sistem',
            spanishExample: 'Sistema con nombre + hábito concreto = priorización real.',
          ),
        ],
      ),
      Phrase(
        id: 'bei14-4',
        idiom: 'Describe your management style',
        literalTranslation: 'Tu estilo de gestión',
        realMeaning: 'RH evalúa: si gestionas con claridad o con autoridad',
        category: 'Nivel 114',
        pronunciation: 'manechment stail',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'I am a servant leader who empowers everyone.',
            pronunciation: 'ai am a servant lider',
            spanishExample: 'Soy un líder al servicio que empodera a todos.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'High autonomy, high context. I share the why, set 3 weekly priorities, then unblock — not micro-manage.',
            pronunciation: 'jai autonomi, jai kontekst',
            spanishExample: 'Alta autonomía, alto contexto. Comparto el por qué, defino 3 prioridades semanales, y desbloqueo — no microgestiono.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'A philosophy + concrete operating system = a leader you can picture.',
            pronunciation: 'a filosofi plas konkret operating sistem',
            spanishExample: 'Filosofía + sistema operativo concreto = un líder que puedes imaginar.',
          ),
        ],
      ),
      Phrase(
        id: 'bei14-5',
        idiom: 'Disagreement with your boss',
        literalTranslation: 'Cuando no estás de acuerdo con tu jefe',
        realMeaning: 'RH evalúa: si puedes ser diplomático y mantener tu posición',
        category: 'Nivel 114',
        pronunciation: 'disagriment wiz yor bos',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'I always do what my boss says — they are the boss.',
            pronunciation: 'ai olweis du wat mai bos seis',
            spanishExample: 'Siempre hago lo que mi jefe dice — es el jefe.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'I shared data showing the launch date was risky. He kept the date — I committed fully and we shipped on time.',
            pronunciation: 'ai sherd data',
            spanishExample: 'Compartí datos que mostraban que la fecha era riesgosa. Mantuvo la fecha — me comprometí totalmente y entregamos a tiempo.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Disagree + commit — the executive standard.',
            pronunciation: 'disagri plas kommit',
            spanishExample: 'Discrepa + comprométete — el estándar ejecutivo.',
          ),
        ],
      ),
      Phrase(
        id: 'bei14-6',
        idiom: 'When did you exceed expectations?',
        literalTranslation: 'Cuando superaste expectativas',
        realMeaning: 'RH evalúa: si entregas más de lo pedido sin que te lo digan',
        category: 'Nivel 114',
        pronunciation: 'eksid ekspekteishons',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'I always go above and beyond in everything I do.',
            pronunciation: 'ai olweis gou abav and biyond',
            spanishExample: 'Siempre voy más allá en todo lo que hago.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'I was hired to redesign the homepage. I also rebuilt the analytics — sessions went up 60%.',
            pronunciation: 'ai was jaird tu ridisain',
            spanishExample: 'Me contrataron para rediseñar la home. También reconstruí el analytics — las sesiones subieron 60%.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Specific extra delivery + measurable outcome = a true overdeliverer.',
            pronunciation: 'spisifik ekstra delivery',
            spanishExample: 'Entrega extra específica + resultado medible = realmente sobreentregas.',
          ),
        ],
      ),
      Phrase(
        id: 'bei14-7',
        idiom: 'Working with difficult people',
        literalTranslation: 'Trabajar con gente difícil',
        realMeaning: 'RH evalúa: tu nivel de empatía y profesionalismo bajo fricción',
        category: 'Nivel 114',
        pronunciation: 'difikolt pipol',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché peligroso',
            englishExample: 'I had a coworker who was just impossible — toxic, lazy, the worst.',
            pronunciation: 'imposibol — toksik, leizi',
            spanishExample: 'Tenía un colega que era imposible — tóxico, perezoso, el peor.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'A peer constantly shifted blame. I started a weekly written status doc — it removed ambiguity and the issue resolved itself.',
            pronunciation: 'a pir konstantli shifted bleim',
            spanishExample: 'Un colega siempre culpaba a otros. Inicié un status semanal escrito — eliminó la ambigüedad y el problema se resolvió solo.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Describe the behavior, not the person — and your fix.',
            pronunciation: 'diskraib de bijeivior',
            spanishExample: 'Describe la conducta, no a la persona — y tu solución.',
          ),
        ],
      ),
      Phrase(
        id: 'bei14-8',
        idiom: 'Do you have any questions for us?',
        literalTranslation: '¿Tienes preguntas para nosotros?',
        realMeaning: 'RH evalúa: si te interesa el rol o solo necesitas un trabajo',
        category: 'Nivel 114',
        pronunciation: 'eni kuestions for as',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Cliché',
            englishExample: 'No, I think you covered everything — thank you.',
            pronunciation: 'no, ai zink yu koverd evrizing',
            spanishExample: 'No, creo que cubrieron todo — gracias.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Modelo',
            englishExample: 'Yes — what does success look like at the 90-day mark? And what is the biggest challenge facing this team this quarter?',
            pronunciation: 'wat das sakses luk laik',
            spanishExample: 'Sí — ¿cómo se ve el éxito a los 90 días? ¿Y cuál es el mayor reto del equipo este trimestre?',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Two strategic questions = serious candidate, not job seeker.',
            pronunciation: 'tu strateyik kuestions',
            spanishExample: 'Dos preguntas estratégicas = candidato serio, no buscador de empleo.',
          ),
        ],
      ),
    ];
  }

  static String getDailyChallenge() {
    return '''
💼 DESAFÍO: Q&A — PARTE 2

Elige 4 preguntas de este nivel y responde:

1️⃣ La cliché — para reconocerla en ti.
2️⃣ La modelo — con UN número o resultado real.
3️⃣ Cronométrate. Cada respuesta entre 30 y 60 segundos.
4️⃣ La última: prepara 3 preguntas tuyas para hacerle al entrevistador.

🎯 META: Salir de la entrevista habiendo demostrado experiencia, no solo voluntad.
''';
  }
}
