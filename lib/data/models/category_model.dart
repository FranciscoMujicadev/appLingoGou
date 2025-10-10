import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({required super.name, required super.icon});

  // Crear desde entidad
  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(name: entity.name, icon: entity.icon);
  }

  // Convertir a entidad
  CategoryEntity toEntity() {
    return CategoryEntity(name: name, icon: icon);
  }
}
