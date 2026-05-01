// lib/data/datasources/days/business_interviews_lesson9_datasource.dart
// Nivel 108 — Option 5: Dialogue Cards (Cliché vs Honesto)
// Cada tarjeta: 🎙️ RH pregunta · 🚫 Respuesta cliché · ✅ Respuesta honesta · 🎯 Análisis

import '../../../core/models/phrase_model.dart';

class BusinessInterviewsLesson9DataSource {
  static List<Phrase> getPhrases() {
    return [
      Phrase(
        id: 'bei8-1',
        idiom: 'Diálogo: "I am a perfectionist"',
        literalTranslation: 'El cliché del perfeccionista',
        realMeaning: 'Cómo transformar un cliché en una debilidad real y creíble',
        category: 'Nivel 108',
        pronunciation: 'ai am a perfekshanist',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'What is your greatest weakness?',
            pronunciation: 'wat is yor greitest wiknes',
            spanishExample: '¿Cuál es tu mayor debilidad?',
          ),
          ContextExample(
            emoji: '🚫',
            context: 'Cliché a evitar',
            englishExample: 'Honestly, I think I am a perfectionist — I just care too much.',
            pronunciation: 'onestli, ai zink ai am a perfekshanist — ai yast ker tu moch',
            spanishExample: 'Honestamente, soy perfeccionista — me importa demasiado.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta honesta',
            englishExample: 'I struggle with delegating — I am learning to trust my team with ownership.',
            pronunciation: 'ai strágol wiz delegueiting — ai am lerning tu trast mai tim wiz onership',
            spanishExample: 'Me cuesta delegar — estoy aprendiendo a confiar en mi equipo con responsabilidades.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Real weakness + active solution = honest and self-aware.',
            pronunciation: 'rial wiknes plas aktiv solushon ikuals onest and self-awer',
            spanishExample: 'Debilidad real + solución activa = honesto y consciente de ti mismo.',
          ),
        ],
      ),
      Phrase(
        id: 'bei8-2',
        idiom: 'Diálogo: "I am a hard worker"',
        literalTranslation: 'El cliché del "trabajador duro"',
        realMeaning: 'Reemplazar la frase genérica con evidencia concreta',
        category: 'Nivel 108',
        pronunciation: 'ai am a jard worker',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'Why should we hire you?',
            pronunciation: 'wai shud wi jair yu',
            spanishExample: '¿Por qué deberíamos contratarte?',
          ),
          ContextExample(
            emoji: '🚫',
            context: 'Cliché a evitar',
            englishExample: 'Because I am a hard worker and a fast learner.',
            pronunciation: 'bikos ai am a jard worker and a fast lerner',
            spanishExample: 'Porque soy trabajador y aprendo rápido.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta honesta',
            englishExample: 'Last year I led a project that cut onboarding time by 50% — I can bring that same focus here.',
            pronunciation: 'last yir ai led a proyekt dat kat onbording taim bai fifti persent',
            spanishExample: 'El año pasado lideré un proyecto que redujo el onboarding un 50% — puedo traer ese enfoque aquí.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'A specific result beats 10 generic adjectives every time.',
            pronunciation: 'a spisifik risolt bits ten yeneric adyetivs evri taim',
            spanishExample: 'Un resultado específico le gana a 10 adjetivos genéricos.',
          ),
        ],
      ),
      Phrase(
        id: 'bei8-3',
        idiom: 'Diálogo: "I work well under pressure"',
        literalTranslation: 'El cliché de la presión',
        realMeaning: 'Demostrar con una historia real en lugar de afirmarlo',
        category: 'Nivel 108',
        pronunciation: 'ai work wel ander preshur',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'How do you handle pressure?',
            pronunciation: 'jau du yu jandol preshur',
            spanishExample: '¿Cómo manejas la presión?',
          ),
          ContextExample(
            emoji: '🚫',
            context: 'Cliché a evitar',
            englishExample: 'I work really well under pressure — it motivates me.',
            pronunciation: 'ai work rili wel ander preshur — it motiveits mi',
            spanishExample: 'Trabajo muy bien bajo presión — me motiva.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta honesta',
            englishExample: 'During a product launch last quarter, two team members quit. I reprioritized and we shipped on time.',
            pronunciation: 'diuring a product lonch last kwarter, tu tim members kuit',
            spanishExample: 'Durante un lanzamiento, dos miembros del equipo renunciaron. Reprioricé y entregamos a tiempo.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Show, do not tell — a real story proves it.',
            pronunciation: 'sho, du nat tel — a rial stori pruvs it',
            spanishExample: 'Muestra, no digas — una historia real lo demuestra.',
          ),
        ],
      ),
      Phrase(
        id: 'bei8-4',
        idiom: 'Diálogo: "I do not have that skill"',
        literalTranslation: 'La regla de oro: honestidad',
        realMeaning: 'Admitir lo que no sabes sin hundir tu candidatura',
        category: 'Nivel 108',
        pronunciation: 'ai du nat jav dat skil',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'Do you have experience with Salesforce?',
            pronunciation: 'du yu jav eksperiens wiz seilsfors',
            spanishExample: '¿Tienes experiencia con Salesforce?',
          ),
          ContextExample(
            emoji: '🚫',
            context: 'Mentira peligrosa',
            englishExample: 'Yes, of course — I use it all the time.',
            pronunciation: 'yes, of kors — ai yus it ol de taim',
            spanishExample: 'Sí, claro — lo uso todo el tiempo.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta honesta',
            englishExample: 'I have not used Salesforce, but I learned HubSpot in two weeks. I can ramp up quickly.',
            pronunciation: 'ai jav nat yusd seilsfors, bat ai lernt jabspot in tu wiks',
            spanishExample: 'No he usado Salesforce, pero aprendí HubSpot en dos semanas. Puedo ponerme al día rápido.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Honesty + evidence of fast learning builds trust.',
            pronunciation: 'onesti plas evidens of fast lerning bilds trast',
            spanishExample: 'Honestidad + evidencia de aprendizaje rápido construye confianza.',
          ),
        ],
      ),
      Phrase(
        id: 'bei8-5',
        idiom: 'Diálogo: "Why did you leave?"',
        literalTranslation: 'Hablar del empleo anterior sin quejarse',
        realMeaning: 'Nunca hables mal del jefe anterior — reenfoca a lo positivo',
        category: 'Nivel 108',
        pronunciation: 'wai did yu liv',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'Why did you leave your last job?',
            pronunciation: 'wai did yu liv yor last yob',
            spanishExample: '¿Por qué dejaste tu último trabajo?',
          ),
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta a evitar',
            englishExample: 'My manager was terrible and the company was toxic.',
            pronunciation: 'mai manayer was teribol and de compani was toksik',
            spanishExample: 'Mi jefe era terrible y la empresa tóxica.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta honesta',
            englishExample: 'I outgrew the role. I am looking for a place where I can own bigger projects.',
            pronunciation: 'ai autgru de rol. ai am luking for a pleis wer ai kan on biger proyekts',
            spanishExample: 'Crecí más allá del puesto. Busco un lugar con proyectos más grandes.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Forward-looking + no blame = mature and professional.',
            pronunciation: 'foruard-luking plas no bleim ikuals machur and profeshional',
            spanishExample: 'Hacia adelante + sin culpar = maduro y profesional.',
          ),
        ],
      ),
      Phrase(
        id: 'bei8-6',
        idiom: 'Diálogo: "What is your dream job?"',
        literalTranslation: 'La trampa del "trabajo soñado"',
        realMeaning: 'Conectar tus aspiraciones con el puesto actual',
        category: 'Nivel 108',
        pronunciation: 'wat is yor drim yob',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'What is your dream job?',
            pronunciation: 'wat is yor drim yob',
            spanishExample: '¿Cuál es tu trabajo soñado?',
          ),
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta peligrosa',
            englishExample: 'Honestly, I want to start my own company in two years.',
            pronunciation: 'onestli, ai want tu start mai on compani in tu yirs',
            spanishExample: 'Honestamente, quiero tener mi propia empresa en dos años.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta balanceada',
            englishExample: 'A role where I lead cross-functional projects and grow — this position fits that path.',
            pronunciation: 'a rol wer ai lid kros-fankshional proyekts and grou',
            spanishExample: 'Un puesto donde lidere proyectos multifuncionales y crezca — este rol encaja.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Ambitious but aligned — not a flight risk.',
            pronunciation: 'ambishas bat alaind — nat a flait risk',
            spanishExample: 'Ambicioso pero alineado — no un riesgo de fuga.',
          ),
        ],
      ),
      Phrase(
        id: 'bei8-7',
        idiom: 'Diálogo: "Salary expectations?"',
        literalTranslation: 'Hablar de salario con confianza',
        realMeaning: 'Responder con un rango basado en investigación, no en esperanzas',
        category: 'Nivel 108',
        pronunciation: 'salari ekspekteishons',
        contextExamples: [
          ContextExample(
            emoji: '🎙️',
            context: 'RH pregunta',
            englishExample: 'What are your salary expectations?',
            pronunciation: 'wat ar yor salari ekspekteishons',
            spanishExample: '¿Cuáles son tus expectativas salariales?',
          ),
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta débil',
            englishExample: 'Whatever you think is fair — I am flexible.',
            pronunciation: 'watever yu zink is fer — ai am fleksibol',
            spanishExample: 'Lo que consideren justo — soy flexible.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta con datos',
            englishExample: 'Based on market data for this role, I am targeting a range of 60 to 70K.',
            pronunciation: 'beisd on market data for dis rol, ai am targueting a reinch of siksti tu seventi kei',
            spanishExample: 'Basado en datos del mercado para este rol, busco un rango de 60 a 70K.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Researched range = professional, not desperate.',
            pronunciation: 'riserched reinch ikuals profeshional, nat desperet',
            spanishExample: 'Rango investigado = profesional, no desesperado.',
          ),
        ],
      ),
      Phrase(
        id: 'bei8-8',
        idiom: 'La regla de oro',
        literalTranslation: 'The golden rule',
        realMeaning: 'Sé honesto, sé específico, nunca hables mal de nadie',
        category: 'Nivel 108',
        pronunciation: 'de golden rul',
        contextExamples: [
          ContextExample(
            emoji: '🥇',
            context: 'Principio #1',
            englishExample: 'Be honest — if you do not know, say so and show how you would learn.',
            pronunciation: 'bi onest — if yu du nat nou, sei so and sho jau yu wud lern',
            spanishExample: 'Sé honesto — si no sabes, dilo y muestra cómo aprenderías.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Principio #2',
            englishExample: 'Be specific — swap adjectives for numbers, dates, and outcomes.',
            pronunciation: 'bi spisifik — suop adyetivs for nambers, deits, and autkams',
            spanishExample: 'Sé específico — cambia adjetivos por números, fechas y resultados.',
          ),
          ContextExample(
            emoji: '🚫',
            context: 'Principio #3',
            englishExample: 'Never badmouth a former boss or company — it always backfires.',
            pronunciation: 'never badmauz a former bos or compani — it olweis bakfaiers',
            spanishExample: 'Nunca hables mal de un jefe o empresa anterior — siempre se vuelve en tu contra.',
          ),
        ],
      ),
    ];
  }

  static String getDailyChallenge() {
    return '''
💼 DESAFÍO: DE CLICHÉ A HONESTO

Toma 3 clichés que hayas dicho antes:
• "Soy perfeccionista"
• "Soy trabajador"
• "Trabajo bien bajo presión"

1️⃣ Reemplázalos por una historia real de 2-3 oraciones.
2️⃣ Incluye UN número, UNA fecha o UN resultado concreto.
3️⃣ Practícalo en voz alta hasta que suene natural — no memorizado.

🎯 REGLA DE ORO: Honesto · Específico · Sin hablar mal de nadie.
''';
  }
}
