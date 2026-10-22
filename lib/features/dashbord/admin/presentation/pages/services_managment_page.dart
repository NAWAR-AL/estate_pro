import 'dart:math' as math;

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
}

/// Service covers live in `assets/images/services/`.
/// Client photos reuse the images from the messages page.
class _Img {
  static const legal = 'assets/images/services/legal.jpg';
  static const valuation = 'assets/images/services/valuation.jpg';
  static const interior = 'assets/images/services/interior.jpg';
  static const management = 'assets/images/services/management.jpg';
  static const photography = 'assets/images/services/photography.jpg';
  static const mortgage = 'assets/images/services/mortgage.jpg';
  static const relocation = 'assets/images/services/relocation.jpg';
  static const maintenance = 'assets/images/services/maintenance.jpg';

  static const sophie = 'assets/images/messages/sophie.jpg';
  static const omar = 'assets/images/messages/omar.jpg';
  static const aisha = 'assets/images/messages/aisha.jpg';
  static const james = 'assets/images/messages/james.jpg';
  static const daniel = 'assets/images/messages/daniel.jpg';
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

enum _Cat { legal, valuation, design, management, media, finance }

extension _CatX on _Cat {
  String get label => switch (this) {
        _Cat.legal => 'Legal',
        _Cat.valuation => 'Valuation',
        _Cat.design => 'Design',
        _Cat.management => 'Management',
        _Cat.media => 'Media',
        _Cat.finance => 'Finance',
      };

  IconData get icon => switch (this) {
        _Cat.legal => Icons.gavel_rounded,
        _Cat.valuation => Icons.price_check_rounded,
        _Cat.design => Icons.chair_rounded,
        _Cat.management => Icons.vpn_key_rounded,
        _Cat.media => Icons.photo_camera_rounded,
        _Cat.finance => Icons.account_balance_rounded,
      };
}

class _Service {
  final String id;
  final String name;
  final _Cat cat;
  final String provider;
  final double rating;
  final int bookings;
  final String image;
  String description;
  String price;
  String unit;
  bool active;
  bool onlineBooking;

  _Service({
    required this.id,
    required this.name,
    required this.cat,
    required this.provider,
    required this.rating,
    required this.bookings,
    required this.image,
    required this.description,
    required this.price,
    required this.unit,
    this.active = true,
    this.onlineBooking = true,
  });
}

enum _ReqStatus { pending, inProgress, done }

extension _ReqStatusX on _ReqStatus {
  String get label => switch (this) {
        _ReqStatus.pending => 'New',
        _ReqStatus.inProgress => 'In progress',
        _ReqStatus.done => 'Completed',
      };

  Color get color => switch (this) {
        _ReqStatus.pending => _C.pending,
        _ReqStatus.inProgress => _C.info,
        _ReqStatus.done => _C.success,
      };
}

class _Request {
  final String id;
  final String client;
  final String avatar;
  final String service;
  final String property;
  final String when;
  _ReqStatus status;

  _Request({
    required this.id,
    required this.client,
    required this.avatar,
    required this.service,
    required this.property,
    required this.when,
    this.status = _ReqStatus.pending,
  });
}

// Sample data: replace with your API.
List<_Service> _seedServices() => [
      _Service(
        id: 's1',
        name: 'Legal consultation',
        cat: _Cat.legal,
        provider: 'Yıldız Law Partners',
        rating: 4.9,
        bookings: 128,
        image: _Img.legal,
        price: '\$450',
        unit: 'flat fee',
        description: 'Title deed checks, purchase contracts and full legal guidance from offer to handover.',
      ),
      _Service(
        id: 's2',
        name: 'Property valuation',
        cat: _Cat.valuation,
        provider: 'Certified valuers',
        rating: 4.8,
        bookings: 214,
        image: _Img.valuation,
        price: '\$300',
        unit: 'per report',
        description: 'A licensed, bank-ready valuation report with comparable sales and market outlook.',
      ),
      _Service(
        id: 's3',
        name: 'Interior design',
        cat: _Cat.design,
        provider: 'Atelier Nour',
        rating: 4.9,
        bookings: 76,
        image: _Img.interior,
        price: '\$1,200',
        unit: 'per project',
        description: 'Concept, furnishing and styling that turns a new property into a finished home.',
      ),
      _Service(
        id: 's4',
        name: 'Property management',
        cat: _Cat.management,
        provider: 'Estate Pro Care',
        rating: 4.7,
        bookings: 152,
        image: _Img.management,
        price: '8%',
        unit: 'of monthly rent',
        description: 'Tenant search, rent collection, inspections and maintenance, handled end to end.',
      ),
      _Service(
        id: 's5',
        name: 'Photography & 3D tour',
        cat: _Cat.media,
        provider: 'Lumen Studio',
        rating: 4.7,
        bookings: 302,
        image: _Img.photography,
        price: '\$250',
        unit: 'per listing',
        description: 'Editorial photos, drone shots and an immersive 3D walkthrough for every listing.',
      ),
      _Service(
        id: 's6',
        name: 'Mortgage advisory',
        cat: _Cat.finance,
        provider: 'Partner banks',
        rating: 4.6,
        bookings: 95,
        image: _Img.mortgage,
        price: 'Free',
        unit: 'first consultation',
        description: 'Compare rates from partner banks and get pre-approved before you make an offer.',
      ),
      _Service(
        id: 's7',
        name: 'Residency & relocation',
        cat: _Cat.legal,
        provider: 'Global Move Desk',
        rating: 4.8,
        bookings: 61,
        image: _Img.relocation,
        price: '\$900',
        unit: 'flat fee',
        description: 'Residence permits, bank accounts, school search and a smooth first month in Türkiye.',
      ),
      _Service(
        id: 's8',
        name: 'Maintenance & repairs',
        cat: _Cat.management,
        provider: 'Estate Pro Care',
        rating: 4.5,
        bookings: 188,
        image: _Img.maintenance,
        price: '\$60',
        unit: 'per hour',
        description: 'Vetted technicians for plumbing, electrics, painting and seasonal maintenance.',
        active: false,
      ),
    ];

List<_Request> _seedRequests() => [
      _Request(
        id: 'r1',
        client: 'Sophie Laurent',
        avatar: _Img.sophie,
        service: 'Interior design',
        property: 'Luxury Villa, Sarıyer',
        when: 'Today, 14:00',
      ),
      _Request(
        id: 'r2',
        client: 'Omar Haddad',
        avatar: _Img.omar,
        service: 'Property valuation',
        property: 'Hillside Villa, Bodrum',
        when: 'Tomorrow, 10:30',
      ),
      _Request(
        id: 'r3',
        client: 'Aisha Rahman',
        avatar: _Img.aisha,
        service: 'Legal consultation',
        property: 'Designer Loft, Cihangir',
        when: 'Oct 7, 11:00',
        status: _ReqStatus.inProgress,
      ),
      _Request(
        id: 'r4',
        client: 'James Whitfield',
        avatar: _Img.james,
        service: 'Photography & 3D tour',
        property: 'Sea-view Apartment, Antalya',
        when: 'Oct 8, 09:00',
        status: _ReqStatus.inProgress,
      ),
      _Request(
        id: 'r5',
        client: 'Daniel Kim',
        avatar: _Img.daniel,
        service: 'Mortgage advisory',
        property: 'Modern Penthouse, Bodrum',
        when: 'Oct 2',
        status: _ReqStatus.done,
      ),
    ];

// ───────────────────────── Page ─────────────────────────

class ServicesManagementPage extends StatefulWidget {
  /// Optional: your own handler to open the drawer. If null, the page opens
  /// the nearest Scaffold that has a drawer.
  final VoidCallback? onMenuTap;

  /// Optional: navigate to your "new service" form.
  final VoidCallback? onAddService;

  const ServicesManagementPage({super.key, this.onMenuTap, this.onAddService});

  @override
  State<ServicesManagementPage> createState() => _ServicesManagementPageState();
}

class _ServicesManagementPageState extends State<ServicesManagementPage> {
  final List<_Service> _services = _seedServices();
  final List<_Request> _requests = _seedRequests();
  _Cat? _cat;

  int get _activeCount => _services.where((s) => s.active).length;
  int get _openRequests => _requests.where((r) => r.status != _ReqStatus.done).length;
  double get _avgRating => _services.fold(0.0, (s, e) => s + e.rating) / math.max(1, _services.length);

  // ───────────── Actions ─────────────

  void _toggleActive(_Service s) {
    setState(() => s.active = !s.active);
    _toast(s.active ? '${s.name} is live' : '${s.name} paused');
  }

  void _accept(_Request r) {
    setState(() => r.status = _ReqStatus.inProgress);
    _toast('Request accepted');
  }

  void _complete(_Request r) {
    setState(() => r.status = _ReqStatus.done);
    _toast('Marked as completed');
  }

  void _decline(_Request r) {
    final i = _requests.indexOf(r);
    if (i < 0) return;
    setState(() => _requests.removeAt(i));
    _toast('Request declined', onUndo: () => setState(() => _requests.insert(i, r)));
  }

  Future<void> _manage(_Service s) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: _C.navy.withValues(alpha: 0.55),
      builder: (ctx) => _branded(ctx, _ServiceSheet(service: s)),
    );
    if (!mounted) return;
    setState(() {});
    if (saved == true) _toast('Changes saved');
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
    final services = _services.where((s) => _cat == null || s.cat == _cat).toList();
    final usedCats = _Cat.values.where((c) => _services.any((s) => s.cat == c)).toList();

    return _branded(
      context,
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: _C.bg,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: widget.onAddService ?? () {},
            backgroundColor: _C.gold,
            foregroundColor: Colors.white,
            elevation: 6,
            shape: const StadiumBorder(),
            icon: const Icon(Icons.add_rounded),
            label: const Text('New service', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _Header(
                  onMenuTap: widget.onMenuTap,
                  active: _activeCount,
                  total: _services.length,
                  open: _openRequests,
                  rating: _avgRating,
                ),
              ),
              _SliverTitle(
                title: 'Service requests',
                subtitle: '$_openRequests open, newest first',
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 236,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 8),
                    itemCount: _requests.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, i) {
                      final r = _requests[i];
                      return _RequestCard(
                        key: ValueKey(r.id),
                        request: r,
                        onAccept: () => _accept(r),
                        onDecline: () => _decline(r),
                        onComplete: () => _complete(r),
                      );
                    },
                  ),
                ),
              ),
              _SliverTitle(
                title: 'Service catalog',
                subtitle: '$_activeCount of ${_services.length} services are live',
              ),
              SliverToBoxAdapter(
                child: _CategoryBar(
                  categories: usedCats,
                  selected: _cat,
                  onSelected: (c) => setState(() => _cat = c),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 110),
                sliver: SliverList.separated(
                  itemCount: services.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (_, i) {
                    final s = services[i];
                    return _ServiceCard(
                      key: ValueKey(s.id),
                      service: s,
                      onToggle: () => _toggleActive(s),
                      onManage: () => _manage(s),
                    );
                  },
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
  final double iconSize;
  final Widget? fallback;

  const _SmartImage(this.path, {this.iconSize = 30, this.fallback});

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
            DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_C.navySoft, _C.navy],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
              child: Center(
                child: Icon(Icons.room_service_rounded, color: _C.goldBright.withValues(alpha: 0.7), size: iconSize),
              ),
            );
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  final String name;
  final String image;
  final double size;

  const _Avatar({required this.name, required this.image, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [_C.goldBright, _C.gold]),
      ),
      child: ClipOval(
        child: SizedBox(
          width: size,
          height: size,
          child: _SmartImage(
            image,
            fallback: ColoredBox(
              color: _C.navySoft,
              child: Center(
                child: Text(
                  _initials(name),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: size * 0.32),
                ),
              ),
            ),
          ),
        ),
      ),
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

class _Badge extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color background;
  final Color foreground;

  const _Badge({this.icon, required this.text, required this.background, this.foreground = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: foreground),
            const SizedBox(width: 5),
          ],
          Text(text, style: TextStyle(color: foreground, fontSize: 11, fontWeight: FontWeight.w800)),
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
  final int active;
  final int total;
  final int open;
  final double rating;

  const _Header({
    required this.onMenuTap,
    required this.active,
    required this.total,
    required this.open,
    required this.rating,
  });

  // Sample revenue for the last 8 weeks: replace with your API.
  static const _weekly = [21.0, 26.0, 24.0, 31.0, 29.0, 36.0, 41.0, 48.0];

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
                            'Concierge desk',
                            style: TextStyle(fontSize: 12, color: _C.mutedOnNavy, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text('Services', style: _title(20, color: Colors.white)),
                        ],
                      ),
                    ),
                    _RoundIconButton(icon: Icons.calendar_month_rounded, tooltip: 'Schedule', onTap: () {}),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Beyond the keys,\na service for every need.',
                  style: _title(27, color: Colors.white, height: 1.2),
                ),
                const SizedBox(height: 22),
                // Revenue card with a small bar chart
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Service revenue this month',
                              style: TextStyle(color: _C.mutedOnNavy, fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 6),
                            Text('\$48,250', style: _title(34, color: _C.goldBright, height: 1.1)),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _C.success.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.trending_up_rounded, size: 14, color: Color(0xFF5EE0A8)),
                                  SizedBox(width: 4),
                                  Text(
                                    '+17% vs last month',
                                    style: TextStyle(
                                      color: Color(0xFF5EE0A8),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      const SizedBox(width: 104, height: 70, child: _MiniBars(values: _weekly)),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _HeaderChip(icon: Icons.room_service_rounded, value: '$active/$total', label: 'Live'),
                    const SizedBox(width: 10),
                    _HeaderChip(icon: Icons.inbox_rounded, value: '$open', label: 'Open'),
                    const SizedBox(width: 10),
                    _HeaderChip(icon: Icons.star_rounded, value: rating.toStringAsFixed(1), label: 'Rating'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniBars extends StatelessWidget {
  final List<double> values;

  const _MiniBars({required this.values});

  @override
  Widget build(BuildContext context) {
    final maxV = values.reduce(math.max);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var i = 0; i < values.length; i++)
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: values[i] / maxV),
            duration: Duration(milliseconds: 500 + i * 70),
            curve: Curves.easeOutCubic,
            builder: (_, t, __) => Container(
              width: 9,
              height: 70 * t,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: i == values.length - 1
                      ? const [_C.goldBright, _C.gold]
                      : [Colors.white.withValues(alpha: 0.35), Colors.white.withValues(alpha: 0.12)],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _HeaderChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _HeaderChip({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 10, 10, 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: _C.goldBright),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: _title(17, color: Colors.white, height: 1.1)),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _C.mutedOnNavy, fontSize: 10.5, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Request card ─────────────────────────

class _RequestCard extends StatelessWidget {
  final _Request request;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final VoidCallback onComplete;

  const _RequestCard({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onDecline,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final r = request;
    final isNew = r.status == _ReqStatus.pending;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 272,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isNew ? _C.gold.withValues(alpha: 0.5) : _C.border, width: isNew ? 1.5 : 1),
        boxShadow: [
          BoxShadow(color: _C.navy.withValues(alpha: 0.05), blurRadius: 18, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Avatar(name: r.client, image: r.avatar, size: 36),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  r.client,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: _C.navy),
                ),
              ),
              _Badge(text: r.status.label, background: r.status.color.withValues(alpha: 0.12), foreground: r.status.color),
            ],
          ),
          const SizedBox(height: 14),
          Text(r.service, maxLines: 1, overflow: TextOverflow.ellipsis, style: _title(17)),
          const SizedBox(height: 6),
          _InfoLine(icon: Icons.home_work_outlined, text: r.property),
          const SizedBox(height: 4),
          _InfoLine(icon: Icons.schedule_rounded, text: r.when),
          const Spacer(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: switch (r.status) {
              _ReqStatus.pending => Row(
                  key: const ValueKey('pending'),
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onDecline,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _C.danger,
                          side: BorderSide(color: _C.danger.withValues(alpha: 0.35)),
                          minimumSize: const Size(0, 40),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5),
                        ),
                        child: const Text('Decline'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        onPressed: onAccept,
                        style: FilledButton.styleFrom(
                          backgroundColor: _C.navy,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 40),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5),
                        ),
                        child: const Text('Accept'),
                      ),
                    ),
                  ],
                ),
              _ReqStatus.inProgress => Row(
                  key: const ValueKey('progress'),
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: const LinearProgressIndicator(
                          value: 0.55,
                          minHeight: 6,
                          backgroundColor: _C.track,
                          valueColor: AlwaysStoppedAnimation(_C.info),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton.icon(
                      onPressed: onComplete,
                      icon: const Icon(Icons.check_rounded, size: 18),
                      label: const Text('Done'),
                      style: TextButton.styleFrom(
                        foregroundColor: _C.success,
                        textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5),
                      ),
                    ),
                  ],
                ),
              _ReqStatus.done => Container(
                  key: const ValueKey('done'),
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _C.success.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified_rounded, size: 17, color: _C.success),
                      SizedBox(width: 6),
                      Text(
                        'Service delivered',
                        style: TextStyle(color: _C.success, fontWeight: FontWeight.w800, fontSize: 12.5),
                      ),
                    ],
                  ),
                ),
            },
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: _C.gold),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: _C.muted, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Category bar ─────────────────────────

class _CategoryBar extends StatelessWidget {
  final List<_Cat> categories;
  final _Cat? selected;
  final ValueChanged<_Cat?> onSelected;

  const _CategoryBar({required this.categories, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final options = <_Cat?>[null, ...categories];
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final c = options[i];
          final active = c == selected;
          return GestureDetector(
            onTap: () => onSelected(c),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsetsDirectional.fromSTEB(14, 0, 16, 0),
              decoration: BoxDecoration(
                color: active ? _C.navy : _C.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: active ? _C.navy : _C.border),
              ),
              child: Row(
                children: [
                  Icon(c?.icon ?? Icons.apps_rounded, size: 17, color: active ? _C.goldBright : _C.gold),
                  const SizedBox(width: 8),
                  Text(
                    c?.label ?? 'All',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: active ? Colors.white : _C.navy,
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

// ───────────────────────── Service card ─────────────────────────

class _ServiceCard extends StatelessWidget {
  final _Service service;
  final VoidCallback onToggle;
  final VoidCallback onManage;

  const _ServiceCard({super.key, required this.service, required this.onToggle, required this.onManage});

  static const _grayscale = ColorFilter.matrix(<double>[
    0.33, 0.59, 0.11, 0, 0, //
    0.33, 0.59, 0.11, 0, 0, //
    0.33, 0.59, 0.11, 0, 0, //
    0, 0, 0, 1, 0,
  ]);

  @override
  Widget build(BuildContext context) {
    final s = service;

    return Material(
      color: _C.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
        side: const BorderSide(color: _C.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onManage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: s.active ? 1 : 0.75,
                    child: s.active
                        ? _SmartImage(s.image, iconSize: 48)
                        : ColorFiltered(colorFilter: _grayscale, child: _SmartImage(s.image, iconSize: 48)),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.4, 1],
                        colors: [Colors.transparent, _C.navy.withValues(alpha: 0.75)],
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 14,
                    start: 14,
                    child: _Badge(
                      icon: s.cat.icon,
                      text: s.cat.label,
                      background: _C.navy.withValues(alpha: 0.75),
                      foreground: _C.goldBright,
                    ),
                  ),
                  PositionedDirectional(
                    top: 14,
                    end: 14,
                    child: _Badge(
                      icon: s.active ? Icons.circle : Icons.pause_rounded,
                      text: s.active ? 'Live' : 'Paused',
                      background: s.active ? _C.success : _C.muted,
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 14,
                    start: 16,
                    end: 16,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.price == 'Free' ? 'Free' : 'From ${s.price}',
                                style: _title(24, color: _C.goldBright, height: 1.1),
                              ),
                              Text(
                                s.unit,
                                style: const TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star_rounded, size: 15, color: _C.goldBright),
                              const SizedBox(width: 4),
                              Text(
                                s.rating.toStringAsFixed(1),
                                style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(18, 16, 18, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.name, style: _title(20)),
                  const SizedBox(height: 6),
                  Text(
                    s.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _C.muted, fontSize: 12.5, height: 1.5, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _Stat(icon: Icons.event_available_rounded, text: '${s.bookings} bookings'),
                      const SizedBox(width: 16),
                      Expanded(child: _Stat(icon: Icons.handshake_outlined, text: s.provider)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 22, indent: 18, endIndent: 18, color: _C.track),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
              child: Row(
                children: [
                  _GoldSwitch(value: s.active, onChanged: (_) => onToggle()),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      s.active ? 'Visible to clients' : 'Hidden from clients',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: s.active ? _C.navy : _C.muted,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: onManage,
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.chevron_right_rounded, size: 18),
                    label: const Text('Manage'),
                    style: TextButton.styleFrom(
                      foregroundColor: _C.gold,
                      textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Stat({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: _C.gold),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _C.navySoft),
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Manage sheet ─────────────────────────

class _ServiceSheet extends StatefulWidget {
  final _Service service;

  const _ServiceSheet({required this.service});

  @override
  State<_ServiceSheet> createState() => _ServiceSheetState();
}

class _ServiceSheetState extends State<_ServiceSheet> {
  late final _price = TextEditingController(text: widget.service.price);
  late final _unit = TextEditingController(text: widget.service.unit);
  late final _description = TextEditingController(text: widget.service.description);
  late bool _active = widget.service.active;
  late bool _online = widget.service.onlineBooking;

  @override
  void dispose() {
    _price.dispose();
    _unit.dispose();
    _description.dispose();
    super.dispose();
  }

  void _save() {
    final s = widget.service;
    s
      ..price = _price.text.trim().isEmpty ? s.price : _price.text.trim()
      ..unit = _unit.text.trim()
      ..description = _description.text.trim()
      ..active = _active
      ..onlineBooking = _online;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.service;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.88,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, scroll) => Container(
          decoration: const BoxDecoration(
            color: _C.bg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(color: _C.border, borderRadius: BorderRadius.circular(3)),
              ),
              Expanded(
                child: ListView(
                  controller: scroll,
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 20),
                  children: [
                    // Cover
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: SizedBox(
                        height: 170,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            _SmartImage(s.image, iconSize: 48),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: AlignmentDirectional.centerStart,
                                  end: AlignmentDirectional.centerEnd,
                                  colors: [_C.navy.withValues(alpha: 0.9), _C.navy.withValues(alpha: 0.05)],
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              start: 18,
                              bottom: 18,
                              end: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _Badge(
                                    icon: s.cat.icon,
                                    text: s.cat.label,
                                    background: _C.goldBright,
                                    foreground: _C.navy,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(s.name, style: _title(24, color: Colors.white, height: 1.15)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _SheetStat(value: s.rating.toStringAsFixed(1), label: 'Rating', icon: Icons.star_rounded),
                        const SizedBox(width: 10),
                        _SheetStat(value: '${s.bookings}', label: 'Bookings', icon: Icons.event_available_rounded),
                        const SizedBox(width: 10),
                        const _SheetStat(value: '96%', label: 'On time', icon: Icons.timer_outlined),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text('Pricing', style: _title(19)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(flex: 2, child: _Field(controller: _price, label: 'Starting price')),
                        const SizedBox(width: 10),
                        Expanded(flex: 3, child: _Field(controller: _unit, label: 'Charged')),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Text('Description', style: _title(19)),
                    const SizedBox(height: 10),
                    _Field(controller: _description, label: 'Shown to clients', maxLines: 4),
                    const SizedBox(height: 22),
                    Text('Availability', style: _title(19)),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: _C.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _C.border),
                      ),
                      child: Column(
                        children: [
                          _ToggleRow(
                            icon: Icons.visibility_rounded,
                            title: 'Live on the platform',
                            subtitle: 'Clients can see and request this service',
                            value: _active,
                            onChanged: (v) => setState(() => _active = v),
                          ),
                          const Divider(height: 1, indent: 64, color: _C.track),
                          _ToggleRow(
                            icon: Icons.bolt_rounded,
                            title: 'Instant online booking',
                            subtitle: 'Skip manual approval for new requests',
                            value: _online,
                            onChanged: (v) => setState(() => _online = v),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text('Provider', style: _title(19)),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _C.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _C.border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: _C.navy,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.verified_rounded, color: _C.goldBright),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  s.provider,
                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: _C.navy),
                                ),
                                const Text(
                                  'Verified partner',
                                  style: TextStyle(color: _C.muted, fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, color: _C.muted),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Save bar
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
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _C.navy,
                              side: const BorderSide(color: _C.border, width: 1.5),
                              minimumSize: const Size(0, 52),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: FilledButton.icon(
                            onPressed: _save,
                            icon: const Icon(Icons.check_rounded, size: 20),
                            label: const Text('Save changes'),
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
        ),
      ),
    );
  }
}

class _SheetStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _SheetStat({required this.value, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: _C.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _C.border),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: _C.gold),
            const SizedBox(height: 6),
            Text(value, style: _title(20)),
            Text(label, style: const TextStyle(color: _C.muted, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int maxLines;

  const _Field({required this.controller, required this.label, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: _C.border),
    );
    return TextField(
      controller: controller,
      maxLines: maxLines,
      cursorColor: _C.gold,
      style: const TextStyle(color: _C.navy, fontSize: 14, fontWeight: FontWeight.w600, height: 1.45),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: _C.muted, fontSize: 13, fontWeight: FontWeight.w600),
        floatingLabelStyle: const TextStyle(color: _C.gold, fontWeight: FontWeight.w700),
        filled: true,
        fillColor: _C.surface,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 14),
        enabledBorder: border,
        focusedBorder: border.copyWith(borderSide: const BorderSide(color: _C.gold, width: 1.5)),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 8, 12),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: _C.gold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, size: 19, color: _C.gold),
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