import 'package:flutter/material.dart';
import '../../domain/entities/category_entity.dart';

class CategoryFilters extends StatefulWidget {
  final List<CategoryEntity> categories;
  final String selectedCategory;
  final Function(String) onCategoryChanged;

  const CategoryFilters({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  State<CategoryFilters> createState() => _CategoryFiltersState();
}

class _CategoryFiltersState extends State<CategoryFilters>
    with AutomaticKeepAliveClientMixin<CategoryFilters> {
  late ScrollController _scrollController;
  final Map<String, GlobalKey> _chipKeys = {};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Crear keys para cada categoría
    for (var category in widget.categories) {
      _chipKeys[category.name] = GlobalKey();
    }

    // Scroll inicial al chip seleccionado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ensureSelectedVisible();
    });
  }

  @override
  void didUpdateWidget(CategoryFilters oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si cambió la categoría seleccionada, asegurar que esté visible
    if (oldWidget.selectedCategory != widget.selectedCategory) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _ensureSelectedVisible();
      });
    }
  }

  void _ensureSelectedVisible() {
    final selectedKey = _chipKeys[widget.selectedCategory];
    if (selectedKey?.currentContext == null) return;
    if (!_scrollController.hasClients) return;

    try {
      final RenderBox renderBox =
          selectedKey!.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final chipWidth = renderBox.size.width;
      final screenWidth = MediaQuery.of(context).size.width;

      // Posición actual del chip en pantalla
      final chipStart = position.dx;
      final chipEnd = chipStart + chipWidth;

      // Si el chip está fuera de la vista, hacer scroll
      if (chipStart < 20) {
        // Chip cortado por la izquierda
        final targetScroll = _scrollController.offset + chipStart - 20;
        _scrollController.animateTo(
          targetScroll.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else if (chipEnd > screenWidth - 20) {
        // Chip cortado por la derecha
        final targetScroll =
            _scrollController.offset + (chipEnd - screenWidth + 20);
        _scrollController.animateTo(
          targetScroll.clamp(0.0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } catch (e) {
      // Si hay algún error, no hacer nada
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SizedBox(
      height: 50,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: widget.categories.length,
        physics: const BouncingScrollPhysics(), // ← Permite scroll normal
        itemBuilder: (context, index) {
          final category = widget.categories[index];
          final isSelected = widget.selectedCategory == category.name;

          return Padding(
            key: _chipKeys[category.name], // ← Key para encontrar posición
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => widget.onCategoryChanged(category.name),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue
                      : Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected
                        ? Colors.lightBlueAccent
                        : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: isSelected
                      ? [
                          const BoxShadow(
                            color: Colors.blue,
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category.icon,
                      color: isSelected ? Colors.white : Colors.grey[600],
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category.name,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[600],
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
