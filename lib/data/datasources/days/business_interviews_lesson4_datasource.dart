// lib/data/datasources/days/business_interviews_lesson4_datasource.dart
// Nivel 103 — Option 2: Vocabulary in Business Context (Follow-up Email)
// Vocabulario clave del email post-entrevista en 3 escenarios

import '../../../core/models/phrase_model.dart';

class BusinessInterviewsLesson4DataSource {
  static List<Phrase> getPhrases() {
    return [
      Phrase(
        id: 'bei3-1',
        idiom: 'Thank you for your time',
        literalTranslation: 'Gracias por su tiempo',
        realMeaning: 'La apertura estándar de un email post-entrevista',
        category: 'Nivel 103',
        pronunciation: 'zenk yu for yor taim',
        contextExamples: [
          ContextExample(
            emoji: '📧',
            context: 'Apertura formal',
            englishExample: 'Thank you for your time today — I really enjoyed our conversation.',
            pronunciation: 'zenk yu for yor taim tudei',
            spanishExample: 'Gracias por su tiempo hoy — disfruté mucho nuestra conversación.',
          ),
          ContextExample(
            emoji: '📧',
            context: 'Apertura cálida',
            englishExample: 'Thank you for taking the time to walk me through the role this morning.',
            pronunciation: 'zenk yu for teiking de taim',
            spanishExample: 'Gracias por tomarse el tiempo de explicarme el puesto esta mañana.',
          ),
          ContextExample(
            emoji: '📧',
            context: 'Apertura ejecutiva',
            englishExample: 'I appreciate you and the team making time to meet with me yesterday.',
            pronunciation: 'ai aprishieit yu',
            spanishExample: 'Aprecio que usted y el equipo hicieran tiempo para reunirse conmigo ayer.',
          ),
        ],
      ),
      Phrase(
        id: 'bei3-2',
        idiom: 'I am very interested',
        literalTranslation: 'Estoy muy interesado',
        realMeaning: 'Reafirmar tu interés sin sonar desesperado',
        category: 'Nivel 103',
        pronunciation: 'ai am veri intrested',
        contextExamples: [
          ContextExample(
            emoji: '✅',
            context: 'Interés con razón',
            englishExample: 'I am very interested — the focus on Latin America fits exactly where I want to grow.',
            pronunciation: 'ai am veri intrested',
            spanishExample: 'Estoy muy interesado — el enfoque en Latinoamérica encaja con donde quiero crecer.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Interés ejecutivo',
            englishExample: 'After our talk, I am even more excited about contributing to the team.',
            pronunciation: 'after aur tok',
            spanishExample: 'Después de nuestra charla, estoy aún más entusiasmado por aportar al equipo.',
          ),
          ContextExample(
            emoji: '🚫',
            context: 'Lo que NO escribir',
            englishExample: 'I really, really, really need this job — please consider me!',
            pronunciation: 'ai rili, rili, rili nid dis yob',
            spanishExample: 'Necesito mucho, mucho este trabajo — ¡por favor considéreme!',
          ),
        ],
      ),
      Phrase(
        id: 'bei3-3',
        idiom: 'Reference a specific moment',
        literalTranslation: 'Referenciar un momento de la entrevista',
        realMeaning: 'Demostrar que escuchaste, no que enviaste un template',
        category: 'Nivel 103',
        pronunciation: 'spisifik moument',
        contextExamples: [
          ContextExample(
            emoji: '📧',
            context: 'Referencia a un proyecto',
            englishExample: 'I keep thinking about the AI dashboard you mentioned — I have ideas I would love to share.',
            pronunciation: 'ai kip zinking abaut',
            spanishExample: 'Sigo pensando en el dashboard de IA que mencionó — tengo ideas que me encantaría compartir.',
          ),
          ContextExample(
            emoji: '📧',
            context: 'Referencia a un comentario',
            englishExample: 'Your point about cross-team collaboration resonated — that is exactly how I work best.',
            pronunciation: 'yor point abaut kros-tim kolaboreishon',
            spanishExample: 'Su comentario sobre colaboración entre equipos resonó — así es exactamente como trabajo mejor.',
          ),
          ContextExample(
            emoji: '📧',
            context: 'Referencia a una pregunta',
            englishExample: 'You asked how I would handle the Q4 launch — I sketched a quick outline (attached).',
            pronunciation: 'yu askt jau ai wud jandol',
            spanishExample: 'Me preguntó cómo manejaría el lanzamiento del Q4 — dibujé un esquema rápido (adjunto).',
          ),
        ],
      ),
      Phrase(
        id: 'bei3-4',
        idiom: 'Follow up on a question',
        literalTranslation: 'Hacer seguimiento a una pregunta',
        realMeaning: 'Aclarar o expandir una respuesta que no diste bien',
        category: 'Nivel 103',
        pronunciation: 'folou ap on a kuestion',
        contextExamples: [
          ContextExample(
            emoji: '📧',
            context: 'Aclaración honesta',
            englishExample: 'I want to follow up on your question about SQL — I undersold my experience. I have led 3 reporting projects.',
            pronunciation: 'ai want tu folou ap',
            spanishExample: 'Quiero retomar su pregunta sobre SQL — me subestimé. He liderado 3 proyectos de reportes.',
          ),
          ContextExample(
            emoji: '📧',
            context: 'Respuesta más completa',
            englishExample: 'A quick follow-up — when you asked about my biggest win, I forgot to mention the 3x revenue growth.',
            pronunciation: 'a kuik folou-ap',
            spanishExample: 'Un seguimiento rápido — cuando preguntó por mi mayor logro, olvidé mencionar el crecimiento 3x en ingresos.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'It shows reflection — and gives you a second chance to land the point.',
            pronunciation: 'it shos riflekshon',
            spanishExample: 'Muestra reflexión — y te da una segunda oportunidad para hacer la idea aterrizar.',
          ),
        ],
      ),
      Phrase(
        id: 'bei3-5',
        idiom: 'Looking forward to hearing from you',
        literalTranslation: 'Quedo a la espera de su respuesta',
        realMeaning: 'El cierre estándar — profesional sin presionar',
        category: 'Nivel 103',
        pronunciation: 'luking foruard tu jiring from yu',
        contextExamples: [
          ContextExample(
            emoji: '📧',
            context: 'Cierre clásico',
            englishExample: 'Looking forward to hearing from you about next steps.',
            pronunciation: 'luking foruard tu jiring',
            spanishExample: 'Quedo a la espera de sus comentarios sobre los siguientes pasos.',
          ),
          ContextExample(
            emoji: '📧',
            context: 'Cierre con disponibilidad',
            englishExample: 'Happy to share more details if helpful — looking forward to your reply.',
            pronunciation: 'japi tu sher mor diteils',
            spanishExample: 'Con gusto comparto más detalles si es útil — quedo atento a su respuesta.',
          ),
          ContextExample(
            emoji: '📧',
            context: 'Cierre cálido',
            englishExample: 'Thanks again for your time — I look forward to staying in touch.',
            pronunciation: 'zenks aguen for yor taim',
            spanishExample: 'Gracias de nuevo por su tiempo — espero seguir en contacto.',
          ),
        ],
      ),
      Phrase(
        id: 'bei3-6',
        idiom: 'Add value in the email',
        literalTranslation: 'Agregar valor en el email',
        realMeaning: 'Adjuntar algo útil convierte un "thank you" en un cierre de venta',
        category: 'Nivel 103',
        pronunciation: 'ad valiu in de imeil',
        contextExamples: [
          ContextExample(
            emoji: '📎',
            context: 'Adjuntar plan',
            englishExample: 'I sketched a 30-60-90 day plan for the role — sharing it for your reference.',
            pronunciation: 'ai sketcht a zerti-siksti-naineti dei plan',
            spanishExample: 'Esbocé un plan 30-60-90 para el puesto — lo comparto para su referencia.',
          ),
          ContextExample(
            emoji: '📎',
            context: 'Compartir un recurso',
            englishExample: 'You mentioned struggling with onboarding — here is an article I found useful.',
            pronunciation: 'yu menshond stragling',
            spanishExample: 'Mencionó dificultades con el onboarding — aquí un artículo que me pareció útil.',
          ),
          ContextExample(
            emoji: '📎',
            context: 'Mostrar trabajo previo',
            englishExample: 'Attached is the case study I described — happy to walk you through it.',
            pronunciation: 'atacht is de keis stadi',
            spanishExample: 'Adjunto el caso de estudio que describí — con gusto se lo explico.',
          ),
        ],
      ),
      Phrase(
        id: 'bei3-7',
        idiom: 'When to send the email',
        literalTranslation: 'Cuándo enviar',
        realMeaning: 'El timing del follow-up es tan importante como el contenido',
        category: 'Nivel 103',
        pronunciation: 'wen tu send',
        contextExamples: [
          ContextExample(
            emoji: '⏱️',
            context: 'Timing ideal',
            englishExample: 'Send your thank-you email within 24 hours — same day if possible.',
            pronunciation: 'send yor zenk-yu imeil',
            spanishExample: 'Envía tu email de agradecimiento en menos de 24 horas — el mismo día si puedes.',
          ),
          ContextExample(
            emoji: '⏱️',
            context: 'Si no han respondido',
            englishExample: 'If you have not heard back in a week, send one polite follow-up — only one.',
            pronunciation: 'if yu jav nat jerd bak',
            spanishExample: 'Si no respondieron en una semana, envía UN seguimiento educado — solo uno.',
          ),
          ContextExample(
            emoji: '🚫',
            context: 'Lo que NO hacer',
            englishExample: 'Do not email every 2 days — it reads as desperate.',
            pronunciation: 'du nat imeil evri tu deis',
            spanishExample: 'No envíes email cada 2 días — se lee como desesperación.',
          ),
        ],
      ),
      Phrase(
        id: 'bei3-8',
        idiom: 'Keep it short',
        literalTranslation: 'Mantenlo corto',
        realMeaning: 'El mejor follow-up es de 4-6 oraciones — no un ensayo',
        category: 'Nivel 103',
        pronunciation: 'kip it short',
        contextExamples: [
          ContextExample(
            emoji: '📧',
            context: 'Email modelo (corto)',
            englishExample: 'Hi [Name], thanks for your time. The AI dashboard idea stuck with me — I drafted a quick approach (attached). Excited about next steps.',
            pronunciation: 'jai neim, zenks for yor taim',
            spanishExample: 'Hola [Nombre], gracias por su tiempo. La idea del dashboard de IA me quedó dando vueltas — esbocé un enfoque (adjunto). Entusiasmado por los siguientes pasos.',
          ),
          ContextExample(
            emoji: '🚫',
            context: 'Email demasiado largo',
            englishExample: 'A 5-paragraph essay re-explaining your entire CV — they will not read it.',
            pronunciation: 'a faiv-paragraf esei',
            spanishExample: 'Un ensayo de 5 párrafos reexplicando todo tu CV — no lo van a leer.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Regla práctica',
            englishExample: '4-6 sentences. One reference. One value-add. One clear close.',
            pronunciation: 'for tu siks sentenses',
            spanishExample: '4-6 oraciones. Una referencia. Un aporte. Un cierre claro.',
          ),
        ],
      ),
    ];
  }

  static String getDailyChallenge() {
    return '''
💼 DESAFÍO: ESCRIBE TU FOLLOW-UP EMAIL

Imagina que ayer tuviste una entrevista. Escribe el email AHORA:

1️⃣ Apertura: gracias específico (no genérico).
2️⃣ Una referencia a algo que el entrevistador dijo.
3️⃣ Un aporte: idea, plan, recurso o caso.
4️⃣ Cierre profesional con disponibilidad.

🎯 LÍMITE: 6 oraciones máximo. Si lo extiendes, lo cortas.
''';
  }
}
