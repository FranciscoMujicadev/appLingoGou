// lib/data/datasources/days/business_interviews_datasource.dart
// Nivel 101 — Option 2: Vocabulary in Business Context
// Cada término se presenta en 3 escenarios: 📧 Email · 🎤 Entrevista · 👥 Reunión

import '../../../core/models/phrase_model.dart';

class BusinessInterviewsDataSource {
  static List<Phrase> getPhrases() {
    return [
      Phrase(
        id: 'bei-2',
        idiom: 'Research the company',
        literalTranslation: 'Investigar la empresa',
        realMeaning: 'Estudiar a fondo una empresa antes de aplicar',
        category: 'Nivel 101',
        pronunciation: 'ri-serch de compani',
        contextExamples: [
          ContextExample(
            emoji: '📧',
            context: 'Email a un contacto interno',
            englishExample:
                'I am researching the company before Friday — any resources you recommend?',
            pronunciation:
                'ai am ri-serching de compani bifor fraidei — eni risorsis yu rekomend',
            spanishExample:
                'Estoy investigando la empresa antes del viernes — ¿algún recurso que recomiendes?',
          ),
          ContextExample(
            emoji: '🎤',
            context: 'Entrevista',
            englishExample:
                'I researched the company and saw you just expanded into three new markets.',
            pronunciation:
                'ai ri-sercht de compani and so yu yast ekspanded intu zri niu markets',
            spanishExample:
                'Investigué la empresa y vi que acaban de expandirse a tres mercados nuevos.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'Reunión de preparación',
            englishExample:
                'Before any interview, always research the company — mission, news, and competitors.',
            pronunciation:
                'bifor eni interview, olweis ri-serch de compani — mishon, niuz, and kompetitors',
            spanishExample:
                'Antes de cualquier entrevista, investiga la empresa: misión, noticias y competencia.',
          ),
        ],
      ),
      Phrase(
        id: 'bei-3',
        idiom: "Values and mission",
        literalTranslation: 'Valores y misión',
        realMeaning: 'Principios y propósito que guían a una empresa',
        category: 'Nivel 101',
        pronunciation: 'valius and mishon',
        contextExamples: [
          ContextExample(
            emoji: '📧',
            context: 'Carta de presentación',
            englishExample:
                "Your values and mission align closely with how I approach my work.",
            pronunciation:
                'yor valius and mishon alain klosli wiz jau ai aproch mai work',
            spanishExample:
                'Sus valores y misión se alinean con la forma en que abordo mi trabajo.',
          ),
          ContextExample(
            emoji: '🎤',
            context: 'Entrevista',
            englishExample:
                "I chose to apply here because your mission to simplify finance resonates with me.",
            pronunciation:
                'ai chos tu aplai jir bikos yor mishon tu simplifai fainans resonaits wiz mi',
            spanishExample:
                'Apliqué aquí porque su misión de simplificar las finanzas resuena conmigo.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'Sesión de coaching',
            englishExample:
                "Knowing the values and mission helps you answer 'Why do you want to work here?'",
            pronunciation:
                'noing de valius and mishon jelps yu answer wai du yu want tu work jir',
            spanishExample:
                "Conocer los valores y misión ayuda a responder '¿Por qué quieres trabajar aquí?'",
          ),
        ],
      ),
      Phrase(
        id: 'bei-4',
        idiom: 'Recent developments',
        literalTranslation: 'Desarrollos recientes',
        realMeaning: 'Noticias, cambios o logros recientes de una empresa',
        category: 'Nivel 101',
        pronunciation: 'risent devélopments',
        contextExamples: [
          ContextExample(
            emoji: '📧',
            context: 'Email de seguimiento',
            englishExample:
                'I read about your recent developments in Latin America — very exciting direction.',
            pronunciation:
                'ai rid abaut yor risent developments in latin america — veri eksaiting direkshon',
            spanishExample:
                'Leí sobre sus desarrollos recientes en Latinoamérica — una dirección muy emocionante.',
          ),
          ContextExample(
            emoji: '🎤',
            context: 'Entrevista',
            englishExample:
                'One of your recent developments — the AI product — is exactly where I want to contribute.',
            pronunciation:
                'wan of yor risent developments — de ei-ai product — is eksactli wer ai want tu kontribiut',
            spanishExample:
                'Uno de sus desarrollos recientes — el producto de IA — es donde quiero contribuir.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'Reunión semanal',
            englishExample:
                "Let's review recent developments in the industry before the client call.",
            pronunciation:
                'lets riviu risent developments in de industri bifor de klaient kol',
            spanishExample:
                'Repasemos los desarrollos recientes del sector antes de la llamada con el cliente.',
          ),
        ],
      ),
      Phrase(
        id: 'bei-5',
        idiom: 'Soft skills',
        literalTranslation: 'Habilidades blandas',
        realMeaning: 'Habilidades interpersonales: comunicación, liderazgo, empatía',
        category: 'Nivel 101',
        pronunciation: 'soft skils',
        contextExamples: [
          ContextExample(
            emoji: '📧',
            context: 'Carta de presentación',
            englishExample:
                'My strongest soft skills — communication and adaptability — match this role.',
            pronunciation:
                'mai strongest soft skils — komunikeishon and adaptabiliti — mach dis rol',
            spanishExample:
                'Mis habilidades blandas más fuertes — comunicación y adaptabilidad — encajan con este puesto.',
          ),
          ContextExample(
            emoji: '🎤',
            context: 'Entrevista',
            englishExample:
                'I would say my top soft skill is staying calm under pressure.',
            pronunciation:
                'ai wud sei mai top soft skil is steying kam ander preshur',
            spanishExample:
                'Diría que mi habilidad blanda principal es mantener la calma bajo presión.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'Reunión de liderazgo',
            englishExample:
                "In leadership roles, soft skills often matter more than technical knowledge.",
            pronunciation:
                'in lidershiip rols, soft skils often mater mor dan teknikal nolech',
            spanishExample:
                'En roles de liderazgo, las habilidades blandas importan más que el conocimiento técnico.',
          ),
        ],
      ),
      Phrase(
        id: 'bei-6',
        idiom: 'Hard skills',
        literalTranslation: 'Habilidades duras',
        realMeaning: 'Habilidades técnicas y medibles (SQL, Excel, diseño, etc.)',
        category: 'Nivel 101',
        pronunciation: 'jard skils',
        contextExamples: [
          ContextExample(
            emoji: '📧',
            context: 'Actualización de CV',
            englishExample:
                'I added my new hard skills: SQL, Power BI, and PMP certification.',
            pronunciation:
                'ai aded mai niu jard skils: es-kiu-el, pauer bi-ai, and pi-em-pi sertifikeshon',
            spanishExample:
                'Agregué mis nuevas habilidades técnicas: SQL, Power BI y certificación PMP.',
          ),
          ContextExample(
            emoji: '🎤',
            context: 'Entrevista técnica',
            englishExample:
                'The role requires hard skills in financial modeling — I completed two courses on it.',
            pronunciation:
                'de rol rikuairs jard skils in fainenshial modeling — ai kompliited tu korses on it',
            spanishExample:
                'El puesto requiere modelado financiero — completé dos cursos al respecto.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'Reunión de contratación',
            englishExample:
                "Her hard skills matched the role better — that is why she was hired.",
            pronunciation:
                'jer jard skils macht de rol beter — dat is wai shi was jaird',
            spanishExample:
                'Sus habilidades técnicas encajaban mejor con el puesto — por eso fue contratada.',
          ),
        ],
      ),
      Phrase(
        id: 'bei-7',
        idiom: 'Add value',
        literalTranslation: 'Agregar valor',
        realMeaning: 'Contribuir más allá de lo mínimo requerido',
        category: 'Nivel 101',
        pronunciation: 'ad valiu',
        contextExamples: [
          ContextExample(
            emoji: '📧',
            context: 'Email de propuesta',
            englishExample:
                'I believe I can add value by bringing bilingual communication to your team.',
            pronunciation:
                'ai biliv ai kan ad valiu bai bringing bilingüal komunikeishon tu yor tim',
            spanishExample:
                'Creo que puedo agregar valor aportando comunicación bilingüe a su equipo.',
          ),
          ContextExample(
            emoji: '🎤',
            context: 'Entrevista',
            englishExample:
                'Last quarter I added value by cutting client response time by 40%.',
            pronunciation:
                'last kwarter ai aded valiu bai kating klaient rispons taim bai forti persent',
            spanishExample:
                'El trimestre pasado agregué valor reduciendo el tiempo de respuesta al cliente en 40%.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'Reunión de revisión',
            englishExample:
                "Ask yourself: how can I add value beyond the job description?",
            pronunciation:
                'ask yor-self: jau kan ai ad valiu biyond de yob deskripshon',
            spanishExample:
                '¿Cómo puedo agregar valor más allá de la descripción del puesto?',
          ),
        ],
      ),
      Phrase(
        id: 'bei-8',
        idiom: 'Ace the interview',
        literalTranslation: 'Sobresalir en la entrevista',
        realMeaning: 'Tener un desempeño sobresaliente en la entrevista',
        category: 'Nivel 101',
        pronunciation: 'eis de interview',
        contextExamples: [
          ContextExample(
            emoji: '📧',
            context: 'Mensaje a un amigo',
            englishExample:
                'I practiced all week — I am ready to ace the interview tomorrow.',
            pronunciation:
                'ai praktist ol wik — ai am redi tu eis de interview tumorou',
            spanishExample:
                'Practiqué toda la semana — estoy listo para sobresalir en la entrevista mañana.',
          ),
          ContextExample(
            emoji: '🎤',
            context: 'Post-entrevista',
            englishExample:
                'She aced the interview by knowing the company inside and out.',
            pronunciation:
                'shi eist de interview bai noing de compani insaid and aut',
            spanishExample:
                'Ella sobresalió en la entrevista por conocer la empresa de adentro hacia afuera.',
          ),
          ContextExample(
            emoji: '👥',
            context: 'Sesión de coaching',
            englishExample:
                "With the right prep, you will ace the interview — guaranteed.",
            pronunciation:
                'wiz de rait prep, yu wil eis de interview — garantid',
            spanishExample:
                'Con la preparación adecuada, sobresaldrás en la entrevista — garantizado.',
          ),
        ],
      ),
    ];
  }

  static String getDailyChallenge() {
    return '''
💼 DESAFÍO: VOCABULARIO EN CONTEXTO DE NEGOCIOS

Elige 3 términos de este nivel y escríbelos en los 3 contextos:

1️⃣ Un email profesional corto (2-3 líneas)
2️⃣ Una respuesta de entrevista (1 oración con confianza)
3️⃣ Un comentario en una reunión (tono natural)

🎯 META: Que el mismo vocabulario suene natural en email, entrevista y reunión.
''';
  }
}
