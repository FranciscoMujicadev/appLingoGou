import '../models/story_model.dart';

class StoriesData {
  static final List<StoryModel> _allStories = [
    // ===== BEGINNER STORIES (7 historias) =====
    StoryModel(
      id: 1,
      title: "My Day",
      level: "Beginner",
      content:
          """I wake up in the morning and I feel happy. I get up from my bed and I go to the kitchen. I am hungry so I eat some bread and I drink milk. The bread is good and the milk is cold. I like my breakfast very much.

After I eat, I look at the window and I see the sun. The sun is big and yellow. I see some birds in the sky and they are flying. The birds are singing and I can hear them. I smile because it is a nice day.

I am ready to start my day and I feel good. I think today is going to be a great day for me.""",
      contentSpanish:
          """Me despierto en la mañana y me siento feliz. Me levanto de mi cama y voy a la cocina. Tengo hambre así que como pan y bebo leche. El pan es bueno y la leche está fría. Me gusta mucho mi desayuno.

Después de comer, miro por la ventana y veo el sol. El sol es grande y amarillo. Veo algunos pájaros en el cielo y están volando. Los pájaros están cantando y puedo escucharlos. Sonrío porque es un día bonito.

Estoy listo para empezar mi día y me siento bien. Creo que hoy va a ser un gran día para mí.""",
      estimatedReadingTime: 55,
      category: "Daily Life",
    ),
    StoryModel(
      id: 2,
      title: "I Have a Dog",
      level: "Beginner",
      content:
          """I have a dog and his name is Max. Max is brown and white and he is very cute. He has big eyes and a long tail. Max is my friend and I love him.

Every day I play with Max in the park. I throw a ball and Max runs to get the ball. He is very fast and he likes to run. When Max finds the ball, he brings it back to me and I throw it again. We play for a long time and we have fun together.

At night, Max sleeps in my room. He sleeps on a blue bed next to my bed. I am happy because Max is with me. Max is a good dog and he is my best friend.""",
      contentSpanish:
          """Tengo un perro y su nombre es Max. Max es café y blanco y es muy lindo. Tiene ojos grandes y una cola larga. Max es mi amigo y lo amo.

Todos los días juego con Max en el parque. Lanzo una pelota y Max corre a buscar la pelota. Él es muy rápido y le gusta correr. Cuando Max encuentra la pelota, me la trae de vuelta y la lanzo otra vez. Jugamos por mucho tiempo y nos divertimos juntos.

Por la noche, Max duerme en mi habitación. Él duerme en una cama azul junto a mi cama. Estoy feliz porque Max está conmigo. Max es un buen perro y es mi mejor amigo.""",
      estimatedReadingTime: 60,
      category: "Daily Life",
    ),
    StoryModel(
      id: 3,
      title: "My New Friend",
      level: "Beginner",
      content:
          """Today is my first day at a new school and I am a little nervous. I walk into my classroom and I see many kids. They are all talking and laughing. I do not know anyone here.

I sit at a desk near the window. A girl with black hair sits next to me. She smiles at me and says hello. Her name is Emma and she is very nice. Emma shows me where the bathroom is and where we eat lunch. She tells me about the teacher and about the fun games we play.

Now I am not nervous anymore. I am happy because Emma is my friend. I think I am going to like this new school very much.""",
      contentSpanish:
          """Hoy es mi primer día en una escuela nueva y estoy un poco nervioso. Entro a mi salón de clases y veo muchos niños. Todos están hablando y riendo. No conozco a nadie aquí.

Me siento en un escritorio cerca de la ventana. Una niña con cabello negro se sienta junto a mí. Ella me sonríe y me dice hola. Su nombre es Emma y es muy amable. Emma me muestra dónde está el baño y dónde comemos el almuerzo. Me cuenta sobre el maestro y sobre los juegos divertidos que jugamos.

Ahora ya no estoy nervioso. Estoy feliz porque Emma es mi amiga. Creo que me va a gustar mucho esta escuela nueva.""",
      estimatedReadingTime: 60,
      category: "Friendship",
    ),
    StoryModel(
      id: 4,
      title: "A Day at Home",
      level: "Beginner",
      content:
          """Today I stay at home because it is raining outside. I can see the rain from my window. The rain is falling down and everything is wet. I cannot go out to play so I need to find something to do inside my house.

I go to my room and I look at my toys. I have many toys but today I want to read. I take a book from my shelf. The book has pictures of animals in it. I see a big elephant, a tall giraffe, and a small mouse. The animals are very colorful and I like looking at them.

I read my book for one hour. When I finish the book, I look outside again. The rain stopped and now I can see the sun. I am happy because now I can go outside and play.""",
      contentSpanish:
          """Hoy me quedo en casa porque está lloviendo afuera. Puedo ver la lluvia desde mi ventana. La lluvia está cayendo y todo está mojado. No puedo salir a jugar así que necesito encontrar algo que hacer dentro de mi casa.

Voy a mi habitación y miro mis juguetes. Tengo muchos juguetes pero hoy quiero leer. Tomo un libro de mi estante. El libro tiene imágenes de animales. Veo un elefante grande, una jirafa alta, y un ratón pequeño. Los animales son muy coloridos y me gusta mirarlos.

Leo mi libro por una hora. Cuando termino el libro, miro afuera otra vez. La lluvia se detuvo y ahora puedo ver el sol. Estoy feliz porque ahora puedo salir afuera y jugar.""",
      estimatedReadingTime: 65,
      category: "Daily Life",
    ),
    StoryModel(
      id: 5,
      title: "I Learn to Plant",
      level: "Beginner",
      content:
          """My mom likes plants and flowers. She has many plants in our house. Today she asks me if I want to learn how to plant flowers. I say yes because I think it will be fun.

My mom gives me a small pot and some dirt. She also gives me some seeds. The seeds are very small and round. My mom shows me how to put the dirt in the pot. Then I put the seeds in the dirt and I cover them. My mom tells me that I need to give water to my plant every day.

Every morning I look at my pot. At first I see nothing, just dirt. But after some days, I see something green coming out. My plant is growing and I am very excited. I learn that plants need water, sun, and time to grow. I am happy because I can take care of my plant.""",
      contentSpanish:
          """A mi mamá le gustan las plantas y las flores. Ella tiene muchas plantas en nuestra casa. Hoy me pregunta si quiero aprender a plantar flores. Digo que sí porque creo que será divertido.

Mi mamá me da una maceta pequeña y tierra. También me da algunas semillas. Las semillas son muy pequeñas y redondas. Mi mamá me muestra cómo poner la tierra en la maceta. Luego pongo las semillas en la tierra y las cubro. Mi mamá me dice que necesito darle agua a mi planta todos los días.

Cada mañana miro mi maceta. Al principio no veo nada, solo tierra. Pero después de algunos días, veo algo verde saliendo. Mi planta está creciendo y estoy muy emocionado. Aprendo que las plantas necesitan agua, sol, y tiempo para crecer. Estoy feliz porque puedo cuidar mi planta.""",
      estimatedReadingTime: 70,
      category: "Life Lessons",
    ),
    // 🆕 NUEVAS HISTORIAS BEGINNER
    StoryModel(
      id: 13,
      title: "The Ice Cream Shop",
      level: "Beginner",
      content:
          """Today is a very hot day and I want to eat ice cream. My dad takes me to the ice cream shop. The shop is small and clean. It has many colors of ice cream.

I look at all the ice cream. There is chocolate, vanilla, strawberry, and many more. I cannot choose because they all look good. The man in the shop is very nice. He lets me taste the strawberry ice cream.

The strawberry ice cream is sweet and cold. I like it very much so I buy two scoops. My dad buys chocolate. We sit outside and eat our ice cream. The sun is hot but the ice cream makes me feel cool. This is a perfect day.""",
      contentSpanish:
          """Hoy es un día muy caluroso y quiero comer helado. Mi papá me lleva a la heladería. La tienda es pequeña y limpia. Tiene muchos colores de helado.

Miro todo el helado. Hay chocolate, vainilla, fresa, y muchos más. No puedo elegir porque todos se ven bien. El hombre en la tienda es muy amable. Me deja probar el helado de fresa.

El helado de fresa es dulce y frío. Me gusta mucho así que compro dos bolas. Mi papá compra chocolate. Nos sentamos afuera y comemos nuestro helado. El sol está caliente pero el helado me hace sentir fresco. Este es un día perfecto.""",
      estimatedReadingTime: 60,
      category: "Daily Life",
    ),
    StoryModel(
      id: 14,
      title: "My Little Sister",
      level: "Beginner",
      content:
          """I have a little sister. Her name is Sofia and she is three years old. Sofia is very small and she has curly hair. She likes to follow me everywhere I go.

Sometimes Sofia makes me angry because she touches my toys. But most of the time, she makes me laugh. She does funny faces and she dances to music. When she dances, she moves her arms up and down.

Yesterday, Sofia was sad because she fell down. She was crying a lot. I gave her my favorite teddy bear and I sang her a song. Sofia stopped crying and she smiled at me. She gave me a big hug.

I am happy that Sofia is my sister. Even when she touches my toys, I love her very much. Being a big brother is a good thing.""",
      contentSpanish:
          """Tengo una hermana pequeña. Su nombre es Sofía y tiene tres años. Sofía es muy pequeña y tiene cabello rizado. Le gusta seguirme a donde quiera que voy.

A veces Sofía me hace enojar porque toca mis juguetes. Pero la mayoría del tiempo, me hace reír. Hace caras graciosas y baila con la música. Cuando baila, mueve sus brazos arriba y abajo.

Ayer, Sofía estaba triste porque se cayó. Estaba llorando mucho. Le di mi oso de peluche favorito y le canté una canción. Sofía dejó de llorar y me sonrió. Me dio un abrazo grande.

Estoy feliz de que Sofía sea mi hermana. Incluso cuando toca mis juguetes, la amo mucho. Ser hermano mayor es algo bueno.""",
      estimatedReadingTime: 65,
      category: "Friendship",
    ),

    // ===== INTERMEDIATE STORIES (7 historias) =====
    StoryModel(
      id: 6,
      title: "The Bus Stop",
      level: "Intermediate",
      content:
          """Every morning, Jenny waited at the same bus stop. She always saw the same people.

There was an old man who read the newspaper. There was a young mother with her baby. There was a businessman on his phone.

They never spoke to each other. They were all strangers.

One day, the bus was very late. Everyone was getting worried. The old man finally spoke.

"Does anyone know what's happening?" he asked. The mother checked her phone. "There's an accident on Main Street," she said.

They started talking. They shared stories. They laughed together. The bus finally arrived an hour later.

But something had changed. Now they weren't strangers anymore. Every morning after that, they said hello to each other.""",
      contentSpanish:
          """Cada mañana, Jenny esperaba en la misma parada de autobús. Siempre veía a las mismas personas.

Había un anciano que leía el periódico. Había una madre joven con su bebé. Había un hombre de negocios en su teléfono.

Nunca se hablaban entre ellos. Todos eran extraños.

Un día, el autobús llegó muy tarde. Todos estaban preocupados. El anciano finalmente habló.

"¿Alguien sabe qué está pasando?" preguntó. La madre revisó su teléfono. "Hay un accidente en la Calle Principal," dijo.

Comenzaron a hablar. Compartieron historias. Se rieron juntos. El autobús finalmente llegó una hora después.

Pero algo había cambiado. Ya no eran extraños. Cada mañana después de eso, se saludaban.""",
      estimatedReadingTime: 75,
      category: "Friendship",
    ),
    StoryModel(
      id: 7,
      title: "The Perfect Photo",
      level: "Intermediate",
      content:
          """Anna loved photography. She wanted to take the perfect photo of a sunset.

Every evening, she went to the beach. She waited for the perfect moment. But something was always wrong.

One evening, her camera broke. Anna was very upset. She sat on the sand and watched the sunset without her camera.

The colors were incredible. Orange, pink, and purple filled the sky. It was the most beautiful sunset she had ever seen.

Anna smiled. She realized something important. Sometimes the best moments can't be captured. They can only be lived.

She never forgot that sunset. It was perfect, even without a photo.""",
      contentSpanish:
          """A Anna le encantaba la fotografía. Quería tomar la foto perfecta de un atardecer.

Cada tarde, iba a la playa. Esperaba el momento perfecto. Pero algo siempre estaba mal.

Una tarde, su cámara se rompió. Anna estaba muy molesta. Se sentó en la arena y vio el atardecer sin su cámara.

Los colores eran increíbles. Naranja, rosa y morado llenaban el cielo. Era el atardecer más hermoso que había visto.

Anna sonrió. Se dio cuenta de algo importante. A veces los mejores momentos no se pueden capturar. Solo se pueden vivir.

Nunca olvidó ese atardecer. Fue perfecto, incluso sin una foto.""",
      estimatedReadingTime: 70,
      category: "Life Lessons",
    ),
    StoryModel(
      id: 8,
      title: "The Old Bookstore",
      level: "Intermediate",
      content:
          """Mr. Chen owned a small bookstore for forty years. It was on a quiet street in the old part of town.

These days, not many people came to his store. Everyone bought books online. Mr. Chen felt sad. He loved his bookstore.

One afternoon, a young woman walked in. She looked around with wide eyes. "This place is magical," she said.

She started visiting every week. She told her friends. Soon, more young people discovered the bookstore.

They didn't just buy books. They stayed to read. They talked about stories. They drank tea that Mr. Chen made.

The bookstore became alive again. Mr. Chen smiled. His store had found a new generation of readers.""",
      contentSpanish:
          """El Sr. Chen tuvo una pequeña librería durante cuarenta años. Estaba en una calle tranquila en la parte vieja de la ciudad.

En estos días, no muchas personas venían a su tienda. Todos compraban libros en línea. El Sr. Chen se sentía triste. Amaba su librería.

Una tarde, una mujer joven entró. Miró alrededor con ojos grandes. "Este lugar es mágico," dijo.

Ella comenzó a visitar cada semana. Les contó a sus amigos. Pronto, más jóvenes descubrieron la librería.

No solo compraban libros. Se quedaban a leer. Hablaban sobre historias. Tomaban té que el Sr. Chen preparaba.

La librería cobró vida otra vez. El Sr. Chen sonrió. Su tienda había encontrado una nueva generación de lectores.""",
      estimatedReadingTime: 80,
      category: "Life Lessons",
    ),
    StoryModel(
      id: 9,
      title: "The Night Shift",
      level: "Intermediate",
      content:
          """Carlos worked the night shift at a hospital. He was a security guard. The hospital was quiet at night.

Every night at 2 AM, he walked through all the floors. He checked that everything was safe.

One night, he heard piano music. It was coming from the old waiting room. Nobody used that room anymore.

Carlos walked slowly toward the sound. He opened the door carefully.

An elderly man was sitting at the piano. He was playing a beautiful, sad song. Carlos recognized him. He was a patient from the third floor.

"That's beautiful," Carlos said softly. The man smiled. "I used to be a pianist," he said. "I haven't played in years. I couldn't sleep tonight, and I remembered this piano was here."

Carlos sat and listened. For thirty minutes, the hospital was filled with music. It was the most peaceful night Carlos ever had at work.""",
      contentSpanish:
          """Carlos trabajaba en el turno de noche en un hospital. Era guardia de seguridad. El hospital estaba tranquilo por la noche.

Cada noche a las 2 AM, caminaba por todos los pisos. Revisaba que todo estuviera seguro.

Una noche, escuchó música de piano. Venía de la vieja sala de espera. Nadie usaba esa sala ya.

Carlos caminó lentamente hacia el sonido. Abrió la puerta con cuidado.

Un anciano estaba sentado en el piano. Estaba tocando una canción hermosa y triste. Carlos lo reconoció. Era un paciente del tercer piso.

"Eso es hermoso," dijo Carlos suavemente. El hombre sonrió. "Solía ser pianista," dijo. "No he tocado en años. No podía dormir esta noche, y recordé que este piano estaba aquí."

Carlos se sentó y escuchó. Durante treinta minutos, el hospital se llenó de música. Fue la noche más tranquila que Carlos tuvo en el trabajo.""",
      estimatedReadingTime: 90,
      category: "Daily Life",
    ),
    StoryModel(
      id: 10,
      title: "The Language Exchange",
      level: "Intermediate",
      content:
          """Yuki moved to Canada from Japan. She wanted to improve her English. She was very shy.

One day, she saw a sign at a café: "Language Exchange - Every Tuesday." She decided to go.

At first, she was nervous. She couldn't speak much. But everyone was patient. They helped her find the words.

She met Robert, a Canadian who wanted to learn Japanese. They became language partners. They met twice a week.

Robert taught Yuki English idioms. Yuki taught Robert Japanese characters. They made mistakes and laughed together.

Six months later, Yuki's English was much better. But more importantly, she had made a real friend. Learning a language had given her more than words. It had given her confidence and connection.""",
      contentSpanish:
          """Yuki se mudó a Canadá desde Japón. Quería mejorar su inglés. Era muy tímida.

Un día, vio un letrero en un café: "Intercambio de Idiomas - Cada Martes." Decidió ir.

Al principio, estaba nerviosa. No podía hablar mucho. Pero todos fueron pacientes. La ayudaron a encontrar las palabras.

Conoció a Robert, un canadiense que quería aprender japonés. Se volvieron compañeros de idiomas. Se reunían dos veces por semana.

Robert le enseñó a Yuki expresiones idiomáticas en inglés. Yuki le enseñó a Robert caracteres japoneses. Cometían errores y se reían juntos.

Seis meses después, el inglés de Yuki era mucho mejor. Pero más importante, había hecho un amigo real. Aprender un idioma le había dado más que palabras. Le había dado confianza y conexión.""",
      estimatedReadingTime: 85,
      category: "Friendship",
    ),
    // 🆕 NUEVAS HISTORIAS INTERMEDIATE
    StoryModel(
      id: 15,
      title: "The Community Garden",
      level: "Intermediate",
      content:
          """The empty lot on Maple Street had been abandoned for years. It was full of weeds and trash. Nobody wanted to look at it.

One spring morning, Mrs. Rodriguez had an idea. She talked to her neighbors about creating a community garden. At first, people were skeptical. "It's too much work," they said.

But Mrs. Rodriguez didn't give up. She started cleaning the lot herself. Every weekend, she was there, pulling weeds and picking up trash.

Slowly, neighbors started joining her. First one, then two, then five. They brought seeds, tools, and enthusiasm. Children came to help plant flowers. Teenagers built raised garden beds.

By summer, the lot had transformed. There were tomatoes, peppers, sunflowers, and herbs. People who had never spoken before were now friends. They shared vegetables and recipes. The garden had grown more than just plants. It had grown a community.""",
      contentSpanish:
          """El lote vacío en la Calle Maple había estado abandonado por años. Estaba lleno de maleza y basura. Nadie quería mirarlo.

Una mañana de primavera, la Sra. Rodríguez tuvo una idea. Habló con sus vecinos sobre crear un jardín comunitario. Al principio, la gente era escéptica. "Es mucho trabajo," dijeron.

Pero la Sra. Rodríguez no se rindió. Comenzó a limpiar el lote ella misma. Cada fin de semana, estaba allí, arrancando maleza y recogiendo basura.

Lentamente, los vecinos comenzaron a unirse. Primero uno, luego dos, luego cinco. Trajeron semillas, herramientas y entusiasmo. Los niños vinieron a ayudar a plantar flores. Los adolescentes construyeron camas de jardín elevadas.

Para el verano, el lote se había transformado. Había tomates, pimientos, girasoles y hierbas. Personas que nunca habían hablado ahora eran amigos. Compartían vegetales y recetas. El jardín había cultivado más que solo plantas. Había cultivado una comunidad.""",
      estimatedReadingTime: 85,
      category: "Friendship",
    ),
    StoryModel(
      id: 16,
      title: "The Wrong Train",
      level: "Intermediate",
      content:
          """Maya was traveling to visit her grandmother. She had made this trip many times before. She knew exactly which train to take.

But that day, she was distracted. She was reading a book and didn't pay attention to the announcements. When she looked up, the train was moving in the wrong direction.

Maya panicked. She got off at the next station. It was a small town she had never seen before. She didn't know what to do.

An elderly woman noticed Maya's worried face. "Are you lost, dear?" she asked. Maya explained her mistake. The woman smiled warmly. "The next train back won't come for two hours. Would you like some tea while you wait?"

They went to a small café. The woman told Maya stories about the town. She showed her the beautiful old church and the river. Maya forgot about being lost.

When the train finally came, Maya felt grateful. She had discovered that sometimes wrong turns lead to the most memorable adventures. She exchanged phone numbers with the woman and promised to visit again.""",
      contentSpanish:
          """Maya estaba viajando para visitar a su abuela. Había hecho este viaje muchas veces antes. Sabía exactamente qué tren tomar.

Pero ese día, estaba distraída. Estaba leyendo un libro y no prestó atención a los anuncios. Cuando levantó la vista, el tren se movía en la dirección equivocada.

Maya entró en pánico. Se bajó en la siguiente estación. Era un pueblo pequeño que nunca había visto. No sabía qué hacer.

Una anciana notó la cara preocupada de Maya. "¿Estás perdida, querida?" preguntó. Maya explicó su error. La mujer sonrió calurosamente. "El próximo tren de regreso no vendrá hasta dentro de dos horas. ¿Te gustaría un té mientras esperas?"

Fueron a un pequeño café. La mujer le contó a Maya historias sobre el pueblo. Le mostró la hermosa iglesia antigua y el río. Maya olvidó que estaba perdida.

Cuando el tren finalmente llegó, Maya se sintió agradecida. Había descubierto que a veces los giros equivocados llevan a las aventuras más memorables. Intercambió números de teléfono con la mujer y prometió visitarla de nuevo.""",
      estimatedReadingTime: 90,
      category: "Life Lessons",
    ),

    // ===== ADVANCED STORIES (5 historias) =====
    StoryModel(
      id: 11,
      title: "The Lighthouse Keeper",
      level: "Advanced",
      content:
          """For thirty years, Margaret had been the keeper of Whitestone Lighthouse. Perched on a rocky cliff overlooking the Atlantic, the lighthouse had guided countless ships safely through treacherous waters.

Margaret lived alone, which suited her perfectly. She had her books, her telescope, and the endless rhythm of the ocean. Every evening, she climbed the spiral staircase to light the beacon, a ritual that had become as natural as breathing.

One stormy November night, she spotted something unusual through her telescope. A small boat was struggling in the violent waves, its distress signals barely visible through the rain.

Without hesitation, Margaret radioed the coast guard and grabbed her emergency kit. She knew the waters around Whitestone better than anyone. She guided the rescue team through the safest approach.

The family of four was saved that night. They came to thank Margaret the following week, bringing flowers and gratitude. "You saved our lives," they said.

Margaret smiled quietly. She had never sought recognition. For her, keeping the light burning was simply what she did. Some people are meant to be a steady light in the darkness, guiding others home.""",
      contentSpanish:
          """Durante treinta años, Margaret había sido la guardiana del Faro Whitestone. Ubicado en un acantilado rocoso con vista al Atlántico, el faro había guiado innumerables barcos de forma segura a través de aguas peligrosas.

Margaret vivía sola, lo cual le convenía perfectamente. Tenía sus libros, su telescopio y el ritmo interminable del océano. Cada tarde, subía la escalera de caracol para encender el faro, un ritual que se había vuelto tan natural como respirar.

Una tormentosa noche de noviembre, vio algo inusual a través de su telescopio. Un pequeño bote luchaba en las olas violentas, sus señales de auxilio apenas visibles a través de la lluvia.

Sin dudarlo, Margaret llamó por radio a la guardia costera y tomó su kit de emergencia. Conocía las aguas alrededor de Whitestone mejor que nadie. Guió al equipo de rescate por el camino más seguro.

La familia de cuatro fue salvada esa noche. Vinieron a agradecer a Margaret la semana siguiente, trayendo flores y gratitud. "Salvaste nuestras vidas," dijeron.

Margaret sonrió en silencio. Nunca había buscado reconocimiento. Para ella, mantener la luz encendida era simplemente lo que hacía. Algunas personas están destinadas a ser una luz constante en la oscuridad, guiando a otros a casa.""",
      estimatedReadingTime: 95,
      category: "Life Lessons",
    ),
    StoryModel(
      id: 12,
      title: "The Last Letter",
      level: "Advanced",
      content:
          """James found the letter while cleaning out his grandfather's attic. It was yellowed with age, dated 1944, and addressed to someone named Catherine.

His grandfather had passed away three months ago. James had never heard of Catherine. The letter had never been sent. It sat in an old wooden box with a faded photograph of a young woman.

The letter was a love story. His grandfather had met Catherine during the war. They had fallen in love, made plans for a future together. But something had happened. The letter spoke of misunderstanding, of missed connections, of words left unsaid.

James felt he needed to know more. He started researching. He found Catherine's family. She had passed away ten years ago, but her daughter was alive. Her name was Susan.

James contacted Susan and sent her the letter and photograph. Two weeks later, Susan called him, crying. "My mother spoke of him," she said. "She never forgot him. She kept his photograph too. She always wondered what had happened."

They met for coffee. They shared their parents' stories. Two families, connected by a love that had never quite been, brought together finally by a letter that was seventy-five years too late. Yet somehow, it arrived exactly when it needed to.""",
      contentSpanish:
          """James encontró la carta mientras limpiaba el ático de su abuelo. Estaba amarillenta por la edad, fechada en 1944, y dirigida a alguien llamado Catherine.

Su abuelo había fallecido hacía tres meses. James nunca había oído hablar de Catherine. La carta nunca fue enviada. Estaba en una vieja caja de madera con una fotografía descolorida de una mujer joven.

La carta era una historia de amor. Su abuelo había conocido a Catherine durante la guerra. Se habían enamorado, hicieron planes para un futuro juntos. Pero algo había pasado. La carta hablaba de malentendidos, de conexiones perdidas, de palabras no dichas.

James sintió que necesitaba saber más. Comenzó a investigar. Encontró a la familia de Catherine. Ella había fallecido hacía diez años, pero su hija estaba viva. Su nombre era Susan.

James contactó a Susan y le envió la carta y la fotografía. Dos semanas después, Susan lo llamó, llorando. "Mi madre habló de él," dijo. "Nunca lo olvidó. También guardó su fotografía. Siempre se preguntó qué había pasado."

Se reunieron para tomar café. Compartieron las historias de sus padres. Dos familias, conectadas por un amor que nunca llegó a ser, unidas finalmente por una carta que llegó setenta y cinco años tarde. Sin embargo, de alguna manera, llegó exactamente cuando debía.""",
      estimatedReadingTime: 110,
      category: "Life Lessons",
    ),
    // 🆕 NUEVAS HISTORIAS ADVANCED
    StoryModel(
      id: 17,
      title: "The Art of Forgiveness",
      level: "Advanced",
      content:
          """Sarah hadn't spoken to her brother in fifteen years. The argument that had torn them apart seemed so important at the time, but now, sitting in the hospital waiting room, she couldn't even remember what it was about. Their mother was in surgery, and Sarah had nowhere else to turn.

When Daniel walked through the door, they locked eyes. The years melted away in an instant, replaced by a flood of memories: childhood adventures, shared secrets, the bond that had once been unbreakable.

"I'm sorry," they both said simultaneously, and then laughed through their tears. It was that simple and that complicated.

They spent the night talking, really talking, for the first time in years. They discovered that both had wanted to reach out countless times but pride had always won. They had allowed a momentary anger to steal fifteen years of siblinghood.

Their mother recovered. At her bedside, she held both their hands and said, "Life is too short for grudges. I'm glad you both finally learned that." 

Sarah realized that forgiveness isn't about forgetting or even about who was right. It's about choosing love over pride, connection over being correct. Sometimes the bravest thing we can do is simply say, "I miss you.""",
      contentSpanish:
          """Sarah no había hablado con su hermano en quince años. La discusión que los había separado parecía tan importante en ese momento, pero ahora, sentada en la sala de espera del hospital, ni siquiera podía recordar de qué se trataba. Su madre estaba en cirugía, y Sarah no tenía a nadie más a quien acudir.

Cuando Daniel entró por la puerta, sus ojos se encontraron. Los años se derritieron en un instante, reemplazados por un torrente de recuerdos: aventuras de infancia, secretos compartidos, el vínculo que una vez fue inquebrantable.

"Lo siento," dijeron ambos simultáneamente, y luego rieron entre lágrimas. Era así de simple y así de complicado.

Pasaron la noche hablando, realmente hablando, por primera vez en años. Descubrieron que ambos habían querido contactarse innumerables veces pero el orgullo siempre había ganado. Habían permitido que una ira momentánea robara quince años de hermandad.

Su madre se recuperó. A su lado de la cama, sostuvo las manos de ambos y dijo, "La vida es demasiado corta para rencores. Me alegra que ambos finalmente aprendieran eso."

Sarah se dio cuenta de que el perdón no se trata de olvidar o incluso de quién tenía razón. Se trata de elegir el amor sobre el orgullo, la conexión sobre tener razón. A veces lo más valiente que podemos hacer es simplemente decir, "Te extraño".""",
      estimatedReadingTime: 100,
      category: "Friendship",
    ),
    StoryModel(
      id: 18,
      title: "The Underground Orchestra",
      level: "Advanced",
      content:
          """Every evening at 6 PM, Marcus set up his violin in the subway station. For three years, he had played there, earning enough to pay rent and hoping to be discovered. But lately, he had started to question if his dream was worth pursuing.

One Tuesday, something unexpected happened. As Marcus began playing Vivaldi, a young woman with a cello appeared beside him. She didn't say anything, just started playing along. Then a man with a clarinet joined them. And another with a trumpet.

Within minutes, a full orchestra had formed spontaneously. Commuters stopped rushing. They gathered around, mesmerized. Some pulled out their phones to record. Others simply stood still, transported by the music that filled the underground station.

The impromptu concert lasted forty minutes. When it ended, the applause was thunderous. The musicians looked at each other, strangers who had just created something beautiful together. They exchanged contact information, excited.

That night became the birth of the Underground Orchestra. Every Tuesday at 6 PM, they met to play. Sometimes there were five musicians, sometimes twenty. News spread. People came specifically to hear them. Record labels noticed.

Marcus never got his solo record deal. But he got something better: a community of artists and an audience that truly appreciated the music. He had been so focused on individual success that he'd almost missed the joy of creating something together. Sometimes our dreams come true, just not in the way we imagined.""",
      contentSpanish:
          """Cada tarde a las 6 PM, Marcus instalaba su violín en la estación del metro. Durante tres años, había tocado allí, ganando lo suficiente para pagar el alquiler y esperando ser descubierto. Pero últimamente, había comenzado a cuestionar si valía la pena perseguir su sueño.

Un martes, algo inesperado sucedió. Cuando Marcus comenzó a tocar Vivaldi, una mujer joven con un chelo apareció a su lado. No dijo nada, solo comenzó a tocar junto a él. Luego un hombre con un clarinete se unió. Y otro con una trompeta.

En minutos, una orquesta completa se había formado espontáneamente. Los pasajeros dejaron de apresurarse. Se reunieron alrededor, hipnotizados. Algunos sacaron sus teléfonos para grabar. Otros simplemente se quedaron quietos, transportados por la música que llenaba la estación subterránea.

El concierto improvisado duró cuarenta minutos. Cuando terminó, el aplauso fue estruendoso. Los músicos se miraron entre sí, extraños que acababan de crear algo hermoso juntos. Intercambiaron información de contacto, emocionados.

Esa noche nació la Orquesta Subterránea. Cada martes a las 6 PM, se reunían para tocar. A veces había cinco músicos, a veces veinte. La noticia se difundió. La gente venía específicamente a escucharlos. Las discográficas lo notaron.

Marcus nunca consiguió su contrato discográfico en solitario. Pero consiguió algo mejor: una comunidad de artistas y una audiencia que realmente apreciaba la música. Había estado tan enfocado en el éxito individual que casi se pierde la alegría de crear algo juntos. A veces nuestros sueños se hacen realidad, solo que no de la manera que imaginamos.""",
      estimatedReadingTime: 115,
      category: "Life Lessons",
    ),
    StoryModel(
      id: 19,
      title: "The Butterfly Effect",
      level: "Advanced",
      content:
          """Dr. Elena Rodriguez was about to deliver the most important presentation of her career at the International Climate Conference. Years of research would be revealed today. She had left nothing to chance.

Except she had forgotten her laptop charger. With 10% battery remaining and twenty minutes until her presentation, Elena panicked. She asked everyone nearby. No one had the right adapter.

A young custodian named Miguel overheard her distress. "I know where there might be one," he said. He led her through back hallways to the maintenance office. They found a universal adapter.

During those ten minutes, Elena learned that Miguel was studying environmental science at night school. He had attended every session of the conference, listening from the back. He asked her insightful questions about her research.

Elena gave her presentation successfully. But that night, she couldn't stop thinking about Miguel. She made some calls. Within a week, she had secured him a full scholarship to her university.

Ten years later, Dr. Miguel Santos published groundbreaking research on urban sustainability. At his book launch, he thanked Dr. Rodriguez publicly. "A forgotten charger changed my life," he said.

Elena smiled. She had learned that the most important discoveries often happen not in laboratories, but in the moments when we choose to truly see the people around us. One small act of kindness can change everything.""",
      contentSpanish:
          """La Dra. Elena Rodríguez estaba a punto de dar la presentación más importante de su carrera en la Conferencia Internacional del Clima. Años de investigación serían revelados hoy. No había dejado nada al azar.

Excepto que había olvidado su cargador de laptop. Con 10% de batería restante y veinte minutos hasta su presentación, Elena entró en pánico. Preguntó a todos los cercanos. Nadie tenía el adaptador correcto.

Un joven conserje llamado Miguel escuchó su angustia. "Sé dónde podría haber uno," dijo. La llevó por pasillos traseros a la oficina de mantenimiento. Encontraron un adaptador universal.

Durante esos diez minutos, Elena supo que Miguel estaba estudiando ciencias ambientales en la escuela nocturna. Había asistido a cada sesión de la conferencia, escuchando desde atrás. Le hizo preguntas perspicaces sobre su investigación.

Elena dio su presentación exitosamente. Pero esa noche, no podía dejar de pensar en Miguel. Hizo algunas llamadas. En una semana, le había conseguido una beca completa en su universidad.

Diez años después, el Dr. Miguel Santos publicó una investigación revolucionaria sobre sostenibilidad urbana. En el lanzamiento de su libro, agradeció públicamente a la Dra. Rodríguez. "Un cargador olvidado cambió mi vida," dijo.

Elena sonrió. Había aprendido que los descubrimientos más importantes a menudo no ocurren en laboratorios, sino en los momentos en que elegimos realmente ver a las personas a nuestro alrededor. Un pequeño acto de bondad puede cambiarlo todo.""",
      estimatedReadingTime: 110,
      category: "Life Lessons",
    ),
  ];

  // Obtener todas las historias
  static List<StoryModel> getAllStories() {
    return _allStories;
  }

  // Filtrar por nivel
  static List<StoryModel> getStoriesByLevel(String level) {
    return _allStories.where((story) => story.level == level).toList();
  }

  // Filtrar por categoría
  static List<StoryModel> getStoriesByCategory(String category) {
    return _allStories.where((story) => story.category == category).toList();
  }

  // Obtener historia por ID
  static StoryModel? getStoryById(int id) {
    try {
      return _allStories.firstWhere((story) => story.id == id);
    } catch (e) {
      return null;
    }
  }

  // Obtener todas las categorías únicas
  static List<String> getAllCategories() {
    return _allStories.map((story) => story.category).toSet().toList();
  }

  // Obtener todos los niveles únicos
  static List<String> getAllLevels() {
    return _allStories.map((story) => story.level).toSet().toList();
  }
}
