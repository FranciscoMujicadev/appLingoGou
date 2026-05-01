// lib/data/datasources/days/business_interviews_lesson5_datasource.dart
//
// Business English — Nivel 104: Interview Q&A (Format: Question + Bad Answer + Good Answer + Why it works)

import '../../../core/models/phrase_model.dart';

class BusinessInterviewsLesson5DataSource {
  static List<Phrase> getPhrases() {
    return [
      Phrase(
        id: 'bei4-1',
        idiom: 'Tell me about yourself.',
        literalTranslation: 'Cuéntame sobre ti.',
        realMeaning:
            'HR quiere un pitch profesional de 60 seg: quién eres, qué haces, qué valor aportas.',
        category: 'Nivel 104',
        pronunciation: 'tel mi abaut yor-self',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample:
                "Well, I was born in a small town, I love dogs, and I studied marketing because my mom said it was a good career...",
            pronunciation:
                "wel, ai was born in a smol taun, ai lov dogs, and ai stadid marketing...",
            spanishExample:
                'Bueno, nací en un pueblo pequeño, amo los perros, y estudié marketing porque mi mamá dijo que era buena carrera...',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample:
                "I'm a digital marketer with 5 years scaling e-commerce brands. In my last role, I grew organic traffic 140% in 8 months. I'm here because your growth stage is exactly where I add the most value.",
            pronunciation:
                "aim a diyital marketer wiz faiv yirs skeiling i-komers brands...",
            spanishExample:
                'Soy un marketero digital con 5 años escalando marcas de e-commerce. En mi último puesto crecí el tráfico orgánico un 140% en 8 meses. Estoy aquí porque su etapa de crecimiento es exactamente donde más valor aporto.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample:
                "It's specific, metric-backed, and ends by connecting YOU to THEIR company — not a life story.",
            pronunciation: "its spesifik, metrik-bakt, and ends bai konekting yu tu der kompani",
            spanishExample:
                'Es específica, respaldada con métricas, y termina conectándote TÚ con la empresa — no una biografía.',
          ),
        ],
      ),
      Phrase(
        id: 'bei4-2',
        idiom: 'Why did you leave your last job?',
        literalTranslation: '¿Por qué dejaste tu último trabajo?',
        realMeaning:
            'Evalúan madurez y lealtad. Quieren ver que no hablas mal de nadie y buscas crecimiento.',
        category: 'Nivel 104',
        pronunciation: 'wai did yu liv yor last yob',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample:
                "My boss was terrible and the team was toxic. I couldn't stand it anymore.",
            pronunciation: "mai bos was terribol and de tim was toksik",
            spanishExample:
                'Mi jefe era terrible y el equipo era tóxico. Ya no lo soportaba.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample:
                "I learned a lot in my last role, but I'm looking for challenges that align more with my long-term career goals — and this position is exactly that fit.",
            pronunciation: "ai lernd a lot in mai last rol, bat aim luking for chalenches...",
            spanishExample:
                'Aprendí mucho en mi último puesto, pero busco desafíos que se alineen más con mis objetivos a largo plazo — y este puesto es exactamente ese encaje.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample:
                "Zero negativity. Frames the move as growth. Ends connecting to the new role. Honest AND diplomatic.",
            pronunciation: "ziro negativitii. freims de muv as groz",
            spanishExample:
                'Cero negatividad. Enmarca el cambio como crecimiento. Termina conectando con el nuevo puesto. Honesta Y diplomática.',
          ),
        ],
      ),
      Phrase(
        id: 'bei4-3',
        idiom: 'How do you handle pressure?',
        literalTranslation: '¿Cómo manejas la presión?',
        realMeaning:
            'Buscan una estrategia concreta + un ejemplo real con resultado medible.',
        category: 'Nivel 104',
        pronunciation: 'jau du yu jandol preshur',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample:
                "I work well under pressure. I'm very calm and I handle stress like a pro.",
            pronunciation: "ai work wel ander preshur",
            spanishExample:
                'Trabajo bien bajo presión. Soy muy calmado y manejo el estrés como un profesional.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample:
                "I break large tasks into manageable chunks and focus on solutions, not problems. In my last role, I handled three simultaneous launches by creating a priority matrix — all delivered on time.",
            pronunciation: "ai breik larY tasks intu maneyabol chanks...",
            spanishExample:
                'Divido las tareas grandes en partes manejables y me enfoco en soluciones, no en problemas. En mi último puesto manejé tres lanzamientos simultáneos creando una matriz de prioridades — todos entregados a tiempo.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample:
                "Names a specific technique (priority matrix) and proves it with a measurable result. No vague adjectives.",
            pronunciation: "neims a spesifik teknik and pruvs it",
            spanishExample:
                'Nombra una técnica específica (matriz de prioridades) y la prueba con un resultado medible. Sin adjetivos vagos.',
          ),
        ],
      ),
      Phrase(
        id: 'bei4-4',
        idiom: 'Why should we hire you?',
        literalTranslation: '¿Por qué deberíamos contratarte?',
        realMeaning:
            'Tu momento de sell yourself: qué te diferencia + cómo ese diferencial les beneficia a ELLOS.',
        category: 'Nivel 104',
        pronunciation: 'wai shud wi jair yu',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample:
                "I'm hardworking, passionate, and a great team player. I really want this job.",
            pronunciation: "aim jardworking, pashonat, and a greit tim pleyer",
            spanishExample:
                'Soy trabajador, apasionado y gran jugador de equipo. Realmente quiero este trabajo.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample:
                "What sets me apart is combining creative strategy with data-driven decisions. My track record of 3 campaigns exceeding targets by 30%+ is exactly what your growth goals need this year.",
            pronunciation: "wot sets mi apart is kombaining krieitiv strateyI...",
            spanishExample:
                'Lo que me diferencia es combinar estrategia creativa con decisiones basadas en datos. Mi historial de 3 campañas superando objetivos en más del 30% es exactamente lo que sus metas de crecimiento necesitan este año.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample:
                "Connects your differentiator → your track record → their specific goal. It's about them, not you.",
            pronunciation: "konekts yor diferensiater tu der spesifik gol",
            spanishExample:
                'Conecta tu diferenciador → tu historial → su meta específica. Se trata de ellos, no de ti.',
          ),
        ],
      ),
      Phrase(
        id: 'bei4-5',
        idiom: 'What is your greatest weakness?',
        literalTranslation: '¿Cuál es tu mayor debilidad?',
        realMeaning:
            'Buscan autoconciencia y crecimiento — NO una fortaleza disfrazada de debilidad.',
        category: 'Nivel 104',
        pronunciation: 'wot is yor greitest wiknes',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample:
                "I'm a perfectionist. I just care too much about my work.",
            pronunciation: "aim a perfekshanist",
            spanishExample:
                'Soy perfeccionista. Simplemente me importa demasiado mi trabajo.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample:
                "I tend to take on too much instead of delegating early. I've been addressing it by running weekly planning sessions with my team — delegation is now a strength, not a struggle.",
            pronunciation: "ai tend tu teik on tu mach...",
            spanishExample:
                'Tiendo a asumir demasiado en lugar de delegar a tiempo. Lo he estado trabajando con sesiones semanales de planeación con mi equipo — la delegación ahora es una fortaleza, no un problema.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample:
                "Real weakness + specific action taken + current result. Shows self-awareness AND growth mindset.",
            pronunciation: "rial wiknes plas spesifik akshon",
            spanishExample:
                'Debilidad real + acción específica + resultado actual. Muestra autoconciencia Y mentalidad de crecimiento.',
          ),
        ],
      ),
      Phrase(
        id: 'bei4-6',
        idiom: 'Where do you see yourself in 5 years?',
        literalTranslation: '¿Dónde te ves en 5 años?',
        realMeaning:
            'Evalúan ambición + si tu visión encaja con el career path que ellos pueden ofrecer.',
        category: 'Nivel 104',
        pronunciation: 'wer du yu si yor-self in faiv yirs',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample:
                "Hopefully in your job. Or maybe as CEO. I want to grow a lot.",
            pronunciation: "joupfuli in yor yob. or meibi as si-i-ou",
            spanishExample:
                'Ojalá en tu puesto. O tal vez como CEO. Quiero crecer mucho.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample:
                "I see myself leading a mid-sized marketing team, owning strategy end-to-end. That's why this role excites me — it's the natural next step in that career path.",
            pronunciation: "ai si mai-self liding a mid-saisd marketing tim...",
            spanishExample:
                'Me veo liderando un equipo mediano de marketing, siendo dueño de la estrategia end-to-end. Por eso este puesto me entusiasma — es el siguiente paso natural en esa trayectoria.',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample:
                "Specific future role + ties it directly to THIS position as the stepping stone. No fantasy, no excess ambition.",
            pronunciation: "spesifik fiutshur rol plas taiz it direktli",
            spanishExample:
                'Rol futuro específico + lo conecta directamente con ESTE puesto como el escalón. Sin fantasías, sin ambición desmedida.',
          ),
        ],
      ),
      Phrase(
        id: 'bei4-7',
        idiom: 'Tell me about a significant challenge.',
        literalTranslation: 'Cuéntame de un desafío significativo.',
        realMeaning:
            'Quieren el STAR method: Situación, Tarea, Acción, Resultado medible.',
        category: 'Nivel 104',
        pronunciation: 'tel mi abaut a signifikant chalench',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample:
                "There was this really hard project once. It was super stressful but we made it through.",
            pronunciation: "der was dis rili jard proyekt wans",
            spanishExample:
                'Hubo un proyecto muy difícil una vez. Fue estresante pero lo logramos.',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample:
                "A key client threatened to cancel mid-project (Situation). I needed to save the account (Task). I organized a task force, realigned resources, and held daily client check-ins (Action). We delivered on time and renewed the contract for 2 more years (Result).",
            pronunciation: "a ki klaient tretend tu kansel...",
            spanishExample:
                'Un cliente clave amenazó con cancelar a mitad del proyecto (Situación). Necesitaba salvar la cuenta (Tarea). Organicé un task force, reasigné recursos y mantuve reuniones diarias con el cliente (Acción). Entregamos a tiempo y renovaron el contrato 2 años más (Resultado).',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample:
                "Clean STAR structure, measurable outcome (2-year renewal), and shows crisis leadership.",
            pronunciation: "klin star strakchur and meZhurabol autkom",
            spanishExample:
                'Estructura STAR limpia, resultado medible (renovación de 2 años) y muestra liderazgo en crisis.',
          ),
        ],
      ),
      Phrase(
        id: 'bei4-8',
        idiom: 'Do you have any questions for us?',
        literalTranslation: '¿Tienes alguna pregunta para nosotros?',
        realMeaning:
            'NO decir "no" nunca. Es tu última oportunidad de mostrar interés real y pensamiento estratégico.',
        category: 'Nivel 104',
        pronunciation: 'du yu jav eni kweschons for as',
        contextExamples: [
          ContextExample(
            emoji: '🚫',
            context: 'Respuesta cliché',
            englishExample:
                "No, I think you covered everything. Thanks!",
            pronunciation: "no, ai zink yu koverd evriziing",
            spanishExample:
                'No, creo que cubrieron todo. ¡Gracias!',
          ),
          ContextExample(
            emoji: '✅',
            context: 'Respuesta modelo',
            englishExample:
                "Yes — what qualities do your top performers in this role share? And what are the first 90-day priorities you'd expect from whoever fills this position?",
            pronunciation: "yes — wot kwolitis du yor top performers...",
            spanishExample:
                'Sí — ¿qué cualidades comparten tus mejores empleados en este puesto? ¿Y cuáles son las prioridades de los primeros 90 días que esperarías de quien ocupe esta posición?',
          ),
          ContextExample(
            emoji: '🎯',
            context: 'Por qué funciona',
            englishExample:
                "Shows you think like someone already in the role. Gets insider info you can use to close stronger.",
            pronunciation: "shous yu zink laik somwan olredi in de rol",
            spanishExample:
                'Muestra que ya piensas como alguien en el puesto. Obtienes info interna que puedes usar para cerrar con fuerza.',
          ),
        ],
      ),
    ];
  }

  static String getDailyChallenge() {
    return '''
🎤 DESAFÍO: MASTER THE 8 KEY QUESTIONS

1️⃣ **Graba tu respuesta modelo a cada pregunta (60 seg máx cada una).**

2️⃣ **Compara con la versión cliché:**
   • ¿Estás cayendo en alguna frase genérica?
   • ¿Tus respuestas tienen números o solo adjetivos?

3️⃣ **Para cada pregunta, escribe TU versión con:**
   ✅ Tu historia real (no inventada)
   ✅ Una métrica concreta o resultado
   ✅ Cierre que conecta contigo y el puesto

4️⃣ **Revisa con ChatGPT:** pega tus 8 respuestas y pide:
   "Make this more concise and professional. Keep the specific metrics."

🎯 META: Que ninguna respuesta suene a cliché y que todas tengan un número o resultado medible.
''';
  }
}
