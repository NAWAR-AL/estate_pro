import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography: Playfair Display for titles, Montserrat for text and buttons.
/// Same brand palette as the dashboard and blog pages: deep navy + brass.
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
  static const scheduled = Color(0xFF3B5B8C);
}

/// Contact photos live in `assets/images/messages/`.
/// Property photos reuse the images you already added for the dashboard.
class _Img {
  static const sophie = 'assets/images/messages/sophie.jpg';
  static const omar = 'assets/images/messages/omar.jpg';
  static const leyla = 'assets/images/messages/leyla.jpg';
  static const james = 'assets/images/messages/james.jpg';
  static const aisha = 'assets/images/messages/aisha.jpg';
  static const mehmet = 'assets/images/messages/mehmet.jpg';
  static const daniel = 'assets/images/messages/daniel.jpg';
  static const elena = 'assets/images/messages/elena.jpg';

  static const villa = 'assets/images/luxury_villa.jpg';
  static const apartment = 'assets/images/seaview_apartment.jpg';
  static const penthouse = 'assets/images/modern_penthouse.jpg';
  static const hillside = 'assets/images/hero_villa.jpg';
  static const loft = 'assets/images/blog/article_5.jpg';
}

TextStyle _title(double size, {Color color = _C.navy, double? height}) =>
    GoogleFonts.playfairDisplay(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color,
        height: height);

/// Wraps a screen in the brand fonts and English left-to-right direction.
/// Used by the page itself and by the chat screen it pushes.
Widget _branded(BuildContext context, Widget child) {
  final base = Theme.of(context);
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Theme(
      data: base.copyWith(
          textTheme: GoogleFonts.montserratTextTheme(base.textTheme)),
      child: child,
    ),
  );
}

String _nowLabel() {
  final t = TimeOfDay.now();
  return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

String _initials(String name) => name
    .trim()
    .split(RegExp(r'\s+'))
    .take(2)
    .map((p) => p[0].toUpperCase())
    .join();

// ───────────────────────── Model ─────────────────────────

enum _Kind { buyer, investor, agent }

extension _KindX on _Kind {
  String get label => switch (this) {
        _Kind.buyer => 'Buyer',
        _Kind.investor => 'Investor',
        _Kind.agent => 'Agent',
      };

  Color get color => switch (this) {
        _Kind.buyer => _C.gold,
        _Kind.investor => _C.scheduled,
        _Kind.agent => _C.success,
      };
}

enum _Filter { all, unread, clients, agents, archived }

extension _FilterX on _Filter {
  String get label => switch (this) {
        _Filter.all => 'All',
        _Filter.unread => 'Unread',
        _Filter.clients => 'Clients',
        _Filter.agents => 'Agents',
        _Filter.archived => 'Archived',
      };
}

class _Contact {
  final String name;
  final String avatar;
  final _Kind kind;
  final bool online;
  final String lastSeen;

  const _Contact({
    required this.name,
    required this.avatar,
    required this.kind,
    this.online = false,
    this.lastSeen = '',
  });

  String get firstName => name.split(' ').first;
}

class _Property {
  final String title;
  final String location;
  final String price;
  final String image;

  const _Property(
      {required this.title,
      required this.location,
      required this.price,
      required this.image});
}

class _Msg {
  final String text;
  final bool fromMe;
  final String time;

  const _Msg(this.text, {required this.fromMe, required this.time});
}

class _Conversation {
  final String id;
  final _Contact contact;
  final _Property property;
  final List<_Msg> messages;
  String lastTime;
  int unread;
  bool pinned;
  bool archived;

  _Conversation({
    required this.id,
    required this.contact,
    required this.property,
    required this.messages,
    required this.lastTime,
    this.unread = 0,
    this.pinned = false,
    this.archived = false,
  });

  _Msg get last => messages.last;
  bool get awaitingReply => !last.fromMe;
}

// ───────────────────────── Sample data (replace with your API) ─────────────────────────

const _villa = _Property(
    title: 'Luxury Villa',
    location: 'Istanbul, Sarıyer',
    price: '\$1.25M',
    image: _Img.villa);
const _apartment = _Property(
    title: 'Sea-view Apartment',
    location: 'Antalya, Konyaaltı',
    price: '\$385K',
    image: _Img.apartment);
const _penthouse = _Property(
    title: 'Modern Penthouse',
    location: 'Bodrum, Yalıkavak',
    price: '\$940K',
    image: _Img.penthouse);
const _hillside = _Property(
    title: 'Hillside Villa',
    location: 'Bodrum, Türkbükü',
    price: '\$1.78M',
    image: _Img.hillside);
const _loft = _Property(
    title: 'Designer Loft',
    location: 'Istanbul, Cihangir',
    price: '\$520K',
    image: _Img.loft);

List<_Conversation> _seed() => [
      _Conversation(
        id: 'c1',
        contact: const _Contact(
            name: 'Sophie Laurent',
            avatar: _Img.sophie,
            kind: _Kind.buyer,
            online: true),
        property: _villa,
        lastTime: '09:42',
        unread: 2,
        pinned: true,
        messages: [
          const _Msg('Good morning! I saw the Luxury Villa listing in Sarıyer.',
              fromMe: false, time: '09:31'),
          const _Msg(
              'Good morning Sophie, it is a beautiful home. How can I help?',
              fromMe: true,
              time: '09:35'),
          const _Msg('Is the price negotiable for a cash buyer?',
              fromMe: false, time: '09:40'),
          const _Msg('And could I visit it this Saturday afternoon?',
              fromMe: false, time: '09:42'),
        ],
      ),
      _Conversation(
        id: 'c2',
        contact: const _Contact(
            name: 'Omar Haddad',
            avatar: _Img.omar,
            kind: _Kind.investor,
            online: true),
        property: _hillside,
        lastTime: '08:15',
        unread: 1,
        pinned: true,
        messages: [
          const _Msg('I am interested in two units for rental income.',
              fromMe: false, time: '08:02'),
          const _Msg('Excellent. The Hillside Villa has strong summer demand.',
              fromMe: true, time: '08:10'),
          const _Msg('Please send me the expected yield and service fees.',
              fromMe: false, time: '08:15'),
        ],
      ),
      _Conversation(
        id: 'c3',
        contact: const _Contact(
            name: 'Leyla Demir',
            avatar: _Img.leyla,
            kind: _Kind.agent,
            online: true),
        property: _penthouse,
        lastTime: '07:58',
        messages: [
          const _Msg('The new photos of the penthouse are uploaded.',
              fromMe: false, time: '07:50'),
          const _Msg('They look stunning, I will approve the listing now.',
              fromMe: true, time: '07:58'),
        ],
      ),
      _Conversation(
        id: 'c4',
        contact: const _Contact(
          name: 'James Whitfield',
          avatar: _Img.james,
          kind: _Kind.buyer,
          lastSeen: 'Last seen 2h ago',
        ),
        property: _apartment,
        lastTime: 'Yesterday',
        unread: 3,
        messages: [
          const _Msg('Hello, is the apartment still available?',
              fromMe: false, time: '18:20'),
          const _Msg('Does it come furnished?', fromMe: false, time: '18:21'),
          const _Msg('And how far is it from the beach?',
              fromMe: false, time: '18:24'),
        ],
      ),
      _Conversation(
        id: 'c5',
        contact: const _Contact(
            name: 'Aisha Rahman',
            avatar: _Img.aisha,
            kind: _Kind.buyer,
            online: true),
        property: _loft,
        lastTime: 'Yesterday',
        messages: [
          const _Msg('Thank you for the viewing today, we loved the loft.',
              fromMe: false, time: '16:05'),
          const _Msg('Wonderful! I will prepare the offer documents for you.',
              fromMe: true, time: '16:30'),
        ],
      ),
      _Conversation(
        id: 'c6',
        contact: const _Contact(
          name: 'Mehmet Arslan',
          avatar: _Img.mehmet,
          kind: _Kind.agent,
          lastSeen: 'Last seen yesterday',
        ),
        property: _apartment,
        lastTime: 'Mon',
        messages: [
          const _Msg('The owner agreed to lower the price by 3%.',
              fromMe: false, time: '11:12'),
        ],
      ),
      _Conversation(
        id: 'c7',
        contact: const _Contact(
          name: 'Daniel Kim',
          avatar: _Img.daniel,
          kind: _Kind.investor,
          lastSeen: 'Last seen Mon',
        ),
        property: _penthouse,
        lastTime: 'Sun',
        messages: [
          const _Msg('Could you share the floor plan of the penthouse?',
              fromMe: false, time: '14:40'),
          const _Msg('Of course, sending it in a moment.',
              fromMe: true, time: '15:02'),
        ],
      ),
      _Conversation(
        id: 'c8',
        contact: const _Contact(
          name: 'Elena Petrova',
          avatar: _Img.elena,
          kind: _Kind.buyer,
          lastSeen: 'Last seen last week',
        ),
        property: _villa,
        lastTime: 'Sep 21',
        archived: true,
        messages: [
          const _Msg('We decided on another property, thank you for your help!',
              fromMe: false, time: '10:00'),
          const _Msg('Congratulations Elena, wishing you the best.',
              fromMe: true, time: '10:20'),
        ],
      ),
    ];

// ───────────────────────── Page ─────────────────────────

class MessagePage extends StatefulWidget {
  /// Optional: your own handler to open the drawer. If null, the page opens
  /// the nearest Scaffold that has a drawer.
  final VoidCallback? onMenuTap;

  const MessagePage({super.key, this.onMenuTap});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final List<_Conversation> _convos = _seed();
  _Filter _filter = _Filter.all;
  String _query = '';

  Iterable<_Conversation> get _active => _convos.where((c) => !c.archived);

  int get _unreadTotal => _active.fold(0, (sum, c) => sum + c.unread);
  int get _awaiting => _active.where((c) => c.awaitingReply).length;

  bool _passesFilter(_Conversation c, _Filter f) => switch (f) {
        _Filter.all => !c.archived,
        _Filter.unread => !c.archived && c.unread > 0,
        _Filter.clients => !c.archived && c.contact.kind != _Kind.agent,
        _Filter.agents => !c.archived && c.contact.kind == _Kind.agent,
        _Filter.archived => c.archived,
      };

  bool _matches(_Conversation c) {
    if (!_passesFilter(c, _filter)) return false;
    if (_query.isEmpty) return true;
    return c.contact.name.toLowerCase().contains(_query) ||
        c.property.title.toLowerCase().contains(_query) ||
        c.messages.any((m) => m.text.toLowerCase().contains(_query));
  }

  // ───────────── Actions ─────────────

  Future<void> _open(_Conversation c) async {
    setState(() => c.unread = 0);
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 320),
        reverseTransitionDuration: const Duration(milliseconds: 260),
        pageBuilder: (_, __, ___) => _ChatPage(convo: c),
        transitionsBuilder: (_, anim, __, child) {
          final curved =
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween(begin: const Offset(0.06, 0), end: Offset.zero)
                  .animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
    if (mounted) setState(() {});
  }

  void _toggleRead(_Conversation c) {
    setState(() => c.unread = c.unread > 0 ? 0 : 1);
  }

  void _toggleArchive(_Conversation c) {
    final archiving = !c.archived;
    setState(() {
      c.archived = archiving;
      if (archiving) c.pinned = false;
    });
    _toast(
      archiving ? 'Conversation archived' : 'Conversation restored',
      onUndo: () => setState(() => c.archived = !archiving),
    );
  }

  void _togglePin(_Conversation c) => setState(() => c.pinned = !c.pinned);

  void _toast(String message, {VoidCallback? onUndo}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          behavior: SnackBarBehavior.floating,
          backgroundColor: _C.navy,
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          action: onUndo == null
              ? null
              : SnackBarAction(
                  label: 'Undo', textColor: _C.goldBright, onPressed: onUndo),
        ),
      );
  }

  // ───────────── Build ─────────────

  @override
  Widget build(BuildContext context) {
    final visible = _convos.where(_matches).toList();
    final showPinnedSection = _filter == _Filter.all && _query.isEmpty;
    final pinned = showPinnedSection
        ? visible.where((c) => c.pinned).toList()
        : <_Conversation>[];
    final rest = visible.where((c) => !pinned.contains(c)).toList();
    final online = _active.where((c) => c.contact.online).toList();

    return _branded(
      context,
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: _C.bg,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'New message',
            backgroundColor: _C.gold,
            foregroundColor: Colors.white,
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.edit_rounded, size: 24),
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _Header(
                  onMenuTap: widget.onMenuTap,
                  unread: _unreadTotal,
                  awaiting: _awaiting,
                  online: online,
                  onOpen: _open,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 14),
                sliver: SliverToBoxAdapter(
                  child: _SearchField(
                      onChanged: (v) =>
                          setState(() => _query = v.trim().toLowerCase())),
                ),
              ),
              SliverToBoxAdapter(
                child: _FilterBar(
                  selected: _filter,
                  counts: {
                    for (final f in _Filter.values)
                      f: _convos.where((c) => _passesFilter(c, f)).length
                  },
                  onSelected: (f) => setState(() => _filter = f),
                ),
              ),
              if (pinned.isNotEmpty) ...[
                const _SliverSectionTitle(
                    title: 'Pinned', icon: Icons.push_pin_rounded),
                _list(pinned),
              ],
              if (rest.isNotEmpty) ...[
                _SliverSectionTitle(
                  title:
                      pinned.isNotEmpty ? 'All conversations' : _filter.label,
                  trailing: '${rest.length}',
                ),
                _list(rest),
              ],
              if (visible.isEmpty)
                SliverToBoxAdapter(
                    child: _EmptyState(archived: _filter == _Filter.archived)),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _list(List<_Conversation> items) {
    return SliverPadding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
      sliver: SliverList.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final c = items[i];
          return _ConversationTile(
            key: ValueKey(c.id),
            convo: c,
            onTap: () => _open(c),
            onToggleRead: () => _toggleRead(c),
            onToggleArchive: () => _toggleArchive(c),
            onTogglePin: () => _togglePin(c),
          );
        },
      ),
    );
  }
}

// ───────────────────────── Shared pieces ─────────────────────────

class _SmartImage extends StatelessWidget {
  final String path;
  final Widget? fallback;

  const _SmartImage(this.path, {this.fallback});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, error, __) {
        debugPrint('⚠️ Image failed to load: "$path"  →  $error');
        return fallback ??
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_C.navySoft, _C.navy],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
              child: Center(
                  child: Icon(Icons.villa_rounded,
                      color: _C.goldBright, size: 18)),
            );
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  final _Contact contact;
  final double size;
  final bool ring;
  final Color dotBorder;

  const _Avatar(
      {required this.contact,
      this.size = 52,
      this.ring = false,
      this.dotBorder = _C.surface});

  @override
  Widget build(BuildContext context) {
    final dot = math.max(11.0, size * 0.24);
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(ring ? 2.5 : 0),
            decoration: ring
                ? const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                        colors: [_C.goldBright, _C.gold, _C.goldBright]),
                  )
                : null,
            child: Container(
              padding: EdgeInsets.all(ring ? 2 : 0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: ring ? dotBorder : null),
              child: ClipOval(
                child: _SmartImage(
                  contact.avatar,
                  fallback: ColoredBox(
                    color: _C.navySoft,
                    child: Center(
                      child: Text(
                        _initials(contact.name),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: size * 0.3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (contact.online)
            PositionedDirectional(
              end: ring ? 1 : 0,
              bottom: ring ? 1 : 0,
              child: Container(
                width: dot,
                height: dot,
                decoration: BoxDecoration(
                  color: _C.success,
                  shape: BoxShape.circle,
                  border: Border.all(color: dotBorder, width: 2.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color color;
  final Color background;

  const _RoundIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.color = _C.goldBright,
    this.background = const Color(0x14FFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: const CircleBorder(),
      child: IconButton(
          tooltip: tooltip, onPressed: onTap, icon: Icon(icon, color: color)),
    );
  }
}

class _SliverSectionTitle extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? trailing;

  const _SliverSectionTitle({required this.title, this.icon, this.trailing});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 26, 20, 12),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: _C.gold),
              const SizedBox(width: 8),
            ],
            Expanded(child: Text(title, style: _title(20))),
            if (trailing != null)
              Text(
                trailing!,
                style: const TextStyle(
                    color: _C.muted,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5),
              ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Header ─────────────────────────

class _Header extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final int unread;
  final int awaiting;
  final List<_Conversation> online;
  final ValueChanged<_Conversation> onOpen;

  const _Header({
    required this.onMenuTap,
    required this.unread,
    required this.awaiting,
    required this.online,
    required this.onOpen,
  });

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
            end: -80,
            top: -70,
            child: Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: _C.gold.withValues(alpha: 0.13), width: 24),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, top + 14, 0, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Row(
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
                              'Client inbox',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _C.mutedOnNavy,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 2),
                            Text('Messages',
                                style: _title(20, color: Colors.white)),
                          ],
                        ),
                      ),
                      _RoundIconButton(
                          icon: Icons.tune_rounded,
                          tooltip: 'Inbox settings',
                          onTap: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Text(
                    'Every inquiry,\nanswered in style.',
                    style: _title(28, color: Colors.white, height: 1.2),
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      _HeaderMetric(
                          value: '$unread', label: 'Unread', highlight: true),
                      const SizedBox(width: 10),
                      _HeaderMetric(value: '$awaiting', label: 'Need reply'),
                      const SizedBox(width: 10),
                      const _HeaderMetric(value: '12m', label: 'Avg. response'),
                    ],
                  ),
                ),
                if (online.isNotEmpty) ...[
                  const SizedBox(height: 22),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Text(
                      'Online now',
                      style: TextStyle(
                          color: _C.mutedOnNavy,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 86,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      itemCount: online.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (_, i) {
                        final c = online[i];
                        return GestureDetector(
                          onTap: () => onOpen(c),
                          child: Column(
                            children: [
                              _Avatar(
                                  contact: c.contact,
                                  size: 60,
                                  ring: true,
                                  dotBorder: _C.navy),
                              const SizedBox(height: 7),
                              Text(
                                c.contact.firstName,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderMetric extends StatelessWidget {
  final String value;
  final String label;
  final bool highlight;

  const _HeaderMetric(
      {required this.value, required this.label, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 10, 12),
        decoration: BoxDecoration(
          color: highlight
              ? _C.gold.withValues(alpha: 0.18)
              : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: highlight
                ? _C.goldBright.withValues(alpha: 0.35)
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style: _title(22,
                    color: highlight ? _C.goldBright : Colors.white,
                    height: 1.1)),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 11,
                  color: _C.mutedOnNavy,
                  fontWeight: FontWeight.w600),
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
      style: const TextStyle(
          color: _C.navy, fontSize: 14, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: 'Search people, properties or messages',
        hintStyle: const TextStyle(
            color: _C.muted, fontSize: 13, fontWeight: FontWeight.w500),
        prefixIcon: const Icon(Icons.search_rounded, color: _C.muted),
        filled: true,
        fillColor: _C.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        enabledBorder: border,
        focusedBorder: border.copyWith(
            borderSide: const BorderSide(color: _C.gold, width: 1.5)),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final _Filter selected;
  final Map<_Filter, int> counts;
  final ValueChanged<_Filter> onSelected;

  const _FilterBar(
      {required this.selected, required this.counts, required this.onSelected});

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
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: active ? Colors.white : _C.navy,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    constraints: const BoxConstraints(minWidth: 24),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active ? _C.gold : _C.track,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${counts[f] ?? 0}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: active ? Colors.white : _C.muted,
                      ),
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

// ───────────────────────── Conversation tile ─────────────────────────

class _ConversationTile extends StatelessWidget {
  final _Conversation convo;
  final VoidCallback onTap;
  final VoidCallback onToggleRead;
  final VoidCallback onToggleArchive;
  final VoidCallback onTogglePin;

  const _ConversationTile({
    super.key,
    required this.convo,
    required this.onTap,
    required this.onToggleRead,
    required this.onToggleArchive,
    required this.onTogglePin,
  });

  @override
  Widget build(BuildContext context) {
    final c = convo;
    final unread = c.unread > 0;

    // Swipe toward the end (right in English) → mark read/unread.
    // Swipe toward the start (left in English) → archive/restore.
    // Dismissible follows the text direction, so this mirrors in RTL.
    return Dismissible(
      key: ValueKey('swipe-${c.id}'),
      background: _SwipeAction(
        alignment: AlignmentDirectional.centerStart,
        color: _C.gold,
        icon: unread
            ? Icons.mark_email_read_rounded
            : Icons.mark_email_unread_rounded,
        label: unread ? 'Mark read' : 'Mark unread',
      ),
      secondaryBackground: _SwipeAction(
        alignment: AlignmentDirectional.centerEnd,
        color: _C.navy,
        icon: c.archived ? Icons.unarchive_rounded : Icons.archive_rounded,
        label: c.archived ? 'Restore' : 'Archive',
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onToggleRead();
          return false;
        }
        return true;
      },
      onDismissed: (_) => onToggleArchive(),
      child: Material(
        color: _C.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(
              color: unread ? _C.gold.withValues(alpha: 0.45) : _C.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          onLongPress: onTogglePin,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Avatar(contact: c.contact, size: 54),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    c.contact.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: unread
                                          ? FontWeight.w800
                                          : FontWeight.w700,
                                      color: _C.navy,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _KindTag(kind: c.contact.kind),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (c.pinned) ...[
                            const Icon(Icons.push_pin_rounded,
                                size: 13, color: _C.gold),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            c.lastTime,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: unread ? _C.gold : _C.muted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (c.last.fromMe) ...[
                            const Icon(Icons.done_all_rounded,
                                size: 15, color: _C.scheduled),
                            const SizedBox(width: 4),
                          ],
                          Expanded(
                            child: Text(
                              c.last.text,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.5,
                                height: 1.3,
                                fontWeight:
                                    unread ? FontWeight.w700 : FontWeight.w500,
                                color: unread ? _C.navy : _C.muted,
                              ),
                            ),
                          ),
                          if (unread) ...[
                            const SizedBox(width: 8),
                            Container(
                              constraints: const BoxConstraints(minWidth: 22),
                              height: 22,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [_C.goldBright, _C.gold]),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Text(
                                '${c.unread}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      _ListingChip(property: c.property),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SwipeAction extends StatelessWidget {
  final AlignmentDirectional alignment;
  final Color color;
  final IconData icon;
  final String label;

  const _SwipeAction(
      {required this.alignment,
      required this.color,
      required this.icon,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(22)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _KindTag extends StatelessWidget {
  final _Kind kind;

  const _KindTag({required this.kind});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: kind.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        kind.label,
        style: TextStyle(
            fontSize: 10, fontWeight: FontWeight.w800, color: kind.color),
      ),
    );
  }
}

class _ListingChip extends StatelessWidget {
  final _Property property;

  const _ListingChip({required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 10, 5),
      decoration: BoxDecoration(
          color: _C.track, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
                width: 30, height: 30, child: _SmartImage(property.image)),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              property.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: _C.navySoft),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            property.price,
            style: const TextStyle(
                fontSize: 11.5, fontWeight: FontWeight.w800, color: _C.gold),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool archived;

  const _EmptyState({required this.archived});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
                color: _C.gold.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(
              archived ? Icons.inventory_2_outlined : Icons.forum_outlined,
              color: _C.gold,
              size: 36,
            ),
          ),
          const SizedBox(height: 18),
          Text(
              archived ? 'No archived conversations' : 'No conversations found',
              style: _title(21)),
          const SizedBox(height: 6),
          Text(
            archived
                ? 'Swipe a conversation to the left to archive it.'
                : 'Try another filter or search term.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: _C.muted, height: 1.45),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Chat screen ─────────────────────────

class _ChatPage extends StatefulWidget {
  final _Conversation convo;

  const _ChatPage({required this.convo});

  @override
  State<_ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<_ChatPage> {
  final _input = TextEditingController();
  bool _typing = false;
  bool _canSend = false;

  static const _quickReplies = [
    'Schedule a viewing',
    'Send the brochure',
    'Share the floor plan',
    'The price is firm',
  ];

  // Demo only: simulated replies so the screen feels alive. Remove when
  // you connect a real chat backend.
  static const _demoReplies = [
    'Thank you, that works perfectly for me.',
    'Great, I will check and get back to you shortly.',
    'Wonderful, looking forward to it!',
  ];

  _Conversation get c => widget.convo;

  @override
  void initState() {
    super.initState();
    _input.addListener(() {
      final can = _input.text.trim().isNotEmpty;
      if (can != _canSend) setState(() => _canSend = can);
    });
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _send([String? preset]) {
    final text = (preset ?? _input.text).trim();
    if (text.isEmpty) return;
    HapticFeedback.lightImpact();
    setState(() {
      c.messages.add(_Msg(text, fromMe: true, time: _nowLabel()));
      c.lastTime = _nowLabel();
      _input.clear();
    });
    _simulateReply();
  }

  Future<void> _simulateReply() async {
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _typing = true);
    await Future.delayed(const Duration(milliseconds: 1700));
    if (!mounted) return;
    setState(() {
      _typing = false;
      final reply = _demoReplies[c.messages.length % _demoReplies.length];
      c.messages.add(_Msg(reply, fromMe: false, time: _nowLabel()));
      c.lastTime = _nowLabel();
    });
  }

  @override
  Widget build(BuildContext context) {
    final msgs = c.messages.reversed.toList();
    // Reversed list: index 0 is the newest item at the bottom.
    final itemCount = msgs.length + 1 + (_typing ? 1 : 0);

    return _branded(
      context,
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: _C.bg,
          body: Column(
            children: [
              _ChatHeader(contact: c.contact, property: c.property),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 8),
                  itemCount: itemCount,
                  itemBuilder: (_, i) {
                    if (_typing) {
                      if (i == 0) return const _TypingBubble();
                      i -= 1;
                    }
                    if (i == msgs.length) return const _DayChip(label: 'Today');
                    final m = msgs[i];
                    final newer = i > 0 ? msgs[i - 1] : null;
                    final groupedWithNext =
                        newer != null && newer.fromMe == m.fromMe;
                    return _Bubble(msg: m, tight: groupedWithNext);
                  },
                ),
              ),
              _QuickReplies(replies: _quickReplies, onTap: _send),
              _Composer(controller: _input, canSend: _canSend, onSend: _send),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  final _Contact contact;
  final _Property property;

  const _ChatHeader({required this.contact, required this.property});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(8, top + 8, 12, 16),
      decoration: const BoxDecoration(
        color: _C.navy,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                tooltip: 'Back',
                onPressed: () => Navigator.of(context).maybePop(),
                // arrow_back flips automatically in RTL.
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              ),
              _Avatar(contact: contact, size: 44, dotBorder: _C.navy),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _title(18, color: Colors.white),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        if (contact.online) ...[
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                                color: _C.success, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Flexible(
                          child: Text(
                            '${contact.online ? 'Online' : contact.lastSeen}  |  ${contact.kind.label}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: _C.mutedOnNavy,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _RoundIconButton(
                  icon: Icons.call_rounded, tooltip: 'Call', onTap: () {}),
              const SizedBox(width: 8),
              _RoundIconButton(
                  icon: Icons.more_vert_rounded, tooltip: 'More', onTap: () {}),
            ],
          ),
          const SizedBox(height: 14),
          // The listing this conversation is about.
          Container(
            margin: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                      width: 58,
                      height: 50,
                      child: _SmartImage(property.image)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        property.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(Icons.location_on_rounded,
                              size: 12, color: _C.goldBright),
                          const SizedBox(width: 3),
                          Flexible(
                            child: Text(
                              property.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: _C.mutedOnNavy, fontSize: 11.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(property.price, style: _title(17, color: _C.goldBright)),
                const SizedBox(width: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  final String label;

  const _DayChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 14, top: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: _C.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _C.border),
        ),
        child: Text(label,
            style: const TextStyle(
                fontSize: 11.5, fontWeight: FontWeight.w700, color: _C.muted)),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final _Msg msg;
  final bool tight;

  const _Bubble({required this.msg, required this.tight});

  @override
  Widget build(BuildContext context) {
    final mine = msg.fromMe;
    const r = Radius.circular(20);
    const small = Radius.circular(6);

    return Padding(
      padding: EdgeInsets.only(bottom: tight ? 4 : 12),
      child: Align(
        // My messages sit at the end side, theirs at the start side.
        alignment: mine
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.76),
          child: Container(
            padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 12, 8),
            decoration: BoxDecoration(
              gradient: mine
                  ? const LinearGradient(colors: [_C.navySoft, _C.navy])
                  : null,
              color: mine ? null : _C.surface,
              border: mine ? null : Border.all(color: _C.border),
              borderRadius: BorderRadiusDirectional.only(
                topStart: r,
                topEnd: r,
                bottomStart: mine ? r : small,
                bottomEnd: mine ? small : r,
              ),
              boxShadow: mine
                  ? [
                      BoxShadow(
                        color: _C.navy.withValues(alpha: 0.18),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  widthFactor: 1,
                  child: Text(
                    msg.text,
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.45,
                      fontWeight: FontWeight.w500,
                      color: mine ? Colors.white : _C.navy,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      msg.time,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: mine ? _C.mutedOnNavy : _C.muted,
                      ),
                    ),
                    if (mine) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.done_all_rounded,
                          size: 14, color: _C.goldBright),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TypingBubble extends StatefulWidget {
  const _TypingBubble();

  @override
  State<_TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<_TypingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000))
    ..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: _C.surface,
            border: Border.all(color: _C.border),
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(20),
              topEnd: Radius.circular(20),
              bottomEnd: Radius.circular(20),
              bottomStart: Radius.circular(6),
            ),
          ),
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < 3; i++) ...[
                  if (i > 0) const SizedBox(width: 5),
                  Transform.translate(
                    offset: Offset(
                        0,
                        -3 *
                            math.max(
                                0,
                                math.sin(
                                    (_ctrl.value * 2 * math.pi) - i * 0.9))),
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: _C.gold.withValues(
                          alpha: 0.45 +
                              0.55 *
                                  math.max(
                                      0,
                                      math.sin((_ctrl.value * 2 * math.pi) -
                                          i * 0.9)),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickReplies extends StatelessWidget {
  final List<String> replies;
  final ValueChanged<String> onTap;

  const _QuickReplies({required this.replies, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 6),
        itemCount: replies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => ActionChip(
          onPressed: () => onTap(replies[i]),
          avatar: const Icon(Icons.bolt_rounded, size: 16, color: _C.gold),
          label: Text(replies[i]),
          labelStyle: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: _C.navy),
          backgroundColor: _C.surface,
          side: const BorderSide(color: _C.border),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 4),
        ),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  final TextEditingController controller;
  final bool canSend;
  final VoidCallback onSend;

  const _Composer(
      {required this.controller, required this.canSend, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _C.surface,
        border: Border(top: BorderSide(color: _C.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 12, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                tooltip: 'Attach',
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline_rounded,
                    color: _C.muted, size: 26),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => onSend(),
                  cursorColor: _C.gold,
                  style: const TextStyle(
                      fontSize: 14,
                      color: _C.navy,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: 'Write a message',
                    hintStyle: const TextStyle(color: _C.muted, fontSize: 13.5),
                    filled: true,
                    fillColor: _C.track,
                    isDense: true,
                    contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(18, 13, 18, 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              AnimatedScale(
                scale: canSend ? 1 : 0.88,
                duration: const Duration(milliseconds: 180),
                child: AnimatedOpacity(
                  opacity: canSend ? 1 : 0.5,
                  duration: const Duration(milliseconds: 180),
                  child: Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Ink(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient:
                            LinearGradient(colors: [_C.goldBright, _C.gold]),
                      ),
                      child: InkWell(
                        onTap: canSend ? onSend : null,
                        child: const SizedBox(
                          width: 46,
                          height: 46,
                          // send_rounded flips automatically in RTL.
                          child: Icon(Icons.send_rounded,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ),
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
