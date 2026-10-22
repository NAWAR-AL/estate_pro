import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Brand palette: deep navy + brass, kept from the original design.
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
}

/// Image paths. Put the files in `assets/images/` and register the folder
/// in pubspec.yaml. If a file is missing, a styled placeholder is shown
/// instead, so the app never crashes while you are still adding images.
class _Img {
  static const hero = 'assets/images/hero_villa.jpg';
  static const villa = 'assets/images/luxury_villa.jpg';
  static const apartment = 'assets/images/seaview_apartment.jpg';
  static const penthouse = 'assets/images/modern_penthouse.jpg';
  static const avatar = 'assets/images/admin_avatar.jpg';
}

enum _Range { weekly, monthly, yearly }

class AdminDashboardPage extends StatefulWidget {
  /// Optional: pass your own handler to open the drawer.
  /// If null, the page finds the nearest Scaffold that has a drawer and opens it.
  final VoidCallback? onMenuTap;

  const AdminDashboardPage({super.key, this.onMenuTap});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  _Range _range = _Range.weekly;

  // Weekly values are from the original design.
  // Monthly and yearly values are sample data: replace them with your API.
  static const Map<_Range, List<double>> _chartData = {
    _Range.weekly: [9, 11, 7, 13, 10, 14, 17],
    _Range.monthly: [42, 55, 48, 61],
    _Range.yearly: [120, 135, 128, 150, 162, 158, 171, 180, 176, 190, 205, 214],
  };

  static const Map<_Range, List<String>> _chartLabels = {
    _Range.weekly: ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
    _Range.monthly: ['Wk 1', 'Wk 2', 'Wk 3', 'Wk 4'],
    _Range.yearly: ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'],
  };

  static const Map<_Range, String> _rangeNames = {
    _Range.weekly: 'Week',
    _Range.monthly: 'Month',
    _Range.yearly: 'Year',
  };

  // Sample listings: replace with your data source.
  static const List<_PendingProperty> _pending = [
    _PendingProperty(
      title: 'Luxury Villa',
      location: 'Istanbul, Sarıyer',
      submitted: '2h ago',
      price: '\$1,250,000',
      beds: 5,
      area: '420 m²',
      image: _Img.villa,
    ),
    _PendingProperty(
      title: 'Sea-view Apartment',
      location: 'Antalya, Konyaaltı',
      submitted: '5h ago',
      price: '\$385,000',
      beds: 3,
      area: '145 m²',
      image: _Img.apartment,
    ),
    _PendingProperty(
      title: 'Modern Penthouse',
      location: 'Bodrum, Yalıkavak',
      submitted: 'Yesterday',
      price: '\$940,000',
      beds: 4,
      area: '260 m²',
      image: _Img.penthouse,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context);

    // English UI → left-to-right. Every padding, alignment and position below
    // is "directional" (start/end), so the whole layout, including where the
    // photos sit, mirrors automatically if you ever switch to RTL.
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Theme(
        data: base.copyWith(
          textTheme: GoogleFonts.manropeTextTheme(base.textTheme),
        ),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Scaffold(
            backgroundColor: _C.bg,
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _Header(unread: 3, onMenuTap: widget.onMenuTap)),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 22, 20, 0),
                  sliver: SliverList.list(
                    children: [
                      _HeroBanner(pendingCount: 12, onReview: () {}),
                      const SizedBox(height: 24),
                      const _QuickActions(),
                      const SizedBox(height: 30),
                      const _SectionHeader(title: 'Overview'),
                      const SizedBox(height: 14),
                      _buildStatsGrid(),
                      const SizedBox(height: 30),
                      _buildPerformanceCard(),
                      const SizedBox(height: 30),
                      _SectionHeader(
                        title: 'Awaiting review',
                        actionLabel: 'See all',
                        onAction: () {},
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 336,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 18),
                      itemCount: _pending.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
                      itemBuilder: (_, i) => _PropertyCard(
                        property: _pending[i],
                        onApprove: () {},
                        onReject: () {},
                      ),
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 32),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate.fixed([
                      _SectionHeader(title: 'Recent activity'),
                      SizedBox(height: 14),
                      _ActivityCard(),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────── Stats ─────────────────────────

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.22,
      children: const [
        _StatCard(
          title: 'Total properties',
          value: '124',
          growth: '+8.4%',
          isPositive: true,
          icon: Icons.home_work_rounded,
          accent: _C.gold,
        ),
        _StatCard(
          title: 'Pending requests',
          value: '12',
          growth: '-2.1%',
          isPositive: false,
          icon: Icons.pending_actions_rounded,
          accent: _C.pending,
        ),
        _StatCard(
          title: 'Registered users',
          value: '1,420',
          growth: '+14.2%',
          isPositive: true,
          icon: Icons.people_alt_rounded,
          accent: _C.navySoft,
        ),
        _StatCard(
          title: 'New messages',
          value: '8',
          growth: '+5.0%',
          isPositive: true,
          icon: Icons.forum_rounded,
          accent: _C.success,
        ),
      ],
    );
  }

  // ─────────────────────── Performance card ───────────────────────

  Widget _buildPerformanceCard() {
    final values = _chartData[_range]!;
    final total = values.fold<double>(0, (a, b) => a + b).toInt();

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 14),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: _C.border),
        boxShadow: [
          BoxShadow(
            color: _C.navy.withValues(alpha: 0.05),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Incoming requests',
                      style: TextStyle(fontSize: 13, color: _C.muted, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ),
              const _GrowthChip(value: '+18.2%', isPositive: true, large: true),
            ],
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              '$total',
              key: ValueKey(total),
              style: GoogleFonts.dmSerifDisplay(fontSize: 40, color: _C.navy, height: 1.1),
            ),
          ),
          Text(
            'requests this ${_rangeNames[_range]!.toLowerCase()}',
            style: const TextStyle(fontSize: 12.5, color: _C.muted),
          ),
          const SizedBox(height: 18),
          _buildRangeSelector(),
          const SizedBox(height: 22),
          _buildChart(),
        ],
      ),
    );
  }

  Widget _buildRangeSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _C.track,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          for (final r in _Range.values)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() => _range = r),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 240),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: r == _range ? _C.navy : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: r == _range
                        ? [
                            BoxShadow(
                              color: _C.navy.withValues(alpha: 0.25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    _rangeNames[r]!,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: r == _range ? Colors.white : _C.muted,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    final values = _chartData[_range]!;
    final labels = _chartLabels[_range]!;
    final maxValue = values.reduce(math.max);
    final maxY = (maxValue * 1.25).ceilToDouble();
    final peakIndex = values.indexOf(maxValue);

    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: LineChart(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          LineChartData(
            minX: 0,
            maxX: (values.length - 1).toDouble(),
            minY: 0,
            maxY: maxY,
            lineTouchData: LineTouchData(
              getTouchedSpotIndicator: (bar, indexes) => indexes
                  .map(
                    (_) => TouchedSpotIndicatorData(
                      FlLine(
                        color: _C.gold.withValues(alpha: 0.5),
                        strokeWidth: 1.5,
                        dashArray: [4, 4],
                      ),
                      FlDotData(
                        getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                          radius: 6,
                          color: Colors.white,
                          strokeWidth: 3,
                          strokeColor: _C.gold,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (_) => _C.navy,
                tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                tooltipMargin: 12,
                getTooltipItems: (spots) => spots
                    .map(
                      (s) => LineTooltipItem(
                        '${labels[s.x.toInt()]}\n',
                        const TextStyle(color: _C.mutedOnNavy, fontSize: 11, fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: '${s.y.toInt()} requests',
                            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: maxY / 4,
              getDrawingHorizontalLine: (_) => FlLine(
                color: _C.track,
                strokeWidth: 1,
                dashArray: [4, 4],
              ),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final i = value.toInt();
                    if (i < 0 || i >= labels.length || value != i.toDouble()) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        labels[i],
                        style: TextStyle(
                          color: i == peakIndex ? _C.gold : _C.muted,
                          fontWeight: i == peakIndex ? FontWeight.w800 : FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  for (var i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i]),
                ],
                isCurved: true,
                curveSmoothness: 0.35,
                preventCurveOverShooting: true,
                barWidth: 3.5,
                isStrokeCapRound: true,
                gradient: const LinearGradient(colors: [_C.navySoft, _C.gold]),
                dotData: FlDotData(
                  show: true,
                  checkToShowDot: (spot, _) => spot.x.toInt() == peakIndex,
                  getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                    radius: 5.5,
                    color: _C.goldBright,
                    strokeWidth: 3,
                    strokeColor: Colors.white,
                  ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _C.gold.withValues(alpha: 0.28),
                      _C.gold.withValues(alpha: 0.0),
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

// ───────────────────────── Images ─────────────────────────

/// Loads an asset image and falls back to [fallback] if the file is missing.
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
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}

class _ImageFallback extends StatelessWidget {
  final IconData icon;
  final double iconSize;

  const _ImageFallback({this.icon = Icons.villa_rounded, this.iconSize = 40});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_C.navySoft, _C.navy],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Center(
        child: Icon(icon, color: _C.goldBright.withValues(alpha: 0.7), size: iconSize),
      ),
    );
  }
}

// ───────────────────────── Header ─────────────────────────

class _Header extends StatelessWidget {
  final int unread;
  final VoidCallback? onMenuTap;

  const _Header({required this.unread, this.onMenuTap});

  /// Walks up the tree to the first Scaffold that actually has a drawer.
  /// Works whether the drawer lives in this page's Scaffold or in a parent one.
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
      padding: EdgeInsetsDirectional.fromSTEB(20, top + 14, 20, 24),
      decoration: const BoxDecoration(
        color: _C.navy,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _RoundIconButton(
                icon: Icons.menu_rounded,
                tooltip: 'Menu',
                onTap: onMenuTap ?? () => _openDrawer(context),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [_C.goldBright, _C.gold]),
                ),
                child: const ClipOval(
                  child: SizedBox(
                    width: 42,
                    height: 42,
                    child: _SmartImage(
                      _Img.avatar,
                      fallback: ColoredBox(
                        color: _C.navySoft,
                        child: Center(
                          child: Text(
                            'AP',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning, Ahmed',
                      style: TextStyle(fontSize: 12.5, color: _C.mutedOnNavy, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Admin dashboard',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
              _RoundIconButton(
                icon: Icons.notifications_none_rounded,
                tooltip: 'Notifications',
                badge: unread,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            style: const TextStyle(color: Colors.white, fontSize: 14),
            cursorColor: _C.goldBright,
            decoration: InputDecoration(
              hintText: 'Search properties, users or requests',
              hintStyle: const TextStyle(color: _C.mutedOnNavy, fontSize: 13.5),
              prefixIcon: const Icon(Icons.search_rounded, color: _C.mutedOnNavy),
              suffixIcon: Container(
                margin: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: _C.gold,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(Icons.tune_rounded, color: Colors.white, size: 19),
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.07),
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: _C.gold),
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
  final int badge;
  final VoidCallback onTap;

  const _RoundIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.badge = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.white.withValues(alpha: 0.08),
          shape: const CircleBorder(),
          child: IconButton(
            tooltip: tooltip,
            onPressed: onTap,
            icon: Icon(icon, color: _C.goldBright),
          ),
        ),
        if (badge > 0)
          PositionedDirectional(
            top: -2,
            end: -2,
            child: Container(
              constraints: const BoxConstraints(minWidth: 18),
              height: 18,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _C.danger,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: _C.navy, width: 2),
              ),
              child: Text(
                '$badge',
                style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w800),
              ),
            ),
          ),
      ],
    );
  }
}

// ───────────────────────── Hero banner ─────────────────────────

class _HeroBanner extends StatelessWidget {
  final int pendingCount;
  final VoidCallback onReview;

  const _HeroBanner({required this.pendingCount, required this.onReview});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _C.navy,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: _C.navy.withValues(alpha: 0.28),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // The photo fills the card; the scrim below darkens only the
          // text side (start), so the photo stays visible on the end side.
          const _SmartImage(
            _Img.hero,
            fallback: _ImageFallback(icon: Icons.villa_rounded, iconSize: 72),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.centerStart,
                end: AlignmentDirectional.centerEnd,
                stops: const [0.0, 0.55, 1.0],
                colors: [
                  _C.navy.withValues(alpha: 0.97),
                  _C.navy.withValues(alpha: 0.78),
                  _C.navy.withValues(alpha: 0.05),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(22, 20, 0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$pendingCount',
                          style: GoogleFonts.dmSerifDisplay(
                            fontSize: 52,
                            height: 1,
                            color: _C.goldBright,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'new listings are waiting for your review',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.5,
                            height: 1.35,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    FilledButton.icon(
                      onPressed: onReview,
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                      label: const Text('Review listings'),
                      style: FilledButton.styleFrom(
                        backgroundColor: _C.gold,
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 16, 12),
                        textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
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

// ───────────────────────── Quick actions ─────────────────────────

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _QuickAction(icon: Icons.add_home_work_rounded, label: 'Add listing', highlighted: true),
        _QuickAction(icon: Icons.fact_check_rounded, label: 'Approvals'),
        _QuickAction(icon: Icons.person_add_alt_1_rounded, label: 'Invite user'),
        _QuickAction(icon: Icons.bar_chart_rounded, label: 'Reports'),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool highlighted;

  const _QuickAction({required this.icon, required this.label, this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: highlighted ? _C.navy : _C.surface,
                borderRadius: BorderRadius.circular(20),
                border: highlighted ? null : Border.all(color: _C.border),
              ),
              child: Icon(icon, color: highlighted ? _C.goldBright : _C.navy, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _C.navy),
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Section header ─────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _SectionHeader({required this.title, this.actionLabel, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: _C.navy,
              letterSpacing: -0.3,
            ),
          ),
        ),
        if (actionLabel != null)
          TextButton.icon(
            onPressed: onAction,
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.chevron_right_rounded, size: 18),
            label: Text(actionLabel!),
            style: TextButton.styleFrom(
              foregroundColor: _C.gold,
              textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
            ),
          ),
      ],
    );
  }
}

// ───────────────────────── Stat card ─────────────────────────

class _GrowthChip extends StatelessWidget {
  final String value;
  final bool isPositive;
  final bool large;

  const _GrowthChip({required this.value, required this.isPositive, this.large = false});

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? _C.success : _C.danger;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: large ? 10 : 7, vertical: large ? 6 : 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
            size: large ? 15 : 13,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(fontSize: large ? 12 : 10.5, fontWeight: FontWeight.w800, color: color),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String growth;
  final bool isPositive;
  final IconData icon;
  final Color accent;

  const _StatCard({
    required this.title,
    required this.value,
    required this.growth,
    required this.isPositive,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _C.border),
      ),
      child: Stack(
        children: [
          // Soft accent circle in the end corner (mirrors in RTL).
          PositionedDirectional(
            end: -26,
            top: -26,
            child: Container(
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accent.withValues(alpha: 0.07),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.13),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(icon, color: accent, size: 20),
                    ),
                    const Spacer(),
                    _GrowthChip(value: growth, isPositive: isPositive),
                  ],
                ),
                const Spacer(),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: _C.navy,
                    letterSpacing: -0.8,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12.5, color: _C.muted, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Property card ─────────────────────────

class _PendingProperty {
  final String title;
  final String location;
  final String submitted;
  final String price;
  final int beds;
  final String area;
  final String image;

  const _PendingProperty({
    required this.title,
    required this.location,
    required this.submitted,
    required this.price,
    required this.beds,
    required this.area,
    required this.image,
  });
}

class _PropertyCard extends StatelessWidget {
  final _PendingProperty property;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _PropertyCard({
    required this.property,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _C.border),
        boxShadow: [
          BoxShadow(
            color: _C.navy.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 140,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _SmartImage(property.image, fallback: const _ImageFallback()),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.45, 1.0],
                      colors: [Colors.transparent, Color(0xA60B1F33)],
                    ),
                  ),
                ),
                PositionedDirectional(
                  top: 10,
                  start: 10,
                  child: _Badge(
                    icon: Icons.schedule_rounded,
                    text: 'Pending',
                    background: _C.pending,
                  ),
                ),
                PositionedDirectional(
                  top: 10,
                  end: 10,
                  child: _Badge(
                    text: property.submitted,
                    background: Colors.black.withValues(alpha: 0.4),
                  ),
                ),
                PositionedDirectional(
                  bottom: 10,
                  start: 12,
                  child: Text(
                    property.price,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 22, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: _C.navy),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded, size: 14, color: _C.gold),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        property.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: _C.muted, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _Spec(icon: Icons.bed_rounded, text: '${property.beds} beds'),
                    const SizedBox(width: 14),
                    _Spec(icon: Icons.square_foot_rounded, text: property.area),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onReject,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _C.danger,
                          side: BorderSide(color: _C.danger.withValues(alpha: 0.35)),
                          minimumSize: const Size(0, 40),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5),
                        ),
                        child: const Text('Reject'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        onPressed: onApprove,
                        style: FilledButton.styleFrom(
                          backgroundColor: _C.navy,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 40),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5),
                        ),
                        child: const Text('Approve'),
                      ),
                    ),
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

class _Badge extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color background;

  const _Badge({this.icon, required this.text, required this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: Colors.white),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _Spec extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Spec({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: _C.navySoft),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _C.navySoft),
        ),
      ],
    );
  }
}

// ───────────────────────── Activity ─────────────────────────

class _ActivityCard extends StatelessWidget {
  const _ActivityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _C.border),
      ),
      child: const Column(
        children: [
          _ActivityTile(
            icon: Icons.person_add_alt_1_rounded,
            color: _C.navySoft,
            title: 'New agent registered',
            subtitle: 'Sara Kaya joined the platform',
            time: '10m',
          ),
          Divider(height: 1, indent: 72, color: _C.track),
          _ActivityTile(
            icon: Icons.check_circle_rounded,
            color: _C.success,
            title: 'Listing approved',
            subtitle: 'Garden House in Izmir is now live',
            time: '1h',
          ),
          Divider(height: 1, indent: 72, color: _C.track),
          _ActivityTile(
            icon: Icons.mark_chat_unread_rounded,
            color: _C.gold,
            title: 'New inquiry',
            subtitle: 'A buyer asked about Sea-view Apartment',
            time: '3h',
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String time;

  const _ActivityTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 16, 14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 21),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _C.navy),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: _C.muted, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            time,
            style: const TextStyle(fontSize: 11.5, color: _C.muted, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}