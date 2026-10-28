import 'package:estate_pro/features/about/presentation/pages/about_page.dart';
import 'package:estate_pro/features/about/presentation/pages/contact_page.dart';
import 'package:estate_pro/features/auth/presentation/pages/login_page.dart';
import 'package:estate_pro/features/widgets/custom_appbar.dart';
import 'package:estate_pro/features/widgets/custom_drawer.dart';
import 'package:estate_pro/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppbar(title: 'Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          children: [
            // USER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/admin_avatar.jpg',
                      width: 84,
                      height: 84,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 84,
                        height: 84,
                        color: AppColors.secondary,
                        child: const Icon(
                          Icons.person,
                          color: AppColors.white,
                          size: 44,
                        ),
                      ),
                    ),
                  ),
                  const Gap(12),
                  const Text(
                    'Nawar Aln',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const Gap(4),
                  const Text(
                    'nawar@estatepro.com',
                    style: TextStyle(fontSize: 13, color: Color(0xFF9FB0C3)),
                  ),
                ],
              ),
            ),
            const Gap(20),

            _menuTile(
              context,
              icon: Icons.info_outline,
              title: 'About Us',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutPage()),
              ),
            ),
            const Gap(12),
            _menuTile(
              context,
              icon: Icons.support_agent_outlined,
              title: 'Contact Us',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ContactPage()),
              ),
            ),
            const Gap(12),
            _menuTile(
              context,
              icon: Icons.space_dashboard_outlined,
              title: 'Admin Dashboard',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminPageFrame(index: 0),
                ),
              ),
            ),
            const Gap(12),
            _menuTile(
              context,
              icon: Icons.logout,
              title: 'Logout',
              color: AppColors.error,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    final fg = color ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (color ?? AppColors.gold).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: fg, size: 20),
            ),
            const Gap(14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: AppColors.light,
            ),
          ],
        ),
      ),
    );
  }
}