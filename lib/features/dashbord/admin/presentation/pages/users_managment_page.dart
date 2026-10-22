import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography: Playfair Display for titles, Montserrat for text and buttons.
/// Same brand palette as the other admin pages: deep navy + brass.
class _C {
  static const navy = Color(0xFF0B1F33);
  static const navySoft = Color(0xFF17324F);
  static const gold = Color(0xFFAE8657);
  static const goldBright = Color(0xFFD4AF37);
  static const bg = Color(0xFFF6F5F1);
  static const surface = Colors.white;
  static const muted = Color(0xFF64748B);
  static const mutedOnNavy = Color(0xFF9FB0C3);
  static const border = Color(0xFFE8E3D9);
  static const track = Color(0xFFF1EFEA);
  static const success = Color(0xFF0E9F6E);
  static const danger = Color(0xFFDC2626);
  static const pending = Color(0xFFB7791F);
  static const info = Color(0xFF3B5B8C);
  static const silver = Color(0xFFB9C2CC);
  static const bronze = Color(0xFFB07A4F);
}

/// New avatars live in `assets/images/users/`.
/// The rest reuse the avatars from the messages page and the dashboard.
class _Img {
  static const admin = 'assets/images/admin_avatar.jpg';
  static const leyla = 'assets/images/messages/leyla.jpg';
  static const mehmet = 'assets/images/messages/mehmet.jpg';
  static const sophie = 'assets/images/messages/sophie.jpg';
  static const omar = 'assets/images/messages/omar.jpg';
  static const james = 'assets/images/messages/james.jpg';
  static const aisha = 'assets/images/messages/aisha.jpg';
  static const daniel = 'assets/images/messages/daniel.jpg';
  static const elena = 'assets/images/messages/elena.jpg';
  static const zeynep = 'assets/images/users/zeynep.jpg';
  static const karim = 'assets/images/users/karim.jpg';
  static const olivia = 'assets/images/users/olivia.jpg';
  static const hassan = 'assets/images/users/hassan.jpg';
  static const mia = 'assets/images/users/mia.jpg';
  static const lucas = 'assets/images/users/lucas.jpg';
}

TextStyle _title(double size, {Color color = _C.navy, double? height}) =>
    GoogleFonts.playfairDisplay(fontSize: size, fontWeight: FontWeight.w700, color: color, height: height);

/// Brand fonts + English left-to-right, for this page and its sheets.
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

String _initials(String name) =>
    name.trim().split(RegExp(r'\s+')).take(2).map((p) => p[0].toUpperCase()).join();

// ───────────────────────── Model ─────────────────────────

enum _Role { admin, agent, investor, buyer }

extension _RoleX on _Role {
  String get label => switch (this) {
        _Role.admin => 'Admin',
        _Role.agent => 'Agent',
        _Role.investor => 'Investor',
        _Role.buyer => 'Buyer',
      };

  String get plural => switch (this) {
        _Role.admin => 'Admins',
        _Role.agent => 'Agents',
        _Role.investor => 'Investors',
        _Role.buyer => 'Buyers',
      };

  Color get color => switch (this) {
        _Role.admin => _C.navy,
        _Role.agent => _C.success,
        _Role.investor => _C.info,
        _Role.buyer => _C.gold,
      };

  IconData get icon => switch (this) {
        _Role.admin => Icons.admin_panel_settings_rounded,
        _Role.agent => Icons.badge_rounded,
        _Role.investor => Icons.trending_up_rounded,
        _Role.buyer => Icons.home_rounded,
      };
}

enum _Status { active, pending, suspended }

class _User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final String location;
  final String joined;
  final String lastActive;
  final bool online;
  final int listings;
  final int deals;
  _Role role;
  _Status status;
  bool verified;

  _User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.location,
    required this.joined,
    required this.lastActive,
    required this.role,
    this.online = false,
    this.listings = 0,
    this.deals = 0,
    this.status = _Status.active,
    this.verified = false,
  });
}

// Sample users: replace with your API.
List<_User> _seed() => [
      _User(
        id: 'u1', name: 'Ahmed Pasha', email: 'ahmed@estatepro.com', phone: '+90 532 000 1001',
        avatar: _Img.admin, location: 'Istanbul', joined: 'Jan 2024', lastActive: 'Now',
        role: _Role.admin, online: true, verified: true,
      ),
      _User(
        id: 'u2', name: 'Leyla Demir', email: 'leyla@estatepro.com', phone: '+90 532 000 1002',
        avatar: _Img.leyla, location: 'Istanbul', joined: 'Feb 2024', lastActive: 'Now',
        role: _Role.agent, online: true, verified: true, listings: 18, deals: 42,
      ),
      _User(
        id: 'u3', name: 'Mehmet Arslan', email: 'mehmet@estatepro.com', phone: '+90 532 000 1003',
        avatar: _Img.mehmet, location: 'Antalya', joined: 'Mar 2024', lastActive: '2h ago',
        role: _Role.agent, verified: true, listings: 14, deals: 35,
      ),
      _User(
        id: 'u4', name: 'Hassan Ali', email: 'hassan@estatepro.com', phone: '+90 532 000 1004',
        avatar: _Img.hassan, location: 'Bodrum', joined: 'May 2024', lastActive: '20m ago',
        role: _Role.agent, online: true, verified: true, listings: 9, deals: 21,
      ),
      _User(
        id: 'u5', name: 'Zeynep Kaya', email: 'zeynep.kaya@mail.com', phone: '+90 533 210 4455',
        avatar: _Img.zeynep, location: 'Izmir', joined: 'Today', lastActive: '1h ago',
        role: _Role.agent, status: _Status.pending, listings: 3,
      ),
      _User(
        id: 'u6', name: 'Karim Nasser', email: 'karim.nasser@mail.com', phone: '+90 534 118 2290',
        avatar: _Img.karim, location: 'Istanbul', joined: 'Yesterday', lastActive: '5h ago',
        role: _Role.agent, status: _Status.pending, listings: 1,
      ),
      _User(
        id: 'u7', name: 'Sophie Laurent', email: 'sophie.laurent@mail.fr', phone: '+33 6 12 34 56 78',
        avatar: _Img.sophie, location: 'Paris', joined: 'Aug 2025', lastActive: 'Now',
        role: _Role.buyer, online: true, verified: true,
      ),
      _User(
        id: 'u8', name: 'Omar Haddad', email: 'omar.haddad@mail.com', phone: '+971 50 123 4567',
        avatar: _Img.omar, location: 'Dubai', joined: 'Jun 2025', lastActive: 'Now',
        role: _Role.investor, online: true, verified: true, deals: 3,
      ),
      _User(
        id: 'u9', name: 'Mia Schneider', email: 'mia.schneider@mail.de', phone: '+49 151 2345 6789',
        avatar: _Img.mia, location: 'Berlin', joined: 'Sep 2025', lastActive: '3d ago',
        role: _Role.investor, verified: true, deals: 2,
      ),
      _User(
        id: 'u10', name: 'James Whitfield', email: 'j.whitfield@mail.co.uk', phone: '+44 7700 900123',
        avatar: _Img.james, location: 'London', joined: 'Jul 2025', lastActive: '2h ago',
        role: _Role.buyer,
      ),
      _User(
        id: 'u11', name: 'Aisha Rahman', email: 'aisha.rahman@mail.com', phone: '+966 55 123 4567',
        avatar: _Img.aisha, location: 'Riyadh', joined: 'Apr 2025', lastActive: 'Now',
        role: _Role.buyer, online: true, verified: true, deals: 1,
      ),
      _User(
        id: 'u12', name: 'Daniel Kim', email: 'daniel.kim@mail.com', phone: '+82 10 1234 5678',
        avatar: _Img.daniel, location: 'Seoul', joined: 'Mar 2025', lastActive: 'Mon',
        role: _Role.investor, verified: true, deals: 4,
      ),
      _User(
        id: 'u13', name: 'Lucas Moreau', email: 'lucas.moreau@mail.fr', phone: '+33 7 98 76 54 32',
        avatar: _Img.lucas, location: 'Lyon', joined: 'Sep 2025', lastActive: '1w ago',
        role: _Role.buyer,
      ),
      _User(
        id: 'u14', name: 'Elena Petrova', email: 'elena.p@mail.com', phone: '+7 916 123 4567',
        avatar: _Img.elena, location: 'Moscow', joined: 'Feb 2025', lastActive: '2w ago',
        role: _Role.buyer, verified: true, deals: 1,
      ),
      _User(
        id: 'u15', name: 'Olivia Bennett', email: 'olivia.b@mail.com', phone: '+1 415 555 0134',
        avatar: _Img.olivia, location: 'San Francisco', joined: 'May 2025', lastActive: '1mo ago',
        role: _Role.buyer, status: _Status.suspended,
      ),
    ];

enum _Filter { all, agents, buyers, investors, admins, suspended }

extension _FilterX on _Filter {
  String get label => switch (this) {
        _Filter.all => 'All',
        _Filter.agents => 'Agents',
        _Filter.buyers => 'Buyers',
        _Filter.investors => 'Investors',
        _Filter.admins => 'Admins',
        _Filter.suspended => 'Suspended',
      };
}

// ───────────────────────── Page ─────────────────────────

class UsersManagementPage extends StatefulWidget {
  /// Optional: your own handler to open the drawer. If null, the page opens
  /// the nearest Scaffold that has a drawer.
  final VoidCallback? onMenuTap;

  /// Optional: open your "invite user" flow.
  final VoidCallback? onInvite;

  const UsersManagementPage({super.key, this.onMenuTap, this.onInvite});

  @override
  State<UsersManagementPage> createState() => _UsersManagementPageState();
}

class _UsersManagementPageState extends State<UsersManagementPage> {
  final List<_User> _users = _seed();
  _Filter _filter = _Filter.all;
  String _query = '';

  bool _passes(_User u, _Filter f) => switch (f) {
        _Filter.all => true,
        _Filter.agents => u.role == _Role.agent,
        _Filter.buyers => u.role == _Role.buyer,
        _Filter.investors => u.role == _Role.investor,
        _Filter.admins => u.role == _Role.admin,
        _Filter.suspended => u.status == _Status.suspended,
      };

  List<_User> get _pending => _users.where((u) => u.status == _Status.pending).toList();

  List<_User> get _topAgents {
    final agents = _users.where((u) => u.role == _Role.agent && u.status == _Status.active).toList()
      ..sort((a, b) => b.deals.compareTo(a.deals));
    return agents.take(3).toList();
  }

  // ───────────── Actions ─────────────

  void _approve(_User u) {
    setState(() {
      u.status = _Status.active;
      u.verified = true;
    });
    _toast('${u.name} is now verified');
  }

  void _reject(_User u) {
    final i = _users.indexOf(u);
    if (i < 0) return;
    setState(() => _users.removeAt(i));
    _toast('Application rejected', onUndo: () => setState(() => _users.insert(i, u)));
  }

  void _remove(_User u) {
    final i = _users.indexOf(u);
    if (i < 0) return;
    setState(() => _users.removeAt(i));
    _toast('${u.name} removed', onUndo: () => setState(() => _users.insert(i, u)));
  }

  Future<void> _openProfile(_User u) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: _C.navy.withValues(alpha: 0.55),
      builder: (ctx) => _branded(ctx, _ProfileSheet(user: u)),
    );
    if (!mounted) return;
    if (result == 'delete') {
      _remove(u);
    } else {
      setState(() {});
    }
  }

  Future<void> _openQueue() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: _C.navy.withValues(alpha: 0.55),
      builder: (ctx) => _branded(
        ctx,
        _QueueSheet(
          users: _pending,
          onApprove: _approve,
          onReject: _reject,
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  void _toast(String message, {VoidCallback? onUndo}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(fontWeight: FontWeight.w700)),
          behavior: SnackBarBehavior.floating,
          backgroundColor: _C.navy,
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 90),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          action: onUndo == null
              ? null
              : SnackBarAction(label: 'Undo', textColor: _C.goldBright, onPressed: onUndo),
        ),
      );
  }

  // ───────────── Build ─────────────

  @override
  Widget build(BuildContext context) {
    final visible = _users.where((u) {
      if (!_passes(u, _filter)) return false;
      if (_query.isEmpty) return true;
      return u.name.toLowerCase().contains(_query) ||
          u.email.toLowerCase().contains(_query) ||
          u.location.toLowerCase().contains(_query);
    }).toList();
    final pending = _pending;
    final top = _topAgents;

    return _branded(
      context,
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: _C.bg,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: widget.onInvite ?? () {},
            backgroundColor: _C.gold,
            foregroundColor: Colors.white,
            elevation: 6,
            shape: const StadiumBorder(),
            icon: const Icon(Icons.person_add_alt_1_rounded),
            label: const Text('Invite user', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _Header(onMenuTap: widget.onMenuTap)),
              if (pending.isNotEmpty)
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  sliver: SliverToBoxAdapter(child: _QueueBanner(users: pending, onTap: _openQueue)),
                ),
              if (top.length == 3) ...[
                const _SliverTitle(title: 'Top agents', subtitle: 'Ranked by closed deals this year'),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  sliver: SliverToBoxAdapter(child: _Podium(agents: top, onTap: _openProfile)),
                ),
              ],
              _SliverTitle(title: 'All members', subtitle: '${visible.length} shown'),
              SliverPadding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 14),
                sliver: SliverToBoxAdapter(
                  child: _SearchField(onChanged: (v) => setState(() => _query = v.trim().toLowerCase())),
                ),
              ),
              SliverToBoxAdapter(
                child: _FilterBar(
                  selected: _filter,
                  counts: {for (final f in _Filter.values) f: _users.where((u) => _passes(u, f)).length},
                  onSelected: (f) => setState(() => _filter = f),
                ),
              ),
              if (visible.isEmpty)
                const SliverToBoxAdapter(child: _EmptyState())
              else
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 110),
                  sliver: SliverList.separated(
                    itemCount: visible.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => _UserTile(
                      key: ValueKey(visible[i].id),
                      user: visible[i],
                      onTap: () => _openProfile(visible[i]),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── Shared pieces ─────────────────────────

class _SmartImage extends StatelessWidget {
  final String path;
  final Widget fallback;

  const _SmartImage(this.path, {required this.fallback});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, error, __) {
        debugPrint('⚠️ Image failed to load: "$path"  →  $error');
        return fallback;
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  final _User user;
  final double size;
  final bool ring;
  final Color ringColor;
  final Color dotBorder;

  const _Avatar({
    required this.user,
    this.size = 50,
    this.ring = false,
    this.ringColor = _C.gold,
    this.dotBorder = _C.surface,
  });

  @override
  Widget build(BuildContext context) {
    final photo = ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: _SmartImage(
          user.avatar,
          fallback: ColoredBox(
            color: _C.navySoft,
            child: Center(
              child: Text(
                _initials(user.name),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: size * 0.32),
              ),
            ),
          ),
        ),
      ),
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (ring)
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(shape: BoxShape.circle, color: ringColor),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(shape: BoxShape.circle, color: dotBorder),
              child: photo,
            ),
          )
        else
          photo,
        if (user.online)
          PositionedDirectional(
            end: ring ? 3 : 0,
            bottom: ring ? 3 : 0,
            child: Container(
              width: size * 0.26,
              height: size * 0.26,
              decoration: BoxDecoration(
                color: _C.success,
                shape: BoxShape.circle,
                border: Border.all(color: dotBorder, width: 2.5),
              ),
            ),
          ),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _RoundIconButton({required this.icon, required this.tooltip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.08),
      shape: const CircleBorder(),
      child: IconButton(tooltip: tooltip, onPressed: onTap, icon: Icon(icon, color: _C.goldBright)),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;

  const _Tag({required this.text, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(7)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(text, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }
}

class _GoldSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _GoldSwitch({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      thumbColor: const WidgetStatePropertyAll(Colors.white),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected) ? _C.gold : const Color(0xFFCBD5E1),
      ),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
    );
  }
}

class _SliverTitle extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _SliverTitle({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 28, 20, 14),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: _title(21)),
            if (subtitle != null)
              Text(subtitle!, style: const TextStyle(color: _C.muted, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Header ─────────────────────────

class _Header extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const _Header({required this.onMenuTap});

  // Platform-wide totals (sample): replace with your API.
  static const _total = 1420;
  static const _byRole = {
    _Role.buyer: 980,
    _Role.investor: 210,
    _Role.agent: 196,
    _Role.admin: 34,
  };

  static void _openDrawer(BuildContext context) {
    var scaffold = Scaffold.maybeOf(context);
    while (scaffold != null && !scaffold.hasDrawer) {
      scaffold = Scaffold.maybeOf(scaffold.context);
    }
    scaffold?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: _C.navy,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: -90,
            top: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _C.gold.withValues(alpha: 0.13), width: 26),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, top + 14, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _RoundIconButton(
                      icon: Icons.menu_rounded,
                      tooltip: 'Menu',
                      onTap: onMenuTap ?? () => _openDrawer(context),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Community',
                            style: TextStyle(fontSize: 12, color: _C.mutedOnNavy, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text('Users', style: _title(20, color: Colors.white)),
                        ],
                      ),
                    ),
                    _RoundIconButton(icon: Icons.file_download_outlined, tooltip: 'Export list', onTap: () {}),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'The people behind\nevery key handed over.',
                  style: _title(27, color: Colors.white, height: 1.2),
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      colors: [_C.gold.withValues(alpha: 0.28), _C.gold.withValues(alpha: 0.08)],
                    ),
                    border: Border.all(color: _C.goldBright.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Registered members',
                                  style: TextStyle(color: _C.mutedOnNavy, fontSize: 12, fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 4),
                                Text('1,420', style: _title(38, color: _C.goldBright, height: 1.1)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _C.success.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '+86 this month',
                              style: TextStyle(color: Color(0xFF5EE0A8), fontSize: 11, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Animated stacked bar of members by role.
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          height: 10,
                          child: Row(
                            children: [
                              for (final e in _byRole.entries)
                                Expanded(
                                  flex: e.value,
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween(begin: 0, end: 1),
                                    duration: const Duration(milliseconds: 900),
                                    curve: Curves.easeOutCubic,
                                    builder: (_, t, __) => Align(
                                      alignment: AlignmentDirectional.centerStart,
                                      widthFactor: 1,
                                      child: FractionallySizedBox(
                                        widthFactor: t,
                                        child: Container(
                                          margin: const EdgeInsetsDirectional.only(end: 2),
                                          color: _legendColor(e.key),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 14,
                        runSpacing: 8,
                        children: [
                          for (final e in _byRole.entries)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(color: _legendColor(e.key), shape: BoxShape.circle),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${e.key.plural} ${(e.value / _total * 100).round()}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                        ],
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

  // Brighter variants that read well on navy.
  static Color _legendColor(_Role r) => switch (r) {
        _Role.buyer => _C.goldBright,
        _Role.investor => const Color(0xFF7FA6D9),
        _Role.agent => const Color(0xFF5EE0A8),
        _Role.admin => Colors.white,
      };
}

// ───────────────────────── Verification banner ─────────────────────────

class _QueueBanner extends StatelessWidget {
  final List<_User> users;
  final VoidCallback onTap;

  const _QueueBanner({required this.users, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final shown = users.take(3).toList();

    return Material(
      color: _C.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(color: _C.pending.withValues(alpha: 0.4), width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Overlapping avatars
              SizedBox(
                width: 36.0 + (shown.length - 1) * 22,
                height: 40,
                child: Stack(
                  children: [
                    for (var i = 0; i < shown.length; i++)
                      PositionedDirectional(
                        start: i * 22.0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(color: _C.surface, shape: BoxShape.circle),
                          child: _Avatar(user: shown[i], size: 34),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${users.length} ${users.length == 1 ? 'agent awaits' : 'agents await'} verification',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5, color: _C.navy),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Review licences before they can publish',
                      style: TextStyle(color: _C.muted, fontSize: 11.5, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: _C.pending.withValues(alpha: 0.12), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_forward_rounded, size: 18, color: _C.pending),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── Podium ─────────────────────────

class _Podium extends StatelessWidget {
  /// Sorted best-first: [0] = 1st, [1] = 2nd, [2] = 3rd.
  final List<_User> agents;
  final ValueChanged<_User> onTap;

  const _Podium({required this.agents, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 20, 12, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_C.navySoft, _C.navy],
        ),
        boxShadow: [
          BoxShadow(color: _C.navy.withValues(alpha: 0.25), blurRadius: 26, offset: const Offset(0, 14)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 2nd on the start side, 1st in the middle, 3rd on the end side.
          _PodiumSpot(user: agents[1], rank: 2, height: 92, color: _C.silver, onTap: onTap),
          _PodiumSpot(user: agents[0], rank: 1, height: 124, color: _C.goldBright, onTap: onTap),
          _PodiumSpot(user: agents[2], rank: 3, height: 72, color: _C.bronze, onTap: onTap),
        ],
      ),
    );
  }
}

class _PodiumSpot extends StatelessWidget {
  final _User user;
  final int rank;
  final double height;
  final Color color;
  final ValueChanged<_User> onTap;

  const _PodiumSpot({
    required this.user,
    required this.rank,
    required this.height,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final first = rank == 1;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(user),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (first) const Icon(Icons.workspace_premium_rounded, color: _C.goldBright, size: 26),
            if (first) const SizedBox(height: 4),
            _Avatar(user: user, size: first ? 66 : 54, ring: true, ringColor: color, dotBorder: _C.navy),
            const SizedBox(height: 8),
            Text(
              user.name.split(' ').first,
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800),
            ),
            Text(
              '${user.deals} deals',
              style: TextStyle(color: color, fontSize: 11.5, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: height),
              duration: Duration(milliseconds: 700 + rank * 120),
              curve: Curves.easeOutBack,
              builder: (_, h, __) => Container(
                height: h,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [color.withValues(alpha: 0.55), color.withValues(alpha: 0.12)],
                  ),
                  border: Border(top: BorderSide(color: color, width: 3)),
                ),
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 10),
                child: Text('$rank', style: _title(first ? 30 : 24, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Search & filters ─────────────────────────

class _SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const _SearchField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: _C.border),
    );
    return TextField(
      onChanged: onChanged,
      cursorColor: _C.gold,
      style: const TextStyle(color: _C.navy, fontSize: 14, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: 'Search by name, email or city',
        hintStyle: const TextStyle(color: _C.muted, fontSize: 13, fontWeight: FontWeight.w500),
        prefixIcon: const Icon(Icons.search_rounded, color: _C.muted),
        filled: true,
        fillColor: _C.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        enabledBorder: border,
        focusedBorder: border.copyWith(borderSide: const BorderSide(color: _C.gold, width: 1.5)),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final _Filter selected;
  final Map<_Filter, int> counts;
  final ValueChanged<_Filter> onSelected;

  const _FilterBar({required this.selected, required this.counts, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
        itemCount: _Filter.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final f = _Filter.values[i];
          final active = f == selected;
          return GestureDetector(
            onTap: () => onSelected(f),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 8, 0),
              decoration: BoxDecoration(
                color: active ? _C.navy : _C.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: active ? _C.navy : _C.border),
              ),
              child: Row(
                children: [
                  Text(
                    f.label,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: active ? Colors.white : _C.navy),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    constraints: const BoxConstraints(minWidth: 24),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active ? _C.gold : _C.track,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${counts[f] ?? 0}',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: active ? Colors.white : _C.muted),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ───────────────────────── User tile ─────────────────────────

class _UserTile extends StatelessWidget {
  final _User user;
  final VoidCallback onTap;

  const _UserTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final u = user;
    final suspended = u.status == _Status.suspended;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: suspended ? 0.6 : 1,
      child: Material(
        color: _C.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: _C.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(14, 14, 10, 14),
            child: Row(
              children: [
                _Avatar(user: u, size: 50),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              u.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: _C.navy),
                            ),
                          ),
                          if (u.verified) ...[
                            const SizedBox(width: 5),
                            const Icon(Icons.verified_rounded, size: 16, color: _C.gold),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        u.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: _C.muted, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _Tag(text: u.role.label, color: u.role.color, icon: u.role.icon),
                          if (u.status == _Status.pending) ...[
                            const SizedBox(width: 6),
                            const _Tag(text: 'Pending', color: _C.pending),
                          ],
                          if (suspended) ...[
                            const SizedBox(width: 6),
                            const _Tag(text: 'Suspended', color: _C.danger),
                          ],
                          const Spacer(),
                          Icon(
                            Icons.circle,
                            size: 7,
                            color: u.online ? _C.success : _C.border,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            u.online ? 'Online' : u.lastActive,
                            style: const TextStyle(fontSize: 11, color: _C.muted, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right_rounded, color: _C.muted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 120),
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(color: _C.gold.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.group_outlined, color: _C.gold, size: 36),
          ),
          const SizedBox(height: 18),
          Text('No members found', style: _title(21)),
          const SizedBox(height: 6),
          const Text(
            'Try another filter or search term.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _C.muted, height: 1.45),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Sheet frame ─────────────────────────

class _SheetFrame extends StatelessWidget {
  final double initialSize;
  final Widget Function(ScrollController controller) builder;

  const _SheetFrame({required this.builder, this.initialSize = 0.88});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: initialSize,
      minChildSize: 0.45,
      maxChildSize: 0.95,
      builder: (_, scroll) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        child: ColoredBox(color: _C.bg, child: builder(scroll)),
      ),
    );
  }
}

// ───────────────────────── Verification queue sheet ─────────────────────────

class _QueueSheet extends StatefulWidget {
  final List<_User> users;
  final ValueChanged<_User> onApprove;
  final ValueChanged<_User> onReject;

  const _QueueSheet({required this.users, required this.onApprove, required this.onReject});

  @override
  State<_QueueSheet> createState() => _QueueSheetState();
}

class _QueueSheetState extends State<_QueueSheet> {
  late final List<_User> _items = List.of(widget.users);

  void _handle(_User u, bool approve) {
    approve ? widget.onApprove(u) : widget.onReject(u);
    setState(() => _items.remove(u));
    if (_items.isEmpty) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _SheetFrame(
      initialSize: 0.7,
      builder: (scroll) => ListView(
        controller: scroll,
        padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 30),
        children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(color: _C.border, borderRadius: BorderRadius.circular(3)),
            ),
          ),
          const SizedBox(height: 18),
          Text('Verification queue', style: _title(24)),
          const SizedBox(height: 4),
          const Text(
            'Approve agents once their licence and ID have been checked.',
            style: TextStyle(color: _C.muted, fontSize: 12.5, fontWeight: FontWeight.w500, height: 1.4),
          ),
          const SizedBox(height: 18),
          for (final u in _items) ...[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _C.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: _C.border),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      _Avatar(user: u, size: 50),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(u.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: _C.navy)),
                            const SizedBox(height: 2),
                            Text(
                              '${u.location}  |  Applied ${u.joined.toLowerCase()}',
                              style: const TextStyle(color: _C.muted, fontSize: 11.5, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Expanded(child: _DocChip(icon: Icons.badge_outlined, label: 'Agent licence')),
                      SizedBox(width: 8),
                      Expanded(child: _DocChip(icon: Icons.perm_identity_rounded, label: 'National ID')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _handle(u, false),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _C.danger,
                            side: BorderSide(color: _C.danger.withValues(alpha: 0.35)),
                            minimumSize: const Size(0, 44),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                          ),
                          child: const Text('Reject'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => _handle(u, true),
                          icon: const Icon(Icons.verified_rounded, size: 18),
                          label: const Text('Approve'),
                          style: FilledButton.styleFrom(
                            backgroundColor: _C.navy,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 44),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _DocChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DocChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(color: _C.track, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 16, color: _C.gold),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _C.navySoft),
            ),
          ),
          const Icon(Icons.open_in_new_rounded, size: 14, color: _C.muted),
        ],
      ),
    );
  }
}

// ───────────────────────── Profile sheet ─────────────────────────

class _ProfileSheet extends StatefulWidget {
  final _User user;

  const _ProfileSheet({required this.user});

  @override
  State<_ProfileSheet> createState() => _ProfileSheetState();
}

class _ProfileSheetState extends State<_ProfileSheet> {
  _User get u => widget.user;

  Future<void> _confirmDelete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => _branded(
        ctx,
        AlertDialog(
          backgroundColor: _C.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          icon: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: _C.danger.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.person_remove_rounded, color: _C.danger, size: 26),
          ),
          title: Text('Remove ${u.name.split(' ').first}?', style: _title(21)),
          content: const Text(
            'The account and its data will be removed. You can undo this right after.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _C.muted, height: 1.45),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              style: TextButton.styleFrom(foregroundColor: _C.muted),
              child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: FilledButton.styleFrom(
                backgroundColor: _C.danger,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Remove', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
    if (ok == true && mounted) Navigator.pop(context, 'delete');
  }

  @override
  Widget build(BuildContext context) {
    final suspended = u.status == _Status.suspended;
    final isAgent = u.role == _Role.agent;

    return _SheetFrame(
      builder: (scroll) => Column(
        children: [
          Expanded(
            child: ListView(
              controller: scroll,
              padding: EdgeInsets.zero,
              children: [
                // Navy profile cover
                Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 24),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [_C.navySoft, _C.navy],
                    ),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 44,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(height: 22),
                      _Avatar(user: u, size: 92, ring: true, ringColor: _C.goldBright, dotBorder: _C.navy),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(child: Text(u.name, style: _title(25, color: Colors.white))),
                          if (u.verified) ...[
                            const SizedBox(width: 6),
                            const Icon(Icons.verified_rounded, color: _C.goldBright, size: 22),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${u.role.label}  |  ${u.location}  |  Since ${u.joined}',
                        style: const TextStyle(color: _C.mutedOnNavy, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          _CoverStat(value: '${u.listings}', label: 'Listings'),
                          _CoverStat(value: '${u.deals}', label: 'Deals'),
                          _CoverStat(value: u.online ? 'Online' : u.lastActive, label: 'Last active'),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 22, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Contact', style: _title(19)),
                      const SizedBox(height: 10),
                      _Card(
                        children: [
                          _InfoRow(icon: Icons.alternate_email_rounded, label: 'Email', value: u.email),
                          const Divider(height: 1, indent: 60, color: _C.track),
                          _InfoRow(icon: Icons.phone_rounded, label: 'Phone', value: u.phone),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Text('Role', style: _title(19)),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final r in _Role.values)
                            GestureDetector(
                              onTap: () => setState(() => u.role = r),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                decoration: BoxDecoration(
                                  color: u.role == r ? _C.navy : _C.surface,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: u.role == r ? _C.navy : _C.border),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(r.icon, size: 16, color: u.role == r ? _C.goldBright : _C.gold),
                                    const SizedBox(width: 6),
                                    Text(
                                      r.label,
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w700,
                                        color: u.role == r ? Colors.white : _C.navy,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Text('Account', style: _title(19)),
                      const SizedBox(height: 10),
                      _Card(
                        children: [
                          _ToggleRow(
                            icon: Icons.verified_rounded,
                            title: 'Verified member',
                            subtitle: isAgent ? 'Licence and ID checked' : 'Identity checked',
                            value: u.verified,
                            onChanged: (v) => setState(() {
                              u.verified = v;
                              if (v && u.status == _Status.pending) u.status = _Status.active;
                            }),
                          ),
                          const Divider(height: 1, indent: 64, color: _C.track),
                          _ToggleRow(
                            icon: Icons.block_rounded,
                            title: 'Suspend account',
                            subtitle: 'Blocks sign-in and hides their listings',
                            value: suspended,
                            danger: true,
                            onChanged: (v) => setState(() => u.status = v ? _Status.suspended : _Status.active),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      TextButton.icon(
                        onPressed: _confirmDelete,
                        icon: const Icon(Icons.delete_outline_rounded, size: 19),
                        label: const Text('Remove account'),
                        style: TextButton.styleFrom(
                          foregroundColor: _C.danger,
                          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: _C.surface,
              border: Border(top: BorderSide(color: _C.border)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: Row(
                  children: [
                    Material(
                      color: _C.track,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: IconButton(
                        tooltip: 'Call',
                        onPressed: () {},
                        padding: const EdgeInsets.all(14),
                        icon: const Icon(Icons.call_rounded, color: _C.navy),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.chat_bubble_rounded, size: 19),
                        label: Text('Message ${u.name.split(' ').first}'),
                        style: FilledButton.styleFrom(
                          backgroundColor: _C.gold,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 52),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoverStat extends StatelessWidget {
  final String value;
  final String label;

  const _CoverStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Column(
          children: [
            Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: _title(19, color: _C.goldBright)),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(color: _C.mutedOnNavy, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final List<Widget> children;

  const _Card({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _C.border),
      ),
      child: Column(children: children),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 12),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: _C.gold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(11)),
            child: Icon(icon, size: 17, color: _C.gold),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: _C.muted, fontSize: 11, fontWeight: FontWeight.w600)),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: _C.navy, fontSize: 13.5, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Copy',
            onPressed: () => Clipboard.setData(ClipboardData(text: value)),
            icon: const Icon(Icons.copy_rounded, size: 17, color: _C.muted),
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final bool danger;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = danger ? _C.danger : _C.gold;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 8, 12),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: c.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, size: 19, color: c),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5, color: _C.navy)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: _C.muted, fontSize: 11.5, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          _GoldSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}