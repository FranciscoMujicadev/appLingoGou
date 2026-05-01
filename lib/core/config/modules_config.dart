// lib/core/config/modules_config.dart
//
// Archivo central de módulos. Para agregar un nuevo módulo:
//   1. Crea el datasource en lib/data/datasources/days/
//   2. Regístralo en phrases_datasource.dart (niveles 111-120, etc.)
//   3. Agrega un AppModule aquí.

import 'package:flutter/material.dart';
import '../models/module_model.dart';

const List<AppModule> kAppModules = [
  AppModule(
    id: 'coloquial',
    name: 'Inglés Coloquial',
    description: 'Frases cotidianas, expresiones y conversaciones del día a día',
    icon: Icons.chat_bubble_rounded,
    color: Color(0xFF58CC02),
    startLevel: 1,
    endLevel: 100,
    sections: [
      ModuleSection(title: 'Saludos y presentaciones',  color: Color(0xFF58CC02)),
      ModuleSection(title: 'Vocabulario básico',        color: Color(0xFF6C63FF)),
      ModuleSection(title: 'Gramática esencial',        color: Color(0xFF1CB0F6)),
      ModuleSection(title: 'Conversación cotidiana',    color: Color(0xFFFF9600)),
      ModuleSection(title: 'Expresiones comunes',       color: Color(0xFFFF4B4B)),
      ModuleSection(title: 'Vocabulario avanzado',      color: Color(0xFF2AC3A2)),
      ModuleSection(title: 'Situaciones reales',        color: Color(0xFFCE82FF)),
      ModuleSection(title: 'Fluidez y naturalidad',     color: Color(0xFFFFC107)),
      ModuleSection(title: 'Comprensión avanzada',      color: Color(0xFF9B59B6)),
      ModuleSection(title: 'Dominio del inglés',        color: Color(0xFF3498DB)),
    ],
  ),
  AppModule(
    id: 'business_interviews',
    name: 'Business English',
    description: 'Job Interviews — vocabulario ejecutivo para entrevistas internacionales',
    icon: Icons.work_rounded,
    color: Color(0xFF0D47A1),
    startLevel: 101,
    endLevel: 110,
    sections: [
      ModuleSection(
        title: 'Interview Preparation',
        color: Color(0xFF0D47A1),
      ),
    ],
  ),
];
