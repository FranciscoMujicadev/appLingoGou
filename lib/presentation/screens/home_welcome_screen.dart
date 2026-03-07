import 'package:flutter/material.dart';

class HomeWelcomeScreen extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeWelcomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6B35),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Título
                const Center(
                  child: Text(
                    'LingoGou',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Subtítulo
                const Center(
                  child: Text(
                    'Learn English Every Day',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF98989D),
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // Saludo
                const Text(
                  'Today',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'What do you want to learn?',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF98989D),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 32),

                // Card: Learn
                _buildHeadspaceCard(
                  context: context,
                  icon: Icons.collections_bookmark_rounded,
                  title: 'Learn',
                  description: 'Daily expressions & phrasal verbs',
                  backgroundColor: const Color(0xFF7BDCB5),
                  onTap: () => onNavigate(1),
                ),
                const SizedBox(height: 16),

                // Card: Stories
                _buildHeadspaceCard(
                  context: context,
                  icon: Icons.auto_stories_rounded,
                  title: 'Stories',
                  description: 'Read and listen to English stories',
                  backgroundColor: const Color(0xFF6FBAFF),
                  onTap: () => onNavigate(2),
                ),
                const SizedBox(height: 16),

                // Card: Favorites
                _buildHeadspaceCard(
                  context: context,
                  icon: Icons.favorite_rounded,
                  title: 'Favorites',
                  description: 'Your saved expressions',
                  backgroundColor: const Color(0xFFFF8E9E),
                  onTap: () => onNavigate(3),
                ),
                const SizedBox(height: 40),

                // Footer inspiracional
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B35).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFFF6B35).withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: const Text(
                      '✨ A little progress each day',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFF6B35),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeadspaceCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              // Icono
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, size: 28, color: Colors.white),
              ),
              const SizedBox(width: 20),

              // Texto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              // Flecha
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
