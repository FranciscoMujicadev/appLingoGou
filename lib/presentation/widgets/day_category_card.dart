// Archivo: lib/presentation/widgets/day_category_card.dart

import 'package:flutter/material.dart';

class DayCategoryCard extends StatelessWidget {
  final String dayName;
  final IconData icon;
  final bool isUnlocked;
  final bool isCompleted;
  final int progressPercentage;
  final VoidCallback? onTap;

  const DayCategoryCard({
    super.key,
    required this.dayName,
    required this.icon,
    required this.isUnlocked,
    required this.isCompleted,
    required this.progressPercentage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isUnlocked ? 4 : 1,
      color: isUnlocked ? Colors.white : Colors.grey[300],
      child: InkWell(
        onTap: isUnlocked ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    icon,
                    size: 48,
                    color: isUnlocked ? Colors.blue : Colors.grey,
                  ),
                  if (!isUnlocked)
                    const Icon(Icons.lock, size: 24, color: Colors.grey),
                  if (isCompleted)
                    const Positioned(
                      right: 0,
                      top: 0,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                dayName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isUnlocked ? Colors.black : Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              if (isUnlocked && !isCompleted) ...[
                LinearProgressIndicator(
                  value: progressPercentage / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                Text(
                  '$progressPercentage%',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
              if (!isUnlocked)
                Text(
                  'Bloqueado',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
