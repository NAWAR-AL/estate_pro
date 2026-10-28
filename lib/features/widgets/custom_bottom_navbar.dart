import 'package:estate_pro/features/blog/presentation/pages/blog_page.dart';
import 'package:estate_pro/features/pages/profile_page.dart';
import 'package:estate_pro/features/properties/presentation/pages/properties_page.dart';
import 'package:estate_pro/features/service/presentation/pages/services_page.dart';
import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int _currentIndex = 0;

  Future<void> _onTap(int index) async {
    if (index == _currentIndex) return;

    Widget? page;
    switch (index) {
      case 1:
        page = const PropertiesPage();
        break;
      case 2:
        page = const ServicesPage();
        break;
      case 3:
        page = const BlogPage();
        break;
      case 4:
        page = const ProfilePage();
        break;
    }

    if (page == null) return;

    setState(() => _currentIndex = index);
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page!),
    );
    if (mounted) {
      setState(() => _currentIndex = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <_NavItem>[
      _NavItem(icon: Icons.home, label: 'Home'),
      _NavItem(icon: Icons.apartment_outlined, label: 'Properties'),
      _NavItem(icon: Icons.miscellaneous_services_outlined, label: 'Services'),
      _NavItem(icon: Icons.article_outlined, label: 'Blog'),
      _NavItem(icon: Icons.more_horiz, label: 'More'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < items.length; i++)
                _buildItem(items[i], i == _currentIndex, () => _onTap(i)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(_NavItem item, bool isSelected, VoidCallback onTap) {
    final color = isSelected ? const Color(0xFFB88A58) : const Color(0xFF8A9BA9);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(item.icon, color: color, size: 24),
          const SizedBox(height: 3),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}