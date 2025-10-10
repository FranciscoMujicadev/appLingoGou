// Archivo: lib/data/datasources/phrases_datasource.dart

import 'package:flutter/material.dart';
import '../../core/models/phrase_model.dart';
import '../../core/models/category_model.dart';
import '../../core/models/day_progress_model.dart';
import '../../../core/service/progress_service.dart';

abstract class PhrasesDataSource {
  List<CategoryModel> getCategories();
  List<Phrase> getPhrasesByCategory(String category);
  List<Phrase> getAllPhrases();
  String getDailyChallenge(String day);
  Future<Map<String, DayProgressModel>> getDaysProgress();
  Future<void> markPhraseAsUsed(String dayId, int phraseIndex);
  Future<String> getInitialDay();
  Future<void> completeDayAndUnlockNext(String currentDay);
  Future<void> confirmDayChallenge(String dayId);
}

class PhrasesDataSourceImpl implements PhrasesDataSource {
  final ProgressService _progressService = ProgressService();

  final Map<String, List<Phrase>> _phrasesByCategory = {
    'Día 1': [
      Phrase(
        id: '1-1',
        idiom: 'Hit the hay',
        literalTranslation: 'Golpear el heno',
        realMeaning: 'Irse a dormir',
        category: 'Día 1',
        pronunciation: 'jit de jei',
        contextExamples: [
          ContextExample(
            emoji: '',
            context: 'Con amigos',
            englishExample: "I'm done for today, bro. Time to hit the hay.",
            pronunciation: "aim dan for tudei, bro. taim tu jit de jei",
            spanishExample: 'Ya estuvo por hoy, bro. Es hora de dormir.',
          ),
          ContextExample(
            emoji: '',
            context: 'Con hijos',
            englishExample:
                'Time to hit the hay, champ. We have cartoons to watch tomorrow.',
            pronunciation:
                'taim tu jit de jei, champ. wi jav kartuns tu wach tumorrow',
            spanishExample:
                'Hora de dormir, campeón. Mañana tenemos caricaturas que ver.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample:
                "I'll hit the hay now, Mom. I have to wake up early.",
            pronunciation: 'ail jit de jei nau, mom. ai jav tu weik ap erli',
            spanishExample:
                'Me voy a dormir ya, mamá. Tengo que levantarme temprano.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Come on, let's hit the hay before Dad gets mad.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Vamos a dormir antes de que papá se enoje.',
          ),
        ],
      ),
      Phrase(
        id: '1-2',
        idiom: 'Rise and shine',
        literalTranslation: 'Levantarse y brillar',
        realMeaning: 'Despertarse con energía',
        category: 'Día 1',
        pronunciation: 'rais and shain',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Rise and shine, buddy! We've got plans today.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¡Arriba y a brillar, compa! Tenemos planes hoy.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: 'Rise and shine, sweetheart! Breakfast is ready.',
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¡Arriba, cariño! El desayuno está listo.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "Rise and shine, Mom! I made you coffee.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¡Arriba, mamá! Te hice café.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Rise and shine! You're gonna be late for school.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¡Levántate! Vas a llegar tarde a la escuela.',
          ),
        ],
      ),
      Phrase(
        id: '1-3',
        idiom: 'Catch some Z\'s',
        literalTranslation: 'Atrapar algunas Z',
        realMeaning: 'Dormir un poco',
        category: 'Día 1',
        pronunciation: 'kach som zis',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "I need to catch some Z's before the party.",
            pronunciation: '',
            spanishExample: 'Necesito dormir un poco antes de la fiesta.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: 'Go catch some Z\'s, you look tired.',
            pronunciation: '',
            spanishExample: 'Ve a dormir un rato, te ves cansado.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I'm going to catch some Z's before dinner, Dad.",
            pronunciation: '',
            spanishExample: 'Voy a dormir un rato antes de la cena, papá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Let me catch some Z's, I'm exhausted.",
            pronunciation: '',
            spanishExample: 'Déjame dormir, estoy agotado.',
          ),
        ],
      ),
      Phrase(
        id: '1-4',
        idiom: 'Sleep like a log',
        literalTranslation: 'Dormir como un tronco',
        realMeaning: 'Dormir profundamente',
        category: 'Día 1',
        pronunciation: 'slip laik a log',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "I slept like a log after the gym yesterday.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Dormí como bebé después del gym ayer.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: 'Did you sleep like a log last night?',
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¿Dormiste profundo anoche?',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I slept like a log, Mom. That bed is so comfy.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Dormí súper bien, mamá. Esa cama está muy cómoda.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "You were snoring! You slept like a log.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¡Estabas roncando! Dormiste profundísimo.',
          ),
        ],
      ),
      Phrase(
        id: '1-5',
        idiom: 'Call it a day',
        literalTranslation: 'Llamarlo un día',
        realMeaning: 'Terminar el trabajo por hoy',
        category: 'Día 1',
        pronunciation: 'kol it a dei',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Let's call it a day and grab some beers.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Terminemos por hoy y vamos por unas chelas.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "You've done enough homework. Let's call it a day.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Ya hiciste suficiente tarea. Terminemos por hoy.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I'm calling it a day, Dad. I'm too tired.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Ya termino por hoy, papá. Estoy muy cansado.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Let's call it a day and play video games.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Ya terminemos y juguemos videojuegos.',
          ),
        ],
      ),
      Phrase(
        id: '1-6',
        idiom: 'Burn the midnight oil',
        literalTranslation: 'Quemar el aceite de medianoche',
        realMeaning: 'Trabajar hasta tarde en la noche',
        category: 'Día 1',
        pronunciation: 'bern de midnait oil',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample:
                "I had to burn the midnight oil to finish that project.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Tuve que desvelarme para terminar ese proyecto.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample:
                "Don't burn the midnight oil studying. You need rest.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'No te desveles estudiando. Necesitas descansar.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample:
                "I'm burning the midnight oil tonight, Mom. Big exam tomorrow.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample:
                'Me voy a desvelar hoy, mamá. Examen importante mañana.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Stop burning the midnight oil. It's not healthy.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Deja de desvelarte. No es saludable.',
          ),
        ],
      ),
      Phrase(
        id: '1-7',
        idiom: 'Early bird catches the worm',
        literalTranslation: 'El pájaro madrugador atrapa el gusano',
        realMeaning: 'Quien madruga tiene ventaja',
        category: 'Día 1',
        pronunciation: 'erli berd kaches de werm',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample:
                "Early bird catches the worm! Let's go to the gym now.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample:
                '¡Al que madruga Dios le ayuda! Vamos al gym ahora.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample:
                "Early bird catches the worm, kiddo. Time to wake up!",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample:
                'El que madruga tiene ventaja, campeón. ¡Hora de levantarse!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "You're right, Dad. Early bird catches the worm.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Tienes razón, papá. Al que madruga Dios le ayuda.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample:
                "Early bird catches the worm! Get up, we'll miss the sale.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample:
                '¡Al que madruga! Levántate, nos perdemos la oferta.',
          ),
        ],
      ),
      Phrase(
        id: '1-8',
        idiom: 'Hit the sack',
        literalTranslation: 'Golpear el saco',
        realMeaning: 'Irse a la cama',
        category: 'Día 1',
        pronunciation: 'jit de sak',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "I'm gonna hit the sack, bro. See you tomorrow.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Me voy a dormir, bro. Te veo mañana.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Time to hit the sack, little one. Sweet dreams.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Hora de ir a la cama, pequeño. Dulces sueños.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I'm hitting the sack now, Mom. Good night!",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Ya me voy a dormir, mamá. ¡Buenas noches!',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Let's hit the sack. We have school tomorrow.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Vámonos a dormir. Mañana hay escuela.',
          ),
        ],
      ),
    ],
    'Día 2': [
      Phrase(
        id: '2-1',
        idiom: 'Piece of cake',
        literalTranslation: 'Pedazo de pastel',
        realMeaning: 'Muy fácil',
        category: 'Día 2',
        pronunciation: 'pis of keik',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "That exam was a piece of cake!",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¡Ese examen estuvo facilísimo!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Don't worry, it'll be a piece of cake.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'No te preocupes, va a estar muy fácil.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "The interview was a piece of cake, Mom!",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¡La entrevista estuvo facilísima, mamá!',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Fixing this? Piece of cake for me.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¿Arreglar esto? Pan comido para mí.',
          ),
        ],
      ),
      Phrase(
        id: '2-2',
        idiom: 'Spill the beans',
        literalTranslation: 'Derramar los frijoles',
        realMeaning: 'Revelar un secreto',
        category: 'Día 2',
        pronunciation: 'spil de bins',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Come on, spill the beans! What happened?",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¡Anda, suelta la sopa! ¿Qué pasó?',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample:
                "Did your brother spill the beans about the surprise?",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¿Tu hermano ya reveló la sorpresa?',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I won't spill the beans, Mom. I promise!",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'No voy a decir el secreto, mamá. ¡Lo prometo!',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Don't spill the beans about Dad's gift!",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¡No digas nada del regalo de papá!',
          ),
        ],
      ),
      Phrase(
        id: '2-3',
        idiom: 'Break the ice',
        literalTranslation: 'Romper el hielo',
        realMeaning: 'Iniciar una conversación incómoda',
        category: 'Día 2',
        pronunciation: 'breik de ais',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Let me break the ice with a joke.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Déjame romper el hielo con un chiste.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Just say hi to break the ice!",
            pronunciation: '',
            spanishExample: '¡Solo di hola para romper el hielo!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "Thanks for breaking the ice, Dad.",
            pronunciation: '',
            spanishExample: 'Gracias por romper el hielo, papá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Can you break the ice? I'm too nervous.",
            pronunciation: '',
            spanishExample: '¿Puedes romper el hielo? Estoy muy nervioso.',
          ),
        ],
      ),
      Phrase(
        id: '2-4',
        idiom: 'Cost an arm and a leg',
        literalTranslation: 'Costar un brazo y una pierna',
        realMeaning: 'Ser muy caro',
        category: 'Día 2',
        pronunciation: 'kost an arm and a leg',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "That new phone costs an arm and a leg!",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: '¡Ese teléfono nuevo cuesta un ojo de la cara!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Those toys cost an arm and a leg, sweetie.",
            pronunciation: 'kom on, lets jit de jei bifor dad gets mad',
            spanishExample: 'Esos juguetes cuestan carísimo, cariño.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "College costs an arm and a leg, Mom.",
            pronunciation: '',
            spanishExample: 'La universidad cuesta un ojo de la cara, mamá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Those sneakers cost an arm and a leg.",
            pronunciation: '',
            spanishExample: 'Esos tenis cuestan carísimo.',
          ),
        ],
      ),
      Phrase(
        id: '2-5',
        idiom: 'Under the weather',
        literalTranslation: 'Bajo el clima',
        realMeaning: 'Sentirse mal o enfermo',
        category: 'Día 2',
        pronunciation: 'ander de weder',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "I'm feeling under the weather today, bro.",
            pronunciation: '',
            spanishExample: 'Me siento mal hoy, bro.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Are you feeling under the weather, honey?",
            pronunciation: '',
            spanishExample: '¿Te sientes mal, cariño?',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I'm a bit under the weather, Mom. Can I rest?",
            pronunciation: '',
            spanishExample: 'Me siento un poco mal, mamá. ¿Puedo descansar?',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "You look under the weather. Want some tea?",
            pronunciation: '',
            spanishExample: 'Te ves mal. ¿Quieres un té?',
          ),
        ],
      ),
      Phrase(
        id: '2-6',
        idiom: 'Once in a blue moon',
        literalTranslation: 'Una vez en una luna azul',
        realMeaning: 'Muy raramente',
        category: 'Día 2',
        pronunciation: 'wans in a blu mun',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "I only see him once in a blue moon.",
            pronunciation: '',
            spanishExample: 'Solo lo veo de vez en cuando.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "We go to the beach once in a blue moon.",
            pronunciation: '',
            spanishExample: 'Vamos a la playa muy de vez en cuando.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I eat fast food once in a blue moon, Dad.",
            pronunciation: '',
            spanishExample: 'Como comida rápida muy raramente, papá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "You clean your room once in a blue moon!",
            pronunciation: '',
            spanishExample: '¡Limpias tu cuarto de vez en nunca!',
          ),
        ],
      ),
      Phrase(
        id: '2-7',
        idiom: 'Let the cat out of the bag',
        literalTranslation: 'Dejar salir al gato de la bolsa',
        realMeaning: 'Revelar un secreto accidentalmente',
        category: 'Día 2',
        pronunciation: 'let de kat aut of de bag',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample:
                "Oops, I let the cat out of the bag about the party.",
            pronunciation: '',
            spanishExample: 'Ups, se me salió lo de la fiesta.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Don't let the cat out of the bag about Santa!",
            pronunciation: '',
            spanishExample: '¡No digas el secreto de Santa!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "Sorry, Mom. I let the cat out of the bag.",
            pronunciation: '',
            spanishExample: 'Perdón, mamá. Se me escapó el secreto.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "You let the cat out of the bag! Dad knows now.",
            pronunciation: '',
            spanishExample: '¡Soltaste la sopa! Papá ya sabe.',
          ),
        ],
      ),
      Phrase(
        id: '2-8',
        idiom: 'Bite the bullet',
        literalTranslation: 'Morder la bala',
        realMeaning: 'Enfrentar algo difícil con valentía',
        category: 'Día 2',
        pronunciation: 'bait de bulet',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "I had to bite the bullet and tell her the truth.",
            pronunciation: '',
            spanishExample: 'Tuve que armarse de valor y decirle la verdad.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Sometimes you need to bite the bullet, kiddo.",
            pronunciation: '',
            spanishExample: 'A veces tienes que ser valiente, campeón.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I'll bite the bullet and talk to my boss, Dad.",
            pronunciation: '',
            spanishExample:
                'Voy a armarse de valor y hablar con mi jefe, papá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Just bite the bullet and do it!",
            pronunciation: '',
            spanishExample: '¡Solo hazlo de una vez!',
          ),
        ],
      ),
    ],
    'Día 3': [
      Phrase(
        id: '3-1',
        idiom: 'Break a leg',
        literalTranslation: 'Rómpete una pierna',
        realMeaning: 'Buena suerte',
        category: 'Día 3',
        pronunciation: 'breik a leg',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Break a leg on your presentation, buddy!",
            pronunciation: '',
            spanishExample: '¡Mucha suerte en tu presentación, compa!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Break a leg at your game today!",
            pronunciation: '',
            spanishExample: '¡Mucha suerte en tu juego hoy!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "Thanks, Mom! Break a leg at work too!",
            pronunciation: '',
            spanishExample: '¡Gracias, mamá! ¡Suerte en el trabajo también!',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Break a leg on your exam tomorrow!",
            pronunciation: '',
            spanishExample: '¡Suerte en tu examen mañana!',
          ),
        ],
      ),
      Phrase(
        id: '3-2',
        idiom: 'When pigs fly',
        literalTranslation: 'Cuando los cerdos vuelen',
        realMeaning: 'Nunca va a pasar',
        category: 'Día 3',
        pronunciation: 'wen pigs flai',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "He'll pay me back when pigs fly!",
            pronunciation: '',
            spanishExample: '¡Me va a pagar cuando las vacas vuelen!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "You'll clean your room? When pigs fly!",
            pronunciation: '',
            spanishExample:
                '¿Vas a limpiar tu cuarto? ¡Cuando las ranas críen pelo!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "Dad will dance? When pigs fly!",
            pronunciation: '',
            spanishExample: '¿Papá va a bailar? ¡Nunca!',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "You'll wake up early? When pigs fly!",
            pronunciation: '',
            spanishExample: '¿Te vas a despertar temprano? ¡Eso nunca!',
          ),
        ],
      ),
      Phrase(
        id: '3-3',
        idiom: 'Get cold feet',
        literalTranslation: 'Tener pies fríos',
        realMeaning: 'Acobardarse en el último momento',
        category: 'Día 3',
        pronunciation: 'get kold fit',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Don't get cold feet now! You can do this.",
            pronunciation: '',
            spanishExample: '¡No te acobardes ahora! Tú puedes.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "It's okay if you get cold feet. We can try later.",
            pronunciation: '',
            spanishExample:
                'Está bien si te da miedo. Podemos intentar después.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I'm getting cold feet about the interview, Mom.",
            pronunciation: '',
            spanishExample: 'Me está dando miedo la entrevista, mamá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Don't get cold feet! Just ask her out.",
            pronunciation: '',
            spanishExample: '¡No te acobardes! Solo invítala.',
          ),
        ],
      ),
      Phrase(
        id: '3-4',
        idiom: 'Barking up the wrong tree',
        literalTranslation: 'Ladrando al árbol equivocado',
        realMeaning: 'Buscar en el lugar equivocado',
        category: 'Día 3',
        pronunciation: 'barkin ap de rong tri',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample:
                "If you think I ate your pizza, you're barking up the wrong tree.",
            pronunciation: '',
            spanishExample:
                'Si crees que me comí tu pizza, estás buscando en el lugar equivocado.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample:
                "You're barking up the wrong tree. Your sister took it.",
            pronunciation: '',
            spanishExample:
                'Estás buscando en el lugar equivocado. Tu hermana lo tomó.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample:
                "You're barking up the wrong tree, Dad. I didn't do it.",
            pronunciation: '',
            spanishExample: 'Te estás equivocando, papá. Yo no fui.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "You're barking up the wrong tree. Check his room.",
            pronunciation: '',
            spanishExample: 'Estás buscando mal. Revisa su cuarto.',
          ),
        ],
      ),
      Phrase(
        id: '3-5',
        idiom: 'The ball is in your court',
        literalTranslation: 'La pelota está en tu cancha',
        realMeaning: 'Es tu turno de decidir o actuar',
        category: 'Día 3',
        pronunciation: 'de bol is in ior kort',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "I made my offer. The ball is in your court now.",
            pronunciation: '',
            spanishExample: 'Ya hice mi oferta. Ahora te toca a ti.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "You decide what to do. The ball is in your court.",
            pronunciation: '',
            spanishExample: 'Tú decides qué hacer. La decisión es tuya.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample:
                "I applied everywhere, Mom. The ball is in their court.",
            pronunciation: '',
            spanishExample:
                'Ya apliqué a todos lados, mamá. Ahora depende de ellos.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "I said I'm sorry. The ball is in your court.",
            pronunciation: '',
            spanishExample: 'Ya pedí perdón. Ahora tú decides.',
          ),
        ],
      ),
      Phrase(
        id: '3-6',
        idiom: 'Cut to the chase',
        literalTranslation: 'Cortar a la persecución',
        realMeaning: 'Ir al grano',
        category: 'Día 3',
        pronunciation: 'kat tu de cheis',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Let's cut to the chase. Do you like her or not?",
            pronunciation: '',
            spanishExample: 'Vamos al grano. ¿Te gusta o no?',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Cut to the chase. What do you want?",
            pronunciation: '',
            spanishExample: 'Ve al grano. ¿Qué quieres?',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "Okay, Dad. Let me cut to the chase. I need help.",
            pronunciation: '',
            spanishExample: 'Okay, papá. Voy al grano. Necesito ayuda.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Cut to the chase! Did you break my laptop?",
            pronunciation: '',
            spanishExample: '¡Ve al grano! ¿Rompiste mi laptop?',
          ),
        ],
      ),
      Phrase(
        id: '3-7',
        idiom: 'Hit the nail on the head',
        literalTranslation: 'Golpear el clavo en la cabeza',
        realMeaning: 'Dar en el clavo, acertar exactamente',
        category: 'Día 3',
        pronunciation: 'jit de neil on de jed',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample:
                "You hit the nail on the head! That's exactly the problem.",
            pronunciation: '',
            spanishExample:
                '¡Diste en el clavo! Ese es exactamente el problema.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "You hit the nail on the head! Good thinking!",
            pronunciation: '',
            spanishExample: '¡Le atinaste! ¡Bien pensado!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample:
                "You hit the nail on the head, Mom. That's how I feel.",
            pronunciation: '',
            spanishExample: 'Diste en el clavo, mamá. Así es como me siento.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample:
                "Wow, you hit the nail on the head with that guess!",
            pronunciation: '',
            spanishExample: '¡Wow, le atinaste con esa adivinanza!',
          ),
        ],
      ),
      Phrase(
        id: '3-8',
        idiom: 'On cloud nine',
        literalTranslation: 'En la nube nueve',
        realMeaning: 'Estar extremadamente feliz',
        category: 'Día 3',
        pronunciation: 'on klaud nain',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "I'm on cloud nine! She said yes!",
            pronunciation: '',
            spanishExample: '¡Estoy en las nubes! ¡Ella dijo que sí!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "You look on cloud nine today! What happened?",
            pronunciation: '',
            spanishExample: '¡Te ves súper feliz hoy! ¿Qué pasó?',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I'm on cloud nine, Mom! I got the job!",
            pronunciation: '',
            spanishExample: '¡Estoy felicísimo, mamá! ¡Conseguí el trabajo!',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample:
                "He's been on cloud nine since he got that new bike.",
            pronunciation: '',
            spanishExample:
                'Ha estado súper feliz desde que le dieron esa bici nueva.',
          ),
        ],
      ),
    ],
    'Día 4': [
      Phrase(
        id: '4-1',
        idiom: 'Best of both worlds',
        literalTranslation: 'Lo mejor de ambos mundos',
        realMeaning: 'Tener todas las ventajas',
        category: 'Día 4',
        pronunciation: 'best of boz werlds',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Working from home? Best of both worlds, man!",
            pronunciation: '',
            spanishExample: '¿Trabajar desde casa? ¡Lo mejor de todo, compa!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "You get the best of both worlds with that game!",
            pronunciation: '',
            spanishExample: '¡Tienes lo mejor de todo con ese juego!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "This job gives me the best of both worlds, Dad.",
            pronunciation: '',
            spanishExample: 'Este trabajo me da lo mejor de ambos, papá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Living here is the best of both worlds!",
            pronunciation: '',
            spanishExample: '¡Vivir aquí es tener lo mejor de todo!',
          ),
        ],
      ),
      Phrase(
        id: '4-2',
        idiom: 'Back to square one',
        literalTranslation: 'De vuelta al cuadro uno',
        realMeaning: 'Volver a empezar desde el principio',
        category: 'Día 4',
        pronunciation: 'bak tu skwer wan',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "The plan failed. We're back to square one.",
            pronunciation: '',
            spanishExample: 'El plan falló. Volvemos a empezar.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Oops! Back to square one. Let's try again.",
            pronunciation: '',
            spanishExample: '¡Ups! De vuelta al inicio. Intentemos otra vez.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I'm back to square one with my project, Mom.",
            pronunciation: '',
            spanishExample: 'Estoy de vuelta al inicio con mi proyecto, mamá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "We lost the file. Back to square one!",
            pronunciation: '',
            spanishExample: 'Perdimos el archivo. ¡De vuelta a empezar!',
          ),
        ],
      ),
      Phrase(
        id: '4-3',
        idiom: 'Beat around the bush',
        literalTranslation: 'Golpear alrededor del arbusto',
        realMeaning: 'Evitar ir al punto directamente',
        category: 'Día 4',
        pronunciation: 'bit araund de bush',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Stop beating around the bush. Just tell me!",
            pronunciation: '',
            spanishExample: '¡Deja de dar rodeos! ¡Solo dime!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Don't beat around the bush. What do you want?",
            pronunciation: '',
            spanishExample: 'No des vueltas. ¿Qué quieres?',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I won't beat around the bush, Dad. I need money.",
            pronunciation: '',
            spanishExample: 'No voy a dar rodeos, papá. Necesito dinero.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample:
                "Stop beating around the bush! Did you eat my food?",
            pronunciation: '',
            spanishExample: '¡Deja de dar vueltas! ¿Te comiste mi comida?',
          ),
        ],
      ),
      Phrase(
        id: '4-4',
        idiom: 'Blessing in disguise',
        literalTranslation: 'Bendición disfrazada',
        realMeaning: 'Algo malo que resulta ser bueno',
        category: 'Día 4',
        pronunciation: 'blesin in disgais',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Losing that job was a blessing in disguise.",
            pronunciation: '',
            spanishExample: 'Perder ese trabajo fue una bendición disfrazada.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "It might be a blessing in disguise, sweetie.",
            pronunciation: '',
            spanishExample: 'Puede que sea una bendición disfrazada, cariño.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample:
                "You were right, Mom. It was a blessing in disguise.",
            pronunciation: '',
            spanishExample: 'Tenías razón, mamá. Fue una bendición disfrazada.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "That breakup was a blessing in disguise.",
            pronunciation: '',
            spanishExample: 'Esa ruptura fue algo bueno al final.',
          ),
        ],
      ),
      Phrase(
        id: '4-5',
        idiom: 'Miss the boat',
        literalTranslation: 'Perder el barco',
        realMeaning: 'Perder una oportunidad',
        category: 'Día 4',
        pronunciation: 'mis de bout',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Hurry up or you'll miss the boat!",
            pronunciation: '',
            spanishExample: '¡Apúrate o perderás la oportunidad!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Don't miss the boat on this chance!",
            pronunciation: '',
            spanishExample: '¡No pierdas esta oportunidad!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I think I missed the boat, Dad.",
            pronunciation: '',
            spanishExample: 'Creo que perdí la oportunidad, papá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "You missed the boat! The sale ended yesterday.",
            pronunciation: '',
            spanishExample: '¡Perdiste la oportunidad! La oferta terminó ayer.',
          ),
        ],
      ),
      Phrase(
        id: '4-6',
        idiom: 'See eye to eye',
        literalTranslation: 'Ver ojo a ojo',
        realMeaning: 'Estar de acuerdo',
        category: 'Día 4',
        pronunciation: 'si ai tu ai',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample:
                "We don't always see eye to eye, but we're friends.",
            pronunciation: '',
            spanishExample: 'No siempre estamos de acuerdo, pero somos amigos.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "We need to see eye to eye on this.",
            pronunciation: '',
            spanishExample: 'Necesitamos estar de acuerdo en esto.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I know we don't see eye to eye, Mom.",
            pronunciation: '',
            spanishExample: 'Sé que no estamos de acuerdo, mamá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Finally, we see eye to eye on something!",
            pronunciation: '',
            spanishExample: '¡Finalmente estamos de acuerdo en algo!',
          ),
        ],
      ),
      Phrase(
        id: '4-7',
        idiom: 'The last straw',
        literalTranslation: 'La última paja',
        realMeaning: 'La gota que derramó el vaso',
        category: 'Día 4',
        pronunciation: 'de last stro',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "That was the last straw! I'm done with him.",
            pronunciation: '',
            spanishExample:
                '¡Esa fue la gota que derramó el vaso! Ya no más con él.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "This is the last straw! No more video games!",
            pronunciation: '',
            spanishExample: '¡Esto es el colmo! ¡No más videojuegos!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "That was the last straw, Mom. I'm quitting.",
            pronunciation: '',
            spanishExample:
                'Esa fue la gota que derramó el vaso, mamá. Renuncio.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "That's the last straw! Give me back my stuff!",
            pronunciation: '',
            spanishExample: '¡Eso es el colmo! ¡Devuélveme mis cosas!',
          ),
        ],
      ),
      Phrase(
        id: '4-8',
        idiom: 'Pull yourself together',
        literalTranslation: 'Jálate a ti mismo juntos',
        realMeaning: 'Cálmate y contrólate',
        category: 'Día 4',
        pronunciation: 'pul iorself tugeder',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Pull yourself together, man! You got this!",
            pronunciation: '',
            spanishExample: '¡Cálmate, compa! ¡Tú puedes!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Pull yourself together. It's just a small cut.",
            pronunciation: '',
            spanishExample: 'Cálmate. Es solo un cortecito.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample:
                "I need to pull myself together before the interview.",
            pronunciation: '',
            spanishExample: 'Necesito calmarme antes de la entrevista.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Pull yourself together! Stop crying over that!",
            pronunciation: '',
            spanishExample: '¡Contrólate! ¡Deja de llorar por eso!',
          ),
        ],
      ),
    ],
    'Día 5': [
      Phrase(
        id: '5-1',
        idiom: 'Go the extra mile',
        literalTranslation: 'Ir la milla extra',
        realMeaning: 'Esforzarse más de lo necesario',
        category: 'Día 5',
        pronunciation: 'gou de extra mail',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "He always goes the extra mile to help us.",
            pronunciation: '',
            spanishExample: 'Él siempre se esfuerza de más para ayudarnos.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "You went the extra mile on this project!",
            pronunciation: '',
            spanishExample: '¡Te esforzaste mucho en este proyecto!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I want to go the extra mile at work, Mom.",
            pronunciation: '',
            spanishExample: 'Quiero esforzarme más en el trabajo, mamá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Thanks for going the extra mile for me!",
            pronunciation: '',
            spanishExample: '¡Gracias por esforzarte tanto por mí!',
          ),
        ],
      ),
      Phrase(
        id: '5-2',
        idiom: 'Keep your chin up',
        literalTranslation: 'Mantén tu barbilla arriba',
        realMeaning: 'Mantente positivo',
        category: 'Día 5',
        pronunciation: 'kip ior chin ap',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Keep your chin up, buddy! Things will get better.",
            pronunciation: '',
            spanishExample: '¡Mantente positivo, compa! Las cosas mejorarán.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Keep your chin up! You'll do better next time.",
            pronunciation: '',
            spanishExample: '¡No te desanimes! Lo harás mejor la próxima.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "Thanks, Dad. I'll try to keep my chin up.",
            pronunciation: '',
            spanishExample: 'Gracias, papá. Trataré de mantenerme positivo.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Keep your chin up! You passed the test!",
            pronunciation: '',
            spanishExample: '¡Anímate! ¡Pasaste el examen!',
          ),
        ],
      ),
      Phrase(
        id: '5-3',
        idiom: 'Hang in there',
        literalTranslation: 'Cuelga ahí',
        realMeaning: 'No te rindas, aguanta',
        category: 'Día 5',
        pronunciation: 'jang in der',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Hang in there, man! Just one more week!",
            pronunciation: '',
            spanishExample: '¡Aguanta, compa! ¡Solo una semana más!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Hang in there! We're almost home.",
            pronunciation: '',
            spanishExample: '¡Aguanta! Ya casi llegamos a casa.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "I'm trying to hang in there, Mom.",
            pronunciation: '',
            spanishExample: 'Estoy tratando de aguantar, mamá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Hang in there! You're doing great!",
            pronunciation: '',
            spanishExample: '¡Aguanta! ¡Lo estás haciendo genial!',
          ),
        ],
      ),
      Phrase(
        id: '5-4',
        idiom: 'Speak of the devil',
        literalTranslation: 'Hablar del diablo',
        realMeaning: 'Hablando del rey de Roma',
        category: 'Día 5',
        pronunciation: 'spik of de devil',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample:
                "Speak of the devil! We were just talking about you!",
            pronunciation: '',
            spanishExample:
                '¡Hablando del rey de Roma! ¡Justo hablábamos de ti!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Speak of the devil! Here you are!",
            pronunciation: '',
            spanishExample: '¡Hablando del rey de Roma! ¡Aquí estás!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "Speak of the devil, Mom! Dad just texted.",
            pronunciation: '',
            spanishExample:
                '¡Hablando del rey de Roma, mamá! Papá acaba de escribir.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Speak of the devil! I was calling you!",
            pronunciation: '',
            spanishExample: '¡Hablando de ti! ¡Te estaba llamando!',
          ),
        ],
      ),
      Phrase(
        id: '5-5',
        idiom: 'The whole nine yards',
        literalTranslation: 'Las nueve yardas completas',
        realMeaning: 'Todo completo, sin excepción',
        category: 'Día 5',
        pronunciation: 'de joul nain yards',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample:
                "He got a new car, new house, the whole nine yards!",
            pronunciation: '',
            spanishExample:
                '¡Consiguió carro nuevo, casa nueva, todo completo!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample:
                "We're doing the whole nine yards for your birthday!",
            pronunciation: '',
            spanishExample: '¡Vamos a hacer todo por tu cumpleaños!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample:
                "She got the promotion, raise, the whole nine yards!",
            pronunciation: '',
            spanishExample: '¡Consiguió el ascenso, aumento, todo!',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample:
                "He went all out - decorations, food, the whole nine yards!",
            pronunciation: '',
            spanishExample: '¡Se lució - decoraciones, comida, todo!',
          ),
        ],
      ),
      Phrase(
        id: '5-6',
        idiom: 'Time flies',
        literalTranslation: 'El tiempo vuela',
        realMeaning: 'El tiempo pasa rápido',
        category: 'Día 5',
        pronunciation: 'taim flais',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Wow, time flies! It's already midnight!",
            pronunciation: '',
            spanishExample: '¡Wow, el tiempo vuela! ¡Ya es medianoche!',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Time flies when you're having fun!",
            pronunciation: '',
            spanishExample: '¡El tiempo vuela cuando te diviertes!',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "Time flies, Mom. I can't believe I'm graduating!",
            pronunciation: '',
            spanishExample:
                'El tiempo vuela, mamá. ¡No puedo creer que me gradúo!',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Time flies! Remember when we were kids?",
            pronunciation: '',
            spanishExample: '¡El tiempo vuela! ¿Recuerdas cuando éramos niños?',
          ),
        ],
      ),
      Phrase(
        id: '5-7',
        idiom: 'Up in the air',
        literalTranslation: 'Arriba en el aire',
        realMeaning: 'Incierto, sin decidir',
        category: 'Día 5',
        pronunciation: 'ap in de er',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "Our plans are still up in the air.",
            pronunciation: '',
            spanishExample: 'Nuestros planes todavía están en el aire.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "The trip is up in the air right now.",
            pronunciation: '',
            spanishExample: 'El viaje está en el aire por ahora.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "My job situation is up in the air, Dad.",
            pronunciation: '',
            spanishExample: 'Mi situación laboral está incierta, papá.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "Everything is up in the air right now.",
            pronunciation: '',
            spanishExample: 'Todo está incierto ahorita.',
          ),
        ],
      ),
      Phrase(
        id: '5-8',
        idiom: 'Weather the storm',
        literalTranslation: 'Capear la tormenta',
        realMeaning: 'Superar una situación difícil',
        category: 'Día 5',
        pronunciation: 'weder de storm',
        contextExamples: [
          ContextExample(
            emoji: '👬',
            context: 'Con amigos',
            englishExample: "We'll weather the storm together, bro.",
            pronunciation: '',
            spanishExample: 'Superaremos esta tormenta juntos, bro.',
          ),
          ContextExample(
            emoji: '👶',
            context: 'Con hijos',
            englishExample: "Don't worry, we'll weather the storm.",
            pronunciation: '',
            spanishExample: 'No te preocupes, superaremos esto.',
          ),
          ContextExample(
            emoji: '👨‍👩‍👦',
            context: 'Con papás',
            englishExample: "We weathered the storm, Mom. We're okay now.",
            pronunciation: '',
            spanishExample: 'Superamos la tormenta, mamá. Ya estamos bien.',
          ),
          ContextExample(
            emoji: '🧑‍🤝‍🧑',
            context: 'Con hermanos',
            englishExample: "We've weathered worse storms than this!",
            pronunciation: '',
            spanishExample: '¡Hemos superado tormentas peores que esta!',
          ),
        ],
      ),
    ],
  };

  final Map<String, String> _dailyChallenges = {
    'Día 1': '''
🎯 DESAFÍO DEL DÍA 1 - Rutina y Sueño

¡Felicidades por aprender 8 idioms sobre rutina diaria! Ahora es momento de practicar.

📝 TU RETO: Usa cada idiom AL MENOS UNA VEZ hoy

💡 EJEMPLOS DE USO:

- "Hit the hay" → Díselo a tu familia antes de dormir
- "Rise and shine" → Despierta a alguien con energía
- "Catch some Z's" → Menciona que necesitas dormir
- "Sleep like a log" → Cuenta cómo dormiste
- "Call it a day" → Termina tu trabajo y dilo
- "Burn the midnight oil" → Habla de trabajar tarde
- "Early bird catches the worm" → Motiva a alguien
- "Hit the sack" → Despídete antes de dormir

✅ Marca cada idiom cuando lo uses en la vida real
🔓 Completa todas para desbloquear el Día 2
''',
    'Día 2': '''
🎯 DESAFÍO DEL DÍA 2 - Situaciones Cotidianas

¡Excelente progreso! Hoy practicarás idioms de uso común.

📝 TU RETO: Usa cada idiom AL MENOS UNA VEZ hoy

💡 EJEMPLOS DE USO:

- "Piece of cake" → Comenta algo fácil
- "Spill the beans" → Habla de revelar secretos
- "Break the ice" → Inicia una conversación
- "Cost an arm and a leg" → Habla de algo caro
- "Under the weather" → Menciona cómo te sientes
- "Once in a blue moon" → Describe algo raro
- "Let the cat out of the bag" → Cuenta un secreto
- "Bite the bullet" → Enfrenta algo difícil

✅ Marca cada idiom cuando lo uses en la vida real
🔓 Completa todas para desbloquear el Día 3
''',
    'Día 3': '''
🎯 DESAFÍO DEL DÍA 3 - Expresiones y Emociones

¡Vas muy bien! Hoy practicarás expresiones emocionales.

📝 TU RETO: Usa cada idiom AL MENOS UNA VEZ hoy

💡 EJEMPLOS DE USO:

- "Break a leg" → Desea suerte a alguien
- "When pigs fly" → Habla de algo imposible
- "Get cold feet" → Menciona nervios
- "Barking up the wrong tree" → Corrige a alguien
- "The ball is in your court" → Da turno a otro
- "Cut to the chase" → Ve directo al punto
- "Hit the nail on the head" → Reconoce un acierto
- "On cloud nine" → Expresa felicidad

✅ Marca cada idiom cuando lo uses en la vida real
🔓 Completa todas para desbloquear el Día 4
''',
    'Día 4': '''
🎯 DESAFÍO DEL DÍA 4 - Relaciones y Decisiones

¡Impresionante! Hoy practicarás idioms de situaciones sociales.

📝 TU RETO: Usa cada idiom AL MENOS UNA VEZ hoy

💡 EJEMPLOS DE USO:

- "Best of both worlds" → Habla de ventajas
- "Back to square one" → Menciona reiniciar
- "Beat around the bush" → Pide ir al grano
- "Blessing in disguise" → Encuentra lo positivo
- "Miss the boat" → Habla de oportunidades
- "See eye to eye" → Menciona acuerdos
- "The last straw" → Expresa tu límite
- "Pull yourself together" → Anima a alguien

✅ Marca cada idiom cuando lo uses en la vida real
🔓 Completa todas para desbloquear el Día 5
''',
    'Día 5': '''
🎯 DESAFÍO DEL DÍA 5 - Motivación y Vida

¡Último día! Hoy practicarás idioms motivacionales.

📝 TU RETO: Usa cada idiom AL MENOS UNA VEZ hoy

💡 EJEMPLOS DE USO:

- "Go the extra mile" → Reconoce esfuerzos
- "Keep your chin up" → Anima a alguien
- "Hang in there" → Motiva a perseverar
- "Speak of the devil" → Usa al llegar alguien
- "The whole nine yards" → Habla de hacer todo
- "Time flies" → Comenta el paso del tiempo
- "Up in the air" → Menciona incertidumbre
- "Weather the storm" → Habla de superar

✅ Marca cada idiom cuando lo uses en la vida real

🎉 ¡FELICIDADES! Completaste tu primera semana aprendiendo idioms
''',
  };

  @override
  List<CategoryModel> getCategories() {
    return const [
      CategoryModel(name: 'Día 1', icon: Icons.looks_one),
      CategoryModel(name: 'Día 2', icon: Icons.looks_two),
      CategoryModel(name: 'Día 3', icon: Icons.looks_3),
      CategoryModel(name: 'Día 4', icon: Icons.looks_4),
      CategoryModel(name: 'Día 5', icon: Icons.looks_5),
    ];
  }

  @override
  List<Phrase> getPhrasesByCategory(String category) {
    return _phrasesByCategory[category] ?? [];
  }

  @override
  List<Phrase> getAllPhrases() {
    return _phrasesByCategory.values.expand((phrases) => phrases).toList();
  }

  @override
  String getDailyChallenge(String day) {
    return _dailyChallenges[day] ??
        'Practica los idioms de hoy en situaciones reales.';
  }

  @override
  Future<Map<String, DayProgressModel>> getDaysProgress() async {
    return await _progressService.getProgress();
  }

  @override
  Future<void> markPhraseAsUsed(String dayId, int phraseIndex) async {
    await _progressService.markPhraseAsUsed(dayId, phraseIndex);
  }

  @override
  Future<String> getInitialDay() async {
    return await _progressService.getFirstUnlockedDay();
  }

  @override
  Future<void> completeDayAndUnlockNext(String currentDay) async {
    await _progressService.completeDayAndUnlockNext(currentDay);
  }

  @override
  Future<void> confirmDayChallenge(String dayId) async {
    await _progressService.confirmDayChallenge(dayId);
  }
}
