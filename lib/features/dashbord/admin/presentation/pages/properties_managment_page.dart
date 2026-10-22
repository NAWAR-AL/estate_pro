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
  static const rent = Color(0xFF3B5B8C);
}

/// New photos live in `assets/images/properties/`.
/// The rest reuse images you already added for the other pages.
class _Img {
  static const yali = 'assets/images/properties/bosphorus_yali.jpg';
  static const cliff = 'assets/images/properties/cliff_villa.jpg';
  static const garden = 'assets/images/properties/garden_house.jpg';
  static const residence = 'assets/images/properties/city_residence.jpg';
  static const stone = 'assets/images/properties/stone_house.jpg';
  static const beach = 'assets/images/properties/beach_house.jpg';

  static const villa = 'assets/images/luxury_villa.jpg';
  static const apartment = 'assets/images/seaview_apartment.jpg';
  static const penthouse = 'assets/images/modern_penthouse.jpg';
  static const hillside = 'assets/images/hero_villa.jpg';

  static const leyla = 'assets/images/messages/leyla.jpg';
  static const mehmet = 'assets/images/messages/mehmet.jpg';
}

TextStyle _title(double size, {Color color = _C.navy, double? height}) =>
    GoogleFonts.playfairDisplay(fontSize: size, fontWeight: FontWeight.w700, color: color, height: height);

/// Brand fonts + English left-to-right, for this page and the screens it pushes.
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

String _money(int v) {
  if (v >= 1000000) {
    final m = v / 1000000;
    final s = m.toStringAsFixed(m >= 10 ? 1 : 2).replaceAll(RegExp(r'\.?0+$'), '');
    return '\$${s}M';
  }
  if (v >= 100000) return '\$${(v / 1000).round()}K';
  final s = v.toString();
  final out = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) out.write(',');
    out.write(s[i]);
  }
  return '\$$out';
}

String _compact(int n) => n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}K' : '$n';

// ───────────────────────── Model ─────────────────────────

enum _Status { active, pending, sold }

enum _Type { villa, apartment, penthouse, house }

extension _TypeX on _Type {
  String get label => switch (this) {
        _Type.villa => 'Villa',
        _Type.apartment => 'Apartment',
        _Type.penthouse => 'Penthouse',
        _Type.house => 'House',
      };

  IconData get icon => switch (this) {
        _Type.villa => Icons.villa_rounded,
        _Type.apartment => Icons.apartment_rounded,
        _Type.penthouse => Icons.location_city_rounded,
        _Type.house => Icons.cottage_rounded,
      };
}

enum _Filter { all, sale, rent, pending, sold }

extension _FilterX on _Filter {
  String get label => switch (this) {
        _Filter.all => 'All',
        _Filter.sale => 'For sale',
        _Filter.rent => 'For rent',
        _Filter.pending => 'Pending',
        _Filter.sold => 'Sold',
      };
}

enum _Sort { newest, priceHigh, priceLow, popular }

extension _SortX on _Sort {
  String get label => switch (this) {
        _Sort.newest => 'Newest',
        _Sort.priceHigh => 'Price: high to low',
        _Sort.priceLow => 'Price: low to high',
        _Sort.popular => 'Most viewed',
      };
}

class _Agent {
  final String name;
  final String avatar;

  const _Agent(this.name, this.avatar);
}

const _leyla = _Agent('Leyla Demir', _Img.leyla);
const _mehmet = _Agent('Mehmet Arslan', _Img.mehmet);

class _Property {
  final String id;
  final String title;
  final String location;
  final int price;
  final bool forRent;
  final _Type type;
  final int beds;
  final int baths;
  final int area;
  final int views;
  final int inquiries;
  final int saves;
  final int listedDays;
  final String image;
  final _Agent agent;
  _Status status;
  bool featured;

  _Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.type,
    required this.beds,
    required this.baths,
    required this.area,
    required this.views,
    required this.inquiries,
    required this.saves,
    required this.listedDays,
    required this.image,
    required this.agent,
    this.forRent = false,
    this.status = _Status.active,
    this.featured = false,
  });

  String get priceLabel => forRent ? '${_money(price)}/mo' : _money(price);

  String get statusLabel => switch (status) {
        _Status.active => forRent ? 'For rent' : 'For sale',
        _Status.pending => 'Pending',
        _Status.sold => forRent ? 'Rented' : 'Sold',
      };

  Color get statusColor => switch (status) {
        _Status.active => forRent ? _C.rent : _C.success,
        _Status.pending => _C.pending,
        _Status.sold => _C.danger,
      };

  String get listedLabel => switch (listedDays) {
        0 => 'Listed today',
        1 => 'Listed yesterday',
        < 30 => 'Listed ${listedDays}d ago',
        _ => 'Listed ${listedDays ~/ 30}mo ago',
      };

  String get description =>
      'A refined ${type.label.toLowerCase()} in $location with $beds bedrooms, $baths bathrooms '
      'and $area m² of light-filled living space. Thoughtful finishes, generous terraces and '
      'a calm, private setting make it one of the standout homes in our portfolio.';
}

// Sample portfolio: replace with your API.
List<_Property> _seed() => [
      _Property(
        id: 'p1', title: 'Bosphorus Yalı', location: 'Istanbul, Bebek', price: 8900000,
        type: _Type.villa, beds: 7, baths: 6, area: 980, views: 6420, inquiries: 54, saves: 380,
        listedDays: 5, image: _Img.yali, agent: _mehmet, featured: true,
      ),
      _Property(
        id: 'p2', title: 'Cliffside Villa', location: 'Antalya, Kaş', price: 2350000,
        type: _Type.villa, beds: 4, baths: 4, area: 360, views: 3980, inquiries: 41, saves: 265,
        listedDays: 2, image: _Img.cliff, agent: _leyla, featured: true,
      ),
      _Property(
        id: 'p3', title: 'Luxury Villa', location: 'Istanbul, Sarıyer', price: 1250000,
        type: _Type.villa, beds: 5, baths: 4, area: 420, views: 2840, inquiries: 38, saves: 210,
        listedDays: 9, image: _Img.villa, agent: _leyla, featured: true,
      ),
      _Property(
        id: 'p4', title: 'Hillside Villa', location: 'Bodrum, Türkbükü', price: 1780000,
        type: _Type.villa, beds: 5, baths: 5, area: 450, views: 2310, inquiries: 29, saves: 174,
        listedDays: 14, image: _Img.hillside, agent: _mehmet, status: _Status.pending,
      ),
      _Property(
        id: 'p5', title: 'Modern Penthouse', location: 'Bodrum, Yalıkavak', price: 940000,
        type: _Type.penthouse, beds: 4, baths: 3, area: 260, views: 1960, inquiries: 22, saves: 143,
        listedDays: 1, image: _Img.penthouse, agent: _leyla, status: _Status.pending,
      ),
      _Property(
        id: 'p6', title: 'Garden House', location: 'Izmir, Urla', price: 4800, forRent: true,
        type: _Type.house, beds: 4, baths: 3, area: 310, views: 1420, inquiries: 18, saves: 96,
        listedDays: 3, image: _Img.garden, agent: _mehmet,
      ),
      _Property(
        id: 'p7', title: 'Skyline Residence', location: 'Istanbul, Levent', price: 6500, forRent: true,
        type: _Type.apartment, beds: 2, baths: 2, area: 120, views: 1190, inquiries: 15, saves: 88,
        listedDays: 6, image: _Img.residence, agent: _leyla,
      ),
      _Property(
        id: 'p8', title: 'Stone House', location: 'Izmir, Alaçatı', price: 690000,
        type: _Type.house, beds: 3, baths: 2, area: 180, views: 2050, inquiries: 26, saves: 190,
        listedDays: 12, image: _Img.stone, agent: _mehmet,
      ),
      _Property(
        id: 'p9', title: 'Sea-view Apartment', location: 'Antalya, Konyaaltı', price: 385000,
        type: _Type.apartment, beds: 3, baths: 2, area: 145, views: 1640, inquiries: 31, saves: 120,
        listedDays: 20, image: _Img.apartment, agent: _mehmet,
      ),
      _Property(
        id: 'p10', title: 'Beach House', location: 'Bodrum, Gümbet', price: 1450000,
        type: _Type.house, beds: 4, baths: 3, area: 240, views: 3120, inquiries: 47, saves: 230,
        listedDays: 45, image: _Img.beach, agent: _leyla, status: _Status.sold,
      ),
    ];

// ───────────────────────── Page ─────────────────────────

class PropertiesManagementPage extends StatefulWidget {
  /// Optional: your own handler to open the drawer. If null, the page opens
  /// the nearest Scaffold that has a drawer.
  final VoidCallback? onMenuTap;

  /// Optional: navigate to your "add property" form.
  final VoidCallback? onAddProperty;

  const PropertiesManagementPage({super.key, this.onMenuTap, this.onAddProperty});

  @override
  State<PropertiesManagementPage> createState() => _PropertiesManagementPageState();
}

class _PropertiesManagementPageState extends State<PropertiesManagementPage> {
  final List<_Property> _items = _seed();
  _Filter _filter = _Filter.all;
  _Sort _sort = _Sort.newest;
  String _query = '';
  bool _grid = true;

  bool _passes(_Property p, _Filter f) => switch (f) {
        _Filter.all => true,
        _Filter.sale => p.status == _Status.active && !p.forRent,
        _Filter.rent => p.status == _Status.active && p.forRent,
        _Filter.pending => p.status == _Status.pending,
        _Filter.sold => p.status == _Status.sold,
      };

  List<_Property> get _visible {
    final list = _items.where((p) {
      if (!_passes(p, _filter)) return false;
      if (_query.isEmpty) return true;
      return p.title.toLowerCase().contains(_query) ||
          p.location.toLowerCase().contains(_query) ||
          p.type.label.toLowerCase().contains(_query);
    }).toList();
    switch (_sort) {
      case _Sort.newest:
        list.sort((a, b) => a.listedDays.compareTo(b.listedDays));
      case _Sort.priceHigh:
        list.sort((a, b) => b.price.compareTo(a.price));
      case _Sort.priceLow:
        list.sort((a, b) => a.price.compareTo(b.price));
      case _Sort.popular:
        list.sort((a, b) => b.views.compareTo(a.views));
    }
    return list;
  }

  int get _portfolioValue =>
      _items.where((p) => !p.forRent && p.status != _Status.sold).fold(0, (s, p) => s + p.price);

  int _countWhere(bool Function(_Property) test) => _items.where(test).length;

  // ───────────── Actions ─────────────

  Future<void> _open(_Property p) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 450),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, __, ___) => _PropertyDetailsPage(property: p),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut), child: child),
      ),
    );
    if (mounted) setState(() {});
  }

  void _handle(_Property p, _CardAction action) {
    switch (action) {
      case _CardAction.edit:
        break; // Navigate to your edit form here.
      case _CardAction.feature:
        setState(() => p.featured = !p.featured);
        _toast(p.featured ? 'Added to spotlight' : 'Removed from spotlight');
      case _CardAction.sold:
        final before = p.status;
        setState(() => p.status = _Status.sold);
        _toast(p.forRent ? 'Marked as rented' : 'Marked as sold',
            onUndo: () => setState(() => p.status = before));
      case _CardAction.relist:
        setState(() => p.status = _Status.active);
        _toast('Listing is active again');
      case _CardAction.delete:
        _delete(p);
    }
  }

  Future<void> _delete(_Property p) async {
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
            child: const Icon(Icons.delete_outline_rounded, color: _C.danger, size: 26),
          ),
          title: Text('Delete this listing?', style: _title(21)),
          content: Text(
            '“${p.title}” will be removed from your portfolio. You can undo this right after.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: _C.muted, height: 1.45),
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
              child: const Text('Delete', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
    if (ok != true || !mounted) return;
    final i = _items.indexOf(p);
    if (i < 0) return;
    setState(() => _items.removeAt(i));
    _toast('Listing deleted', onUndo: () => setState(() => _items.insert(i, p)));
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
    final visible = _visible;
    final spotlight = _items.where((p) => p.featured && p.status != _Status.sold).toList();
    final showSpotlight = spotlight.isNotEmpty && _filter == _Filter.all && _query.isEmpty;

    return _branded(
      context,
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: _C.bg,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: widget.onAddProperty ?? () {},
            backgroundColor: _C.gold,
            foregroundColor: Colors.white,
            elevation: 6,
            shape: const StadiumBorder(),
            icon: const Icon(Icons.add_home_work_rounded),
            label: const Text('Add property', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _Header(
                  onMenuTap: widget.onMenuTap,
                  value: _money(_portfolioValue),
                  active: _countWhere((p) => p.status == _Status.active),
                  pending: _countWhere((p) => p.status == _Status.pending),
                  sold: _countWhere((p) => p.status == _Status.sold),
                ),
              ),
              if (showSpotlight) ...[
                const _SliverTitle(title: 'Spotlight', subtitle: 'Featured on the home page'),
                SliverToBoxAdapter(child: _Spotlight(items: spotlight, onOpen: _open)),
              ],
              SliverPadding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 26, 20, 14),
                sliver: SliverToBoxAdapter(
                  child: _SearchField(onChanged: (v) => setState(() => _query = v.trim().toLowerCase())),
                ),
              ),
              SliverToBoxAdapter(
                child: _FilterBar(
                  selected: _filter,
                  counts: {for (final f in _Filter.values) f: _items.where((p) => _passes(p, f)).length},
                  onSelected: (f) => setState(() => _filter = f),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 22, 20, 14),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Portfolio', style: _title(21)),
                            Text(
                              '${visible.length} ${visible.length == 1 ? 'property' : 'properties'}',
                              style: const TextStyle(color: _C.muted, fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      _SortButton(value: _sort, onChanged: (s) => setState(() => _sort = s)),
                      const SizedBox(width: 8),
                      _ViewToggle(grid: _grid, onChanged: (g) => setState(() => _grid = g)),
                    ],
                  ),
                ),
              ),
              if (visible.isEmpty)
                const SliverToBoxAdapter(child: _EmptyState())
              else if (_grid)
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 110),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 12,
                      mainAxisExtent: 286,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => _GridCard(
                        property: visible[i],
                        onTap: () => _open(visible[i]),
                        onAction: (a) => _handle(visible[i], a),
                      ),
                      childCount: visible.length,
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 110),
                  sliver: SliverList.separated(
                    itemCount: visible.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => _ListCard(
                      property: visible[i],
                      onTap: () => _open(visible[i]),
                      onAction: (a) => _handle(visible[i], a),
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
  final double iconSize;

  const _SmartImage(this.path, {this.iconSize = 30});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, error, __) {
        debugPrint('⚠️ Image failed to load: "$path"  →  $error');
        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_C.navySoft, _C.navy],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
          ),
          child: Center(
            child: Icon(Icons.villa_rounded, color: _C.goldBright.withValues(alpha: 0.7), size: iconSize),
          ),
        );
      },
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
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: foreground),
            const SizedBox(width: 4),
          ],
          Text(text, style: TextStyle(color: foreground, fontSize: 10.5, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _Spec extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final double size;

  const _Spec({required this.icon, required this.text, this.color = _C.navySoft, this.size = 11.5});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: size + 3, color: color.withValues(alpha: 0.85)),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: size, fontWeight: FontWeight.w700, color: color)),
      ],
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
      padding: const EdgeInsetsDirectional.fromSTEB(20, 26, 20, 14),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: _title(21)),
            if (subtitle != null)
              Text(
                subtitle!,
                style: const TextStyle(color: _C.muted, fontSize: 12, fontWeight: FontWeight.w600),
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
  final String value;
  final int active;
  final int pending;
  final int sold;

  const _Header({
    required this.onMenuTap,
    required this.value,
    required this.active,
    required this.pending,
    required this.sold,
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
                            'Listings studio',
                            style: TextStyle(fontSize: 12, color: _C.mutedOnNavy, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text('Properties', style: _title(20, color: Colors.white)),
                        ],
                      ),
                    ),
                    _RoundIconButton(icon: Icons.map_outlined, tooltip: 'Map view', onTap: () {}),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Homes worth\nwaiting for.',
                  style: _title(30, color: Colors.white, height: 1.15),
                ),
                const SizedBox(height: 22),
                // Portfolio value card
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      colors: [
                        _C.gold.withValues(alpha: 0.28),
                        _C.gold.withValues(alpha: 0.08),
                      ],
                    ),
                    border: Border.all(color: _C.goldBright.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Portfolio value on the market',
                              style: TextStyle(color: _C.mutedOnNavy, fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ),
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
                                  '+6.8%',
                                  style: TextStyle(color: Color(0xFF5EE0A8), fontSize: 11, fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(value, style: _title(38, color: _C.goldBright, height: 1.1)),
                      const SizedBox(height: 16),
                      Container(height: 1, color: Colors.white.withValues(alpha: 0.1)),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          _HeaderStat(value: '$active', label: 'Active', color: const Color(0xFF5EE0A8)),
                          _HeaderStat(value: '$pending', label: 'Pending', color: const Color(0xFFF3C46B)),
                          _HeaderStat(value: '$sold', label: 'Closed', color: const Color(0xFFF59A9A)),
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
}

class _HeaderStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _HeaderStat({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(value, style: _title(19, color: Colors.white)),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: _C.mutedOnNavy, fontSize: 11.5, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Spotlight carousel ─────────────────────────

class _Spotlight extends StatefulWidget {
  final List<_Property> items;
  final ValueChanged<_Property> onOpen;

  const _Spotlight({required this.items, required this.onOpen});

  @override
  State<_Spotlight> createState() => _SpotlightState();
}

class _SpotlightState extends State<_Spotlight> {
  final _controller = PageController(viewportFraction: 0.86);
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() => _page = _controller.page ?? 0));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = _page.round().clamp(0, widget.items.length - 1);

    return Column(
      children: [
        SizedBox(
          height: 340,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            itemBuilder: (_, i) {
              final distance = (i - _page).abs().clamp(0.0, 1.0);
              return Transform.scale(
                scale: 1 - distance * 0.07,
                child: Opacity(
                  opacity: 1 - distance * 0.35,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: _SpotlightCard(
                      property: widget.items[i],
                      parallax: (i - _page).clamp(-1.0, 1.0),
                      onTap: () => widget.onOpen(widget.items[i]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < widget.items.length; i++)
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == current ? 22 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: i == current ? _C.gold : _C.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _SpotlightCard extends StatelessWidget {
  final _Property property;
  final double parallax;
  final VoidCallback onTap;

  const _SpotlightCard({required this.property, required this.parallax, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = property;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: _C.navy,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: _C.navy.withValues(alpha: 0.3), blurRadius: 24, offset: const Offset(0, 14)),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Subtle parallax: the photo drifts slower than the card.
            Transform.translate(
              offset: Offset(parallax * -40, 0),
              child: Transform.scale(scale: 1.18, child: _SmartImage(p.image, iconSize: 64)),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 0.3, 1],
                  colors: [
                    _C.navy.withValues(alpha: 0.4),
                    _C.navy.withValues(alpha: 0.0),
                    _C.navy.withValues(alpha: 0.97),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              top: 16,
              start: 16,
              child: Row(
                children: [
                  const _Badge(
                    icon: Icons.star_rounded,
                    text: 'Featured',
                    background: _C.goldBright,
                    foreground: _C.navy,
                  ),
                  const SizedBox(width: 6),
                  _Badge(text: p.statusLabel, background: p.statusColor),
                ],
              ),
            ),
            PositionedDirectional(
              top: 16,
              end: 16,
              child: _Badge(
                icon: Icons.visibility_rounded,
                text: _compact(p.views),
                background: Colors.black.withValues(alpha: 0.35),
              ),
            ),
            PositionedDirectional(
              start: 20,
              end: 20,
              bottom: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.priceLabel, style: _title(30, color: _C.goldBright, height: 1.1)),
                  const SizedBox(height: 4),
                  Text(
                    p.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _title(21, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, size: 14, color: _C.goldBright),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          p.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: _C.mutedOnNavy, fontSize: 12.5, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _Spec(icon: Icons.bed_rounded, text: '${p.beds} beds', color: Colors.white, size: 12),
                        _Spec(icon: Icons.bathtub_outlined, text: '${p.baths} baths', color: Colors.white, size: 12),
                        _Spec(icon: Icons.square_foot_rounded, text: '${p.area} m²', color: Colors.white, size: 12),
                      ],
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

// ───────────────────────── Toolbar ─────────────────────────

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
        hintText: 'Search by name, city or type',
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
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: active ? Colors.white : _C.navy,
                    ),
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

class _SortButton extends StatelessWidget {
  final _Sort value;
  final ValueChanged<_Sort> onChanged;

  const _SortButton({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_Sort>(
      tooltip: 'Sort',
      initialValue: value,
      onSelected: onChanged,
      color: _C.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      itemBuilder: (_) => [
        for (final s in _Sort.values)
          PopupMenuItem(
            value: s,
            height: 44,
            child: Row(
              children: [
                Icon(
                  s == value ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                  size: 18,
                  color: s == value ? _C.gold : _C.muted,
                ),
                const SizedBox(width: 10),
                Text(s.label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.navy)),
              ],
            ),
          ),
      ],
      child: Container(
        height: 40,
        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 10, 0),
        decoration: BoxDecoration(
          color: _C.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _C.border),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.swap_vert_rounded, size: 18, color: _C.navy),
            SizedBox(width: 4),
            Text('Sort', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: _C.navy)),
          ],
        ),
      ),
    );
  }
}

class _ViewToggle extends StatelessWidget {
  final bool grid;
  final ValueChanged<bool> onChanged;

  const _ViewToggle({required this.grid, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Widget option(bool isGrid, IconData icon, String tip) {
      final active = grid == isGrid;
      return Tooltip(
        message: tip,
        child: GestureDetector(
          onTap: () => onChanged(isGrid),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 36,
            height: 32,
            decoration: BoxDecoration(
              color: active ? _C.navy : Colors.transparent,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 18, color: active ? _C.goldBright : _C.muted),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _C.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          option(true, Icons.grid_view_rounded, 'Grid view'),
          option(false, Icons.view_agenda_outlined, 'List view'),
        ],
      ),
    );
  }
}

// ───────────────────────── Cards ─────────────────────────

enum _CardAction { edit, feature, sold, relist, delete }

class _CardMenu extends StatelessWidget {
  final _Property property;
  final ValueChanged<_CardAction> onAction;
  final bool onImage;

  const _CardMenu({required this.property, required this.onAction, this.onImage = false});

  @override
  Widget build(BuildContext context) {
    final p = property;
    return PopupMenuButton<_CardAction>(
      tooltip: 'Listing options',
      onSelected: onAction,
      color: _C.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      itemBuilder: (_) => [
        _item(_CardAction.edit, Icons.edit_outlined, 'Edit listing'),
        if (p.status != _Status.sold)
          _item(
            _CardAction.feature,
            p.featured ? Icons.star_outline_rounded : Icons.star_rounded,
            p.featured ? 'Remove from spotlight' : 'Add to spotlight',
          ),
        if (p.status == _Status.sold)
          _item(_CardAction.relist, Icons.replay_rounded, 'Relist property')
        else
          _item(_CardAction.sold, Icons.handshake_outlined, p.forRent ? 'Mark as rented' : 'Mark as sold'),
        const PopupMenuDivider(height: 8),
        _item(_CardAction.delete, Icons.delete_outline_rounded, 'Delete', color: _C.danger),
      ],
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: onImage ? Colors.black.withValues(alpha: 0.35) : _C.track,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.more_horiz_rounded, size: 18, color: onImage ? Colors.white : _C.muted),
      ),
    );
  }

  PopupMenuItem<_CardAction> _item(_CardAction v, IconData icon, String label, {Color color = _C.navy}) {
    return PopupMenuItem(
      value: v,
      height: 44,
      child: Row(
        children: [
          Icon(icon, size: 19, color: color),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 13)),
        ],
      ),
    );
  }
}

class _GridCard extends StatelessWidget {
  final _Property property;
  final VoidCallback onTap;
  final ValueChanged<_CardAction> onAction;

  const _GridCard({required this.property, required this.onTap, required this.onAction});

  @override
  Widget build(BuildContext context) {
    final p = property;
    final sold = p.status == _Status.sold;

    return Material(
      color: _C.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: const BorderSide(color: _C.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 140,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'property-${p.id}',
                    child: ColorFiltered(
                      colorFilter: sold
                          ? const ColorFilter.matrix(<double>[
                              0.6, 0.3, 0.1, 0, 0, //
                              0.3, 0.6, 0.1, 0, 0, //
                              0.3, 0.3, 0.4, 0, 0, //
                              0, 0, 0, 1, 0,
                            ])
                          : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
                      child: _SmartImage(p.image),
                    ),
                  ),
                  PositionedDirectional(
                    top: 10,
                    start: 10,
                    child: _Badge(text: p.statusLabel, background: p.statusColor),
                  ),
                  PositionedDirectional(
                    top: 6,
                    end: 6,
                    child: _CardMenu(property: p, onAction: onAction, onImage: true),
                  ),
                  if (p.featured && !sold)
                    const PositionedDirectional(
                      bottom: 10,
                      start: 10,
                      child: _Badge(
                        icon: Icons.star_rounded,
                        text: 'Spotlight',
                        background: _C.goldBright,
                        foreground: _C.navy,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.priceLabel, style: _title(19, color: sold ? _C.muted : _C.gold)),
                  const SizedBox(height: 2),
                  Text(
                    p.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: _C.navy),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, size: 12, color: _C.gold),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          p.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 11, color: _C.muted, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(height: 1, color: _C.track),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Spec(icon: Icons.bed_rounded, text: '${p.beds}'),
                      _Spec(icon: Icons.bathtub_outlined, text: '${p.baths}'),
                      _Spec(icon: Icons.square_foot_rounded, text: '${p.area}m²'),
                    ],
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

class _ListCard extends StatelessWidget {
  final _Property property;
  final VoidCallback onTap;
  final ValueChanged<_CardAction> onAction;

  const _ListCard({required this.property, required this.onTap, required this.onAction});

  @override
  Widget build(BuildContext context) {
    final p = property;
    final sold = p.status == _Status.sold;

    return Material(
      color: _C.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: const BorderSide(color: _C.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // Photo on the start side (left in English).
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 118,
                  height: 132,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(tag: 'property-${p.id}', child: _SmartImage(p.image)),
                      PositionedDirectional(
                        top: 8,
                        start: 8,
                        child: _Badge(text: p.statusLabel, background: p.statusColor),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: SizedBox(
                  height: 132,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(p.type.icon, size: 14, color: _C.gold),
                                const SizedBox(width: 5),
                                Text(
                                  p.type.label,
                                  style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: _C.gold),
                                ),
                                if (p.featured && !sold) ...[
                                  const SizedBox(width: 6),
                                  const Icon(Icons.star_rounded, size: 14, color: _C.goldBright),
                                ],
                              ],
                            ),
                          ),
                          _CardMenu(property: p, onAction: onAction),
                        ],
                      ),
                      Text(
                        p.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _title(17),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        p.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11.5, color: _C.muted, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(p.priceLabel, style: _title(18, color: sold ? _C.muted : _C.gold)),
                          const Spacer(),
                          _Spec(icon: Icons.bed_rounded, text: '${p.beds}'),
                          const SizedBox(width: 10),
                          _Spec(icon: Icons.square_foot_rounded, text: '${p.area}'),
                        ],
                      ),
                    ],
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

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 30, 40, 120),
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(color: _C.gold.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.home_work_outlined, color: _C.gold, size: 36),
          ),
          const SizedBox(height: 18),
          Text('No properties found', style: _title(21)),
          const SizedBox(height: 6),
          const Text(
            'Try a different filter or search term, or add a new property.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _C.muted, height: 1.45),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Details screen ─────────────────────────

class _PropertyDetailsPage extends StatefulWidget {
  final _Property property;

  const _PropertyDetailsPage({required this.property});

  @override
  State<_PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<_PropertyDetailsPage> {
  _Property get p => widget.property;

  void _toggleSold() {
    setState(() => p.status = p.status == _Status.sold ? _Status.active : _Status.sold);
  }

  @override
  Widget build(BuildContext context) {
    final sold = p.status == _Status.sold;

    return _branded(
      context,
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: _C.bg,
          bottomNavigationBar: _ActionBar(
            sold: sold,
            forRent: p.forRent,
            onToggleSold: _toggleSold,
            onEdit: () {},
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 380,
                pinned: true,
                stretch: true,
                backgroundColor: _C.navy,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12),
                  child: _GlassButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: 'Back',
                    onTap: () => Navigator.of(context).maybePop(),
                  ),
                ),
                leadingWidth: 60,
                actions: [
                  _GlassButton(icon: Icons.ios_share_rounded, tooltip: 'Share', onTap: () {}),
                  const SizedBox(width: 8),
                  _GlassButton(icon: Icons.edit_outlined, tooltip: 'Edit', onTap: () {}),
                  const SizedBox(width: 12),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(tag: 'property-${p.id}', child: _SmartImage(p.image, iconSize: 80)),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0, 0.3, 0.7, 1],
                            colors: [
                              _C.navy.withValues(alpha: 0.55),
                              _C.navy.withValues(alpha: 0.0),
                              _C.navy.withValues(alpha: 0.0),
                              _C.navy.withValues(alpha: 0.6),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Rounded "sheet" edge that the content slides up from.
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(28),
                  child: Container(
                    height: 28,
                    decoration: const BoxDecoration(
                      color: _C.bg,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 30),
                sliver: SliverList.list(
                  children: [
                    Row(
                      children: [
                        _Badge(text: p.statusLabel, background: p.statusColor),
                        const SizedBox(width: 8),
                        _Badge(icon: p.type.icon, text: p.type.label, background: _C.navy, foreground: _C.goldBright),
                        const Spacer(),
                        Text(
                          p.listedLabel,
                          style: const TextStyle(color: _C.muted, fontSize: 11.5, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(p.title, style: _title(30, height: 1.15)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded, size: 16, color: _C.gold),
                        const SizedBox(width: 4),
                        Text(
                          p.location,
                          style: const TextStyle(color: _C.muted, fontSize: 13.5, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(p.priceLabel, style: _title(34, color: sold ? _C.muted : _C.gold)),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        _FeatureTile(icon: Icons.bed_rounded, value: '${p.beds}', label: 'Bedrooms'),
                        const SizedBox(width: 10),
                        _FeatureTile(icon: Icons.bathtub_outlined, value: '${p.baths}', label: 'Bathrooms'),
                        const SizedBox(width: 10),
                        _FeatureTile(icon: Icons.square_foot_rounded, value: '${p.area}', label: 'm² area'),
                      ],
                    ),
                    const SizedBox(height: 22),
                    _PerformanceCard(property: p),
                    const SizedBox(height: 26),
                    Text('About this home', style: _title(21)),
                    const SizedBox(height: 10),
                    Text(
                      p.description,
                      style: const TextStyle(color: _C.muted, fontSize: 14, height: 1.65, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 26),
                    Text('Listing agent', style: _title(21)),
                    const SizedBox(height: 12),
                    _AgentCard(agent: p.agent),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _GlassButton({required this.icon, required this.tooltip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.black.withValues(alpha: 0.3),
        shape: CircleBorder(side: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
        child: IconButton(
          tooltip: tooltip,
          onPressed: onTap,
          icon: Icon(icon, color: Colors.white, size: 21),
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _FeatureTile({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: _C.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _C.border),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(color: _C.gold.withValues(alpha: 0.12), shape: BoxShape.circle),
              child: Icon(icon, color: _C.gold, size: 20),
            ),
            const SizedBox(height: 10),
            Text(value, style: _title(22)),
            Text(label, style: const TextStyle(color: _C.muted, fontSize: 11.5, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _PerformanceCard extends StatelessWidget {
  final _Property property;

  const _PerformanceCard({required this.property});

  @override
  Widget build(BuildContext context) {
    final p = property;
    final conversion = p.views == 0 ? 0 : (p.inquiries / p.views * 100);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [_C.navySoft, _C.navy],
        ),
        boxShadow: [
          BoxShadow(color: _C.navy.withValues(alpha: 0.22), blurRadius: 24, offset: const Offset(0, 12)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.insights_rounded, color: _C.goldBright, size: 20),
              const SizedBox(width: 8),
              Expanded(child: Text('Listing performance', style: _title(18, color: Colors.white))),
              Text(
                '${conversion.toStringAsFixed(1)}% conversion',
                style: const TextStyle(color: _C.goldBright, fontSize: 11.5, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _PerfStat(icon: Icons.visibility_rounded, value: _compact(p.views), label: 'Views'),
              _PerfStat(icon: Icons.forum_rounded, value: '${p.inquiries}', label: 'Inquiries'),
              _PerfStat(icon: Icons.favorite_rounded, value: '${p.saves}', label: 'Saves'),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: (conversion / 3).clamp(0.0, 1.0).toDouble(),
              minHeight: 6,
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              valueColor: const AlwaysStoppedAnimation(_C.goldBright),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Compared with the 3% portfolio benchmark',
            style: TextStyle(color: _C.mutedOnNavy, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _PerfStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _PerfStat({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: _C.mutedOnNavy),
          const SizedBox(height: 6),
          Text(value, style: _title(22, color: Colors.white)),
          Text(label, style: const TextStyle(color: _C.mutedOnNavy, fontSize: 11.5, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _AgentCard extends StatelessWidget {
  final _Agent agent;

  const _AgentCard({required this.agent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _C.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [_C.goldBright, _C.gold]),
            ),
            child: ClipOval(child: SizedBox(width: 50, height: 50, child: _SmartImage(agent.avatar, iconSize: 20))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(agent.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: _C.navy)),
                const SizedBox(height: 2),
                const Row(
                  children: [
                    Icon(Icons.verified_rounded, size: 14, color: _C.gold),
                    SizedBox(width: 4),
                    Text(
                      'Senior property advisor',
                      style: TextStyle(fontSize: 12, color: _C.muted, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _CircleAction(icon: Icons.chat_bubble_outline_rounded, tooltip: 'Message', onTap: () {}),
          const SizedBox(width: 8),
          _CircleAction(icon: Icons.call_rounded, tooltip: 'Call', onTap: () {}, filled: true),
        ],
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool filled;

  const _CircleAction({required this.icon, required this.tooltip, required this.onTap, this.filled = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? _C.navy : _C.track,
      shape: const CircleBorder(),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onTap,
        icon: Icon(icon, size: 20, color: filled ? _C.goldBright : _C.navy),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  final bool sold;
  final bool forRent;
  final VoidCallback onToggleSold;
  final VoidCallback onEdit;

  const _ActionBar({required this.sold, required this.forRent, required this.onToggleSold, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        border: const Border(top: BorderSide(color: _C.border)),
        boxShadow: [
          BoxShadow(color: _C.navy.withValues(alpha: 0.06), blurRadius: 20, offset: const Offset(0, -6)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onToggleSold,
                  icon: Icon(sold ? Icons.replay_rounded : Icons.handshake_outlined, size: 19),
                  label: Text(sold ? 'Relist' : (forRent ? 'Mark rented' : 'Mark sold')),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _C.navy,
                    side: const BorderSide(color: _C.border, width: 1.5),
                    minimumSize: const Size(0, 52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_rounded, size: 19),
                  label: const Text('Edit listing'),
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
    );
  }
}