import 'package:estate_pro/core/auth/role_manager.dart';
import 'package:estate_pro/features/dashbord/admin/presentation/pages/admin_dashbord_page.dart';
import 'package:estate_pro/features/dashbord/admin/presentation/pages/blog_managment_page.dart';
import 'package:estate_pro/features/dashbord/admin/presentation/pages/message_page.dart';
import 'package:estate_pro/features/dashbord/admin/presentation/pages/properties_managment_page.dart';
import 'package:estate_pro/features/dashbord/admin/presentation/pages/services_managment_page.dart';
import 'package:estate_pro/features/dashbord/admin/presentation/pages/users_managment_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


/// Same brand palette as every admin page: deep navy + brass.
class _C {
  static const navy = Color(0xFF0B1F33);
  static const navyDeep = Color(0xFF07182A);
  static const gold = Color(0xFFAE8657);
  static const goldBright = Color(0xFFD4AF37);
  static const bg = Color(0xFFF6F5F1);
  static const mutedOnNavy = Color(0xFF9FB0C3);
  static const success = Color(0xFF0E9F6E);
  static const softRed = Color(0xFFF59A9A);
}

TextStyle _title(double size, {Color color = Colors.white, double? height}) =>
    GoogleFonts.playfairDisplay(fontSize: size, fontWeight: FontWeight.w700, color: color, height: height);

// ───────────────────────── Pages in the drawer ─────────────────────────

class _Dest {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String section;
  final int badge;
  final Widget Function() page;

  const _Dest(this.label, this.icon, this.activeIcon, this.section, this.page, {this.badge = 0});
}

// The order here is the order in the drawer. Badge numbers are samples.
final _destinations = <_Dest>[
  _Dest('Dashboard', Icons.space_dashboard_outlined, Icons.space_dashboard_rounded, 'Overview',
      () => const AdminDashboardPage()),
  _Dest('Properties', Icons.home_work_outlined, Icons.home_work_rounded, 'Portfolio',
      () => const PropertiesManagementPage()),
  _Dest('Services', Icons.room_service_outlined, Icons.room_service_rounded, 'Portfolio',
      () => const ServicesManagementPage()),
  _Dest('Blog', Icons.auto_stories_outlined, Icons.auto_stories_rounded, 'Content',
      () => const BlogManagementPage()),
  _Dest('Messages', Icons.forum_outlined, Icons.forum_rounded, 'People',
      () => const MessagePage(), badge: 6),
  _Dest('Users', Icons.group_outlined, Icons.group_rounded, 'People',
      () => const UsersManagementPage(), badge: 2),
];

/// Opens the page at [index] in place of the current one, with a soft fade.
void _goTo(BuildContext context, int index) {
  debugPrint('☰ Drawer: opening ${_destinations[index].label}');
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (_, __, ___) => AdminPageFrame(index: index),
      transitionsBuilder: (_, anim, __, child) =>
          FadeTransition(opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut), child: child),
    ),
  );
}

Widget _branded(BuildContext context, Widget child) {
  final base = Theme.of(context);
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Theme(
      data: base.copyWith(textTheme: GoogleFonts.montserratTextTheme(base.textTheme)),
      child: child,
    ),
  );
}

// ───────────────────────── The drawer ─────────────────────────

/// The luxurious side menu with every admin page.
/// Tap a page name and that page opens.
///
/// Use it in any Scaffold:  `drawer: const AdminDrawer()`
/// [current] highlights the page you are on (-1 = none).
class AdminDrawer extends StatelessWidget {
  final int current;

  const AdminDrawer({super.key, this.current = -1});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 308,
      backgroundColor: _C.navy,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(34)),
      ),
      child: _branded(
        context,
        _Sidebar(
          selected: current,
          onClose: () => Scaffold.of(context).closeDrawer(),
          onSelect: (i) {
            Scaffold.of(context).closeDrawer();
            _goTo(context, i);
          },
        ),
      ),
    );
  }
}

/// Shows one admin page with the drawer attached, so the ☰ button on the
/// page opens the drawer. On wide screens (web, tablet) the drawer stays
/// open as a permanent sidebar.
///
/// Start the app with:  `home: const AdminPageFrame(index: 0)`
class AdminPageFrame extends StatelessWidget {
  final int index;

  const AdminPageFrame({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    if (!RoleManager.isAdmin) {
      return Scaffold(
        backgroundColor: _C.bg,
        appBar: AppBar(
          backgroundColor: _C.navy,
          foregroundColor: Colors.white,
          title: const Text('Access Denied'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, size: 56, color: _C.navy),
                const SizedBox(height: 16),
                Text(
                  'Admin access only',
                  style: _title(22, color: _C.navy),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This area is available for administrator accounts only.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _C.navy, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.maybePop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _C.gold,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Go back'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final page = _destinations[index].page();

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 1000;
        return Scaffold(
          backgroundColor: _C.bg,
          drawerScrimColor: _C.navy.withValues(alpha: 0.55),
          drawerEdgeDragWidth: 40,
          drawer: wide ? null : AdminDrawer(current: index),
          body: wide
              ? Row(
                  children: [
                    SizedBox(
                      width: 290,
                      child: _branded(
                        context,
                        _Sidebar(
                          selected: index,
                          onSelect: (i) => _goTo(context, i),
                        ),
                      ),
                    ),
                    Expanded(child: page),
                  ],
                )
              : page,
        );
      },
    );
  }
}

// ───────────────────────── Sidebar ─────────────────────────

class _Sidebar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  final VoidCallback? onClose;

  const _Sidebar({required this.selected, required this.onSelect, this.onClose});

  @override
  Widget build(BuildContext context) {
    // Group destinations by section, keeping their original index.
    final sections = <String, List<int>>{};
    for (var i = 0; i < _destinations.length; i++) {
      sections.putIfAbsent(_destinations[i].section, () => []).add(i);
    }

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_C.navy, _C.navyDeep],
        ),
      ),
      child: Stack(
        children: [
          // Decorative brass rings in the top end corner (mirror in RTL).
          PositionedDirectional(
            end: -90,
            top: -70,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _C.gold.withValues(alpha: 0.12), width: 26),
              ),
            ),
          ),
          PositionedDirectional(
            end: 30,
            top: 120,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _C.goldBright.withValues(alpha: 0.15), width: 1.5),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 18, 14, 0),
                  child: _Brand(onClose: onClose),
                ),
                const SizedBox(height: 22),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 20),
                    children: [
                      const _ProfileCard(),
                      for (final entry in sections.entries) ...[
                        _SectionLabel(entry.key),
                        for (final i in entry.value)
                          _NavTile(
                            dest: _destinations[i],
                            selected: i == selected,
                            onTap: () => onSelect(i),
                          ),
                      ],
                      const SizedBox(height: 22),
                      const _TargetCard(),
                      const SizedBox(height: 14),
                      _FooterTile(icon: Icons.settings_outlined, label: 'Settings', onTap: () {}),
                      _FooterTile(
                        icon: Icons.logout_rounded,
                        label: 'Log out',
                        color: _C.softRed,
                        onTap: () {},
                      ),
                      const SizedBox(height: 14),
                      Center(
                        child: Text(
                          'Estate Pro admin  |  v1.0.0',
                          style: TextStyle(
                            color: _C.mutedOnNavy.withValues(alpha: 0.6),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  final VoidCallback? onClose;

  const _Brand({this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Monogram
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [_C.goldBright, _C.gold],
            ),
            boxShadow: [
              BoxShadow(color: _C.goldBright.withValues(alpha: 0.35), blurRadius: 18, offset: const Offset(0, 6)),
            ],
          ),
          child: Text('EP', style: _title(19, color: _C.navy)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Estate Pro', style: _title(22, height: 1.1)),
              const SizedBox(height: 2),
              const Text(
                'Admin console',
                style: TextStyle(color: _C.goldBright, fontSize: 11.5, fontWeight: FontWeight.w700, letterSpacing: 0.4),
              ),
            ],
          ),
        ),
        if (onClose != null)
          Material(
            color: Colors.white.withValues(alpha: 0.07),
            shape: const CircleBorder(),
            child: IconButton(
              tooltip: 'Close menu',
              onPressed: onClose,
              icon: const Icon(Icons.close_rounded, color: _C.mutedOnNavy, size: 20),
            ),
          ),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [_C.goldBright, _C.gold]),
                ),
                child: ClipOval(
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: Image.asset(
                      'assets/images/admin_avatar.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const ColoredBox(
                        color: Color(0xFF17324F),
                        child: Center(
                          child: Text('AP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                end: 0,
                bottom: 0,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: _C.success,
                    shape: BoxShape.circle,
                    border: Border.all(color: _C.navy, width: 2.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmed Pasha',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.verified_rounded, size: 13, color: _C.goldBright),
                    SizedBox(width: 4),
                    Text(
                      'Super admin',
                      style: TextStyle(color: _C.goldBright, fontSize: 11.5, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.unfold_more_rounded, color: _C.mutedOnNavy, size: 20),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 22, 12, 8),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: _C.mutedOnNavy.withValues(alpha: 0.75),
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Container(height: 1, color: Colors.white.withValues(alpha: 0.06))),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final _Dest dest;
  final bool selected;
  final VoidCallback onTap;

  const _NavTile({required this.dest, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          splashColor: _C.gold.withValues(alpha: 0.15),
          highlightColor: Colors.white.withValues(alpha: 0.04),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsetsDirectional.fromSTEB(10, 9, 12, 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: selected
                  ? LinearGradient(
                      begin: AlignmentDirectional.centerStart,
                      end: AlignmentDirectional.centerEnd,
                      colors: [_C.gold.withValues(alpha: 0.32), _C.gold.withValues(alpha: 0.05)],
                    )
                  : null,
              border: Border.all(
                color: selected ? _C.goldBright.withValues(alpha: 0.35) : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 260),
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: selected
                        ? const LinearGradient(
                            begin: AlignmentDirectional.topStart,
                            end: AlignmentDirectional.bottomEnd,
                            colors: [_C.goldBright, _C.gold],
                          )
                        : null,
                    color: selected ? null : Colors.white.withValues(alpha: 0.06),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: _C.goldBright.withValues(alpha: 0.35),
                              blurRadius: 14,
                              offset: const Offset(0, 5),
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    selected ? dest.activeIcon : dest.icon,
                    size: 20,
                    color: selected ? _C.navy : _C.mutedOnNavy,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                      color: selected ? Colors.white : _C.mutedOnNavy,
                    ),
                    child: Text(dest.label),
                  ),
                ),
                if (dest.badge > 0)
                  Container(
                    constraints: const BoxConstraints(minWidth: 24),
                    height: 22,
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected ? _C.navy : _C.goldBright,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Text(
                      '${dest.badge}',
                      style: TextStyle(
                        color: selected ? _C.goldBright : _C.navy,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                else if (selected)
                  const Icon(Icons.chevron_right_rounded, color: _C.goldBright, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TargetCard extends StatelessWidget {
  const _TargetCard();

  // Sample monthly sales target: replace with your API.
  static const _progress = 0.78;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [_C.gold.withValues(alpha: 0.25), _C.gold.withValues(alpha: 0.06)],
        ),
        border: Border.all(color: _C.goldBright.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.emoji_events_rounded, color: _C.goldBright, size: 18),
              SizedBox(width: 8),
              Text(
                'Monthly sales target',
                style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$1.17M', style: _title(22, color: _C.goldBright, height: 1)),
              const SizedBox(width: 6),
              const Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Text(
                  'of \$1.5M',
                  style: TextStyle(color: _C.mutedOnNavy, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(),
              Text(
                '${(_progress * 100).round()}%',
                style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: _progress),
              duration: const Duration(milliseconds: 1100),
              curve: Curves.easeOutCubic,
              builder: (_, v, __) => LinearProgressIndicator(
                value: v,
                minHeight: 7,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                valueColor: const AlwaysStoppedAnimation(_C.goldBright),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _FooterTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = _C.mutedOnNavy,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 12, 12),
          child: Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 14),
              Text(label, style: TextStyle(color: color, fontSize: 13.5, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}