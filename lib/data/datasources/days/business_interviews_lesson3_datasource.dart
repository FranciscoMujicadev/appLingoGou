// lib/data/datasources/days/business_interviews_lesson3_datasource.dart
// Nivel 102 — Option 1: Interview Q&A Cards (Body Language & First Impression)
// Reemplaza contenido genérico con preguntas reales sobre lenguaje no verbal

import '../../../core/models/phrase_model.dart';

class BusinessInterviewsLesson3DataSource {
  static List<Phrase> getPhrases() {
    return [
      Phrase(
        id: 'bei2-1',
        idiom: 'How firm should your handshake be?',
        literalTranslation: 'El primer apretón de manos',
        realMeaning: 'Define los primeros 3 segundos de la entrevista',
        category: 'Nivel 102',
        pronunciation: 'jandsheik',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Lo que NO funciona',
            englishExample: 'A weak, sweaty handshake — or one that crushes the other person.',
            pronunciation: 'a wik, sueti jandsheik',
            spanishExample: 'Un apretón débil y sudoroso — o uno que aplasta a la otra persona.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Lo que sí funciona',
            englishExample: 'Firm grip, two seconds, eye contact, and a clear: "Nice to meet you, [name]."',
            pronunciation: 'ferm grip, tu sekonds, ai kontakt',
            spanishExample: 'Apretón firme, 2 segundos, contacto visual y claro: "Mucho gusto, [nombre]".',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué importa',
            englishExample: 'A confident handshake signals respect before you say anything else.',
            pronunciation: 'a konfident jandsheik signals rispekt',
            spanishExample: 'Un apretón firme transmite respeto antes de decir nada más.',
          ),
        ],
      ),
      Phrase(
        id: 'bei2-2',
        idiom: 'Where should you look during the interview?',
        literalTranslation: 'Contacto visual',
        realMeaning: 'No demasiado, no demasiado poco — la regla del 60%',
        category: 'Nivel 102',
        pronunciation: 'ai kontakt',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Lo que NO funciona',
            englishExample: 'Staring intensely or constantly looking down at your hands.',
            pronunciation: 'stering intensli',
            spanishExample: 'Mirar intensamente o constantemente mirar tus manos.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'La regla del 60%',
            englishExample: 'Hold eye contact about 60% of the time. Look away briefly when thinking.',
            pronunciation: 'jold ai kontakt abaut siksti persent',
            spanishExample: 'Mantén contacto visual ~60% del tiempo. Aparta la mirada brevemente al pensar.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'En entrevistas por video',
            englishExample: 'Look at the camera, not the screen — that is "eye contact" online.',
            pronunciation: 'luk at de kamera, nat de skrin',
            spanishExample: 'Mira a la cámara, no a la pantalla — ese es el contacto visual online.',
          ),
        ],
      ),
      Phrase(
        id: 'bei2-3',
        idiom: 'How should you sit?',
        literalTranslation: 'Postura corporal',
        realMeaning: 'Tu cuerpo dice "estoy listo" antes de que abras la boca',
        category: 'Nivel 102',
        pronunciation: 'pósture',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Lo que NO funciona',
            englishExample: 'Slouching, crossed arms, or leaning too far back.',
            pronunciation: 'slauching, krost arms',
            spanishExample: 'Encorvarse, brazos cruzados o reclinarse demasiado.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Postura correcta',
            englishExample: 'Sit upright, feet flat, lean slightly forward when listening.',
            pronunciation: 'sit aprait, fit flat',
            spanishExample: 'Siéntate derecho, pies en el suelo, inclínate ligeramente al escuchar.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué importa',
            englishExample: 'Open posture signals confidence and engagement — without saying a word.',
            pronunciation: 'open pósture signals konfidens',
            spanishExample: 'Una postura abierta transmite confianza y atención sin decir una palabra.',
          ),
        ],
      ),
      Phrase(
        id: 'bei2-4',
        idiom: 'What should you do with your hands?',
        literalTranslation: 'Manos y gestos',
        realMeaning: 'Las manos quietas dicen "estoy nervioso"; gestos naturales dicen "domino esto"',
        category: 'Nivel 102',
        pronunciation: 'jands and yestiurs',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Lo que NO funciona',
            englishExample: 'Tapping fingers, playing with a pen, or fidgeting with your ring.',
            pronunciation: 'taping fingers',
            spanishExample: 'Tamborilear los dedos, jugar con un bolígrafo o juguetear con un anillo.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Lo que sí funciona',
            englishExample: 'Rest hands on the table; use open gestures when explaining a point.',
            pronunciation: 'rest jands on de teibol',
            spanishExample: 'Manos sobre la mesa; usa gestos abiertos al explicar una idea.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Tip ejecutivo',
            englishExample: 'Open palms when speaking signal honesty and openness.',
            pronunciation: 'open palms wen spiking',
            spanishExample: 'Palmas abiertas al hablar transmiten honestidad y apertura.',
          ),
        ],
      ),
      Phrase(
        id: 'bei2-5',
        idiom: 'How should you smile?',
        literalTranslation: 'La sonrisa',
        realMeaning: 'Una sonrisa real abre puertas; una falsa las cierra',
        category: 'Nivel 102',
        pronunciation: 'smail',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Lo que NO funciona',
            englishExample: 'A frozen smile the whole interview — or no smile at all.',
            pronunciation: 'a frosen smail',
            spanishExample: 'Una sonrisa congelada toda la entrevista — o ninguna sonrisa.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Cuándo sonreír',
            englishExample: 'Smile when greeting, when sharing a win, and when the interviewer makes a light comment.',
            pronunciation: 'smail wen griting',
            spanishExample: 'Sonríe al saludar, al contar un logro y cuando el entrevistador hace un comentario ligero.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué importa',
            englishExample: 'A real smile relaxes the room and shows you actually want to be there.',
            pronunciation: 'a rial smail relakses de rum',
            spanishExample: 'Una sonrisa real relaja el ambiente y muestra que quieres estar ahí.',
          ),
        ],
      ),
      Phrase(
        id: 'bei2-6',
        idiom: 'How should you dress?',
        literalTranslation: 'Vestimenta',
        realMeaning: 'Vístete un nivel arriba del código de la empresa',
        category: 'Nivel 102',
        pronunciation: 'dres koud',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Errores comunes',
            englishExample: 'Wearing a full suit at a casual startup — or jeans at a corporate firm.',
            pronunciation: 'wering a ful sut',
            spanishExample: 'Traje completo en una startup casual — o jeans en una empresa corporativa.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'La regla',
            englishExample: 'Check their LinkedIn photos. Dress one level above what employees wear daily.',
            pronunciation: 'chek der linkedin fotos',
            spanishExample: 'Revisa sus fotos de LinkedIn. Vístete un nivel arriba de lo que usan a diario.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué importa',
            englishExample: 'Your outfit signals: "I researched this company and I respect the role."',
            pronunciation: 'yor autfit signals',
            spanishExample: 'Tu vestimenta dice: "Investigué la empresa y respeto el puesto".',
          ),
        ],
      ),
      Phrase(
        id: 'bei2-7',
        idiom: 'How early should you arrive?',
        literalTranslation: 'Puntualidad',
        realMeaning: 'Ni demasiado pronto ni a tiempo — 10 minutos antes',
        category: 'Nivel 102',
        pronunciation: 'arraiv on taim',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Lo que NO funciona',
            englishExample: 'Arriving 30 minutes early (awkward) or 2 minutes late (deal-breaker).',
            pronunciation: 'araiving zerti minats erli',
            spanishExample: 'Llegar 30 min antes (incómodo) o 2 min tarde (eliminatorio).',
          ),
          ContextExample(
            emoji: '✅',
            context: 'La regla',
            englishExample: 'Arrive at the building 15 min early. Walk in 5-10 min before the time.',
            pronunciation: 'araiv at de bilding fiftin min erli',
            spanishExample: 'Llega al edificio 15 min antes. Entra 5-10 min antes de la hora.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Para entrevistas online',
            englishExample: 'Join the call 2 minutes early — test camera and audio 15 min before.',
            pronunciation: 'yoin de kol tu minats erli',
            spanishExample: 'Únete a la llamada 2 min antes — testea cámara y audio 15 min antes.',
          ),
        ],
      ),
      Phrase(
        id: 'bei2-8',
        idiom: 'What is your "first 30 seconds" line?',
        literalTranslation: 'Los primeros 30 segundos',
        realMeaning: 'Tu saludo inicial decide la primera impresión',
        category: 'Nivel 102',
        pronunciation: 'ferst zerti sekonds',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Lo que NO funciona',
            englishExample: 'A nervous: "Uhh, hi, thanks for the, uh, opportunity..."',
            pronunciation: 'a nervas hai',
            spanishExample: 'Un nervioso: "Eh, hola, gracias por la, eh, oportunidad..."',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Línea modelo',
            englishExample: '"Good morning, [Name]. Thanks for making time today — I have been looking forward to this."',
            pronunciation: 'gud morning',
            spanishExample: '"Buenos días, [Nombre]. Gracias por su tiempo hoy — estaba esperando esta entrevista."',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample: 'Confident, warm, by name — sets the tone for the next 45 minutes.',
            pronunciation: 'konfident, warm, bai neim',
            spanishExample: 'Seguro, cálido, por nombre — define el tono de los próximos 45 minutos.',
          ),
        ],
      ),
    ];
  }

  static String getDailyChallenge() {
    return '''
💼 DESAFÍO: PRIMERA IMPRESIÓN

Hoy practica frente al espejo o en video:

1️⃣ Tu apretón de manos + saludo de 30 segundos.
2️⃣ Tu postura sentada — ¿estás encorvado sin darte cuenta?
3️⃣ Grábate diciendo "Good morning, thanks for making time today" — ¿suena seguro o nervioso?

🎯 META: Que tu cuerpo diga "estoy listo" antes de que tu boca lo diga.
''';
  }
}
