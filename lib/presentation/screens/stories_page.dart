import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/datasources/stories_data.dart';
import '../../data/models/story_model.dart';
import '../../providers/theme_provider.dart';
import '../widgets/story_card.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({super.key});

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage>
    with AutomaticKeepAliveClientMixin {
  String _selectedFilter = 'Beginner';
  List<StoryModel> _filteredStories = [];

  // 🆕 ScrollController para controlar el scroll
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _filteredStories = StoriesData.getStoriesByLevel('Beginner');

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _filterStories(String filter) {
    setState(() {
      _selectedFilter = filter;
      if (filter == 'Beginner' ||
          filter == 'Intermediate' ||
          filter == 'Advanced') {
        _filteredStories = StoriesData.getStoriesByLevel(filter);
      } else {
        _filteredStories = StoriesData.getStoriesByCategory(filter);
      }
    });

    // 🆕 Volver al inicio del scroll
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Color _getFilterColor(String filter) {
    switch (filter) {
      case 'Beginner':
        return const Color(0xFF6FBAFF);
      case 'Intermediate':
        return const Color(0xFF7BDCB5);
      case 'Advanced':
        return const Color(0xFF6FBAFF);
      case 'Daily Life':
        return const Color(0xFF7BDCB5);
      case 'Friendship':
        return const Color(0xFF6FBAFF);
      case 'Life Lessons':
        return const Color(0xFF7BDCB5);
      default:
        return const Color(0xFF6FBAFF);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 8, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LingoGou',
                          style: TextStyle(
                            fontSize: 25.5,
                            fontWeight: FontWeight.w700,
                            color: onSurface,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Read and improve your English',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w400,
                            color: onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, _) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: IconButton(
                          key: ValueKey(themeProvider.isDarkMode),
                          onPressed: themeProvider.toggleTheme,
                          icon: Icon(
                            themeProvider.isDarkMode
                                ? Icons.wb_sunny_rounded
                                : Icons.nightlight_round,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          tooltip: themeProvider.isDarkMode
                              ? 'Modo claro'
                              : 'Modo oscuro',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Filtros
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter by',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: onSurface.withValues(alpha: 0.5),
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('Beginner'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Intermediate'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Advanced'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Daily Life'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Friendship'),
                        const SizedBox(width: 8),
                        _buildFilterChip('Life Lessons'),
                        const SizedBox(width: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Lista de historias con ScrollController
            Expanded(
              child: _filteredStories.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 80,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No stories found',
                            style: TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController, // 🆕 Agregar el controller
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                      itemCount: _filteredStories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: StoryCard(
                            key: ValueKey(
                              'story_${_filteredStories[index].id}',
                            ),
                            story: _filteredStories[index],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    final color = _getFilterColor(label);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return GestureDetector(
      onTap: () => _filterStories(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? color
              : (isDark
                  ? const Color(0xFF2C2C2E)
                  : onSurface.withValues(alpha: 0.08)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? Colors.black
                : onSurface.withValues(alpha: 0.55),
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }
}
