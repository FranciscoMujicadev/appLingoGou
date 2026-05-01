// lib/presentation/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../../providers/premium_provider.dart';
import '../../providers/theme_provider.dart';
import 'activate_premium_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authProvider = context.watch<AuthProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final premiumProvider = context.watch<PremiumProvider>();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // ── Avatar + info ──
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor:
                        isDark ? const Color(0xFF2A2A3E) : const Color(0xFFE8E8F0),
                    backgroundImage: authProvider.user?.photoURL != null
                        ? NetworkImage(authProvider.user!.photoURL!)
                        : null,
                    child: authProvider.user?.photoURL == null
                        ? Icon(
                            Icons.person_rounded,
                            size: 40,
                            color: isDark ? Colors.white54 : Colors.grey,
                          )
                        : null,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    authProvider.user?.displayName ?? 'Usuario',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                    ),
                  ),
                  if (authProvider.user?.email != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      authProvider.user!.email!,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white54 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── Opciones ──
            _buildOptionTile(
              context: context,
              icon: Icons.dark_mode_rounded,
              title: 'Modo oscuro',
              isDark: isDark,
              trailing: Switch.adaptive(
                value: themeProvider.isDarkMode,
                onChanged: (_) => themeProvider.toggleTheme(),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),

            _buildOptionTile(
              context: context,
              icon: premiumProvider.isPremium
                  ? Icons.verified_rounded
                  : Icons.workspace_premium_rounded,
              title: premiumProvider.isPremium
                  ? 'Premium activo${premiumProvider.businessName != null ? ' · ${premiumProvider.businessName}' : ''}'
                  : 'Activar Premium (sin anuncios)',
              isDark: isDark,
              iconColor: premiumProvider.isPremium ? Colors.green : null,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ActivatePremiumScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            if (!authProvider.isSignedIn)
              _buildOptionTile(
                context: context,
                icon: Icons.login_rounded,
                title: 'Iniciar sesión con Google',
                isDark: isDark,
                onTap: () => authProvider.signInWithGoogle(),
              )
            else
              _buildOptionTile(
                context: context,
                icon: Icons.logout_rounded,
                title: 'Cerrar sesión',
                isDark: isDark,
                iconColor: Colors.red,
                onTap: () => authProvider.signOut(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required bool isDark,
    Widget? trailing,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? Theme.of(context).colorScheme.primary, size: 24),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : const Color(0xFF1A1A2E),
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
