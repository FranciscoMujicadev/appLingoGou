// Archivo: lib/core/models/category_model.dart

import 'package:flutter/material.dart';
import '../../domain/entities/category_entity.dart';

class CategoryModel {
  final String name;
  final IconData icon;

  const CategoryModel({required this.name, required this.icon});

  // Convertir de Model a Entity
  CategoryEntity toEntity() {
    return CategoryEntity(name: name, icon: icon);
  }
}
