import 'package:flutter/material.dart';

class AnimatedVolumeButton extends StatefulWidget {
  final VoidCallback onTap;

  const AnimatedVolumeButton({super.key, required this.onTap});

  @override
  State<AnimatedVolumeButton> createState() => _AnimatedVolumeButtonState();
}

class _AnimatedVolumeButtonState extends State<AnimatedVolumeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isAnimating = true;
    });

    _controller.forward().then((_) {
      _controller.reverse().then((_) {
        if (mounted) {
          setState(() {
            _isAnimating = false;
          });
        }
      });
    });

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _isAnimating
                    ? Colors.blue.withOpacity(0.8)
                    : Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isAnimating
                      ? Colors.blue.withOpacity(0.5)
                      : Colors.white.withOpacity(0.3),
                  width: _isAnimating ? 2 : 1,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.volume_up, color: Colors.white, size: 24),
                  if (_isAnimating)
                    ...List.generate(3, (index) {
                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Container(
                            width: 50 + (index + 1) * 20 * _controller.value,
                            height: 50 + (index + 1) * 20 * _controller.value,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(
                                  0.3 * (1 - _controller.value),
                                ),
                                width: 1,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
