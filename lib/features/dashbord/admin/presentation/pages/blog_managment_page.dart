import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography: Playfair Display for titles, Montserrat for text and buttons.
/// Same brand palette as the admin dashboard: deep navy + brass.
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
  static const scheduled = Color(0xFF3B5B8C);
}

/// Put the images in `assets/images/blog/` and register that folder in
/// pubspec.yaml. Missing files show a styled placeholder instead.
class _Img {
  static const featured = 'assets/images/blog/featured.jpg';
  static const a1 = 'assets/images/blog/article_1.jpg';
  static const a2 = 'assets/images/blog/article_2.jpg';
  static const a3 = 'assets/images/blog/article_3.jpg';
  static const a4 = 'assets/images/blog/article_4.jpg';
  static const a5 = 'assets/images/blog/article_5.jpg';
}

// ───────────────────────── Model ─────────────────────────

enum _Status { published, draft, scheduled }

extension _StatusX on _Status {
  String get label => switch (this) {
        _Status.published => 'Published',
        _Status.draft => 'Draft',
        _Status.scheduled => 'Scheduled',
      };

  String get plural => switch (this) {
        _Status.published => 'Published',
        _Status.draft => 'Drafts',
        _Status.scheduled => 'Scheduled',
      };

  Color get color => switch (this) {
        _Status.published => _C.success,
        _Status.draft => _C.pending,
        _Status.scheduled => _C.scheduled,
      };

  IconData get icon => switch (this) {
        _Status.published => Icons.check_circle_rounded,
        _Status.draft => Icons.edit_rounded,
        _Status.scheduled => Icons.schedule_rounded,
      };
}

class _Article {
  final String title;
  final String category;
  final String author;
  final String dateLabel;
  final int readMinutes;
  final int views;
  final _Status status;
  final bool featured;
  final String image;

  const _Article({
    required this.title,
    required this.category,
    required this.author,
    required this.dateLabel,
    required this.readMinutes,
    required this.views,
    required this.status,
    required this.image,
    this.featured = false,
  });

  _Article copyWith({_Status? status, String? dateLabel}) => _Article(
        title: title,
        category: category,
        author: author,
        dateLabel: dateLabel ?? this.dateLabel,
        readMinutes: readMinutes,
        views: views,
        status: status ?? this.status,
        image: image,
        featured: featured,
      );
}

String _compact(int n) => n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}K' : '$n';

String _initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  return parts.take(2).map((p) => p[0].toUpperCase()).join();
}

// ───────────────────────── Page ─────────────────────────

class BlogManagementPage extends StatefulWidget {
  /// Optional: your own handler to open the drawer. If null, the page opens
  /// the nearest Scaffold that has a drawer.
  final VoidCallback? onMenuTap;

  /// Optional: navigate to your article editor.
  final VoidCallback? onNewArticle;

  const BlogManagementPage({super.key, this.onMenuTap, this.onNewArticle});

  @override
  State<BlogManagementPage> createState() => _BlogManagementPageState();
}

class _BlogManagementPageState extends State<BlogManagementPage> {
  _Status? _filter;
  String _query = '';

  // Sample articles: replace with your API.
  final List<_Article> _articles = [
    const _Article(
      title: 'Why Bodrum became the new riviera for luxury buyers',
      category: 'Market insights',
      author: 'Leyla Demir',
      dateLabel: 'Sep 28',
      readMinutes: 6,
      views: 12480,
      status: _Status.published,
      image: _Img.featured,
      featured: true,
    ),
    const _Article(
      title: 'A buyer’s guide to citizenship by investment in 2026',
      category: 'Guides',
      author: 'Omar Haddad',
      dateLabel: 'Sep 24',
      readMinutes: 8,
      views: 3920,
      status: _Status.published,
      image: _Img.a1,
    ),
    const _Article(
      title: 'Five sea-view apartments in Antalya under \$400K',
      category: 'Listings',
      author: 'Leyla Demir',
      dateLabel: 'Oct 4, 09:00',
      readMinutes: 4,
      views: 0,
      status: _Status.scheduled,
      image: _Img.a2,
    ),
    const _Article(
      title: 'How we verify every listing before it goes live',
      category: 'Behind the scenes',
      author: 'Ahmed Pasha',
      dateLabel: 'Edited 2h ago',
      readMinutes: 5,
      views: 0,
      status: _Status.draft,
      image: _Img.a3,
    ),
    const _Article(
      title: 'Istanbul rental yields: what the numbers really say',
      category: 'Market insights',
      author: 'Omar Haddad',
      dateLabel: 'Sep 19',
      readMinutes: 7,
      views: 2140,
      status: _Status.published,
      image: _Img.a4,
    ),
    const _Article(
      title: 'Designing a penthouse that ages gracefully',
      category: 'Interiors',
      author: 'Selin Aydın',
      dateLabel: 'Edited yesterday',
      readMinutes: 6,
      views: 0,
      status: _Status.draft,
      image: _Img.a5,
    ),
    const _Article(
      title: 'Coastal property outlook for the final quarter',
      category: 'Market insights',
      author: 'Leyla Demir',
      dateLabel: 'Oct 12, 10:00',
      readMinutes: 5,
      views: 0,
      status: _Status.scheduled,
      image: _Img.a4,
    ),
  ];

  int _count(_Status s) => _articles.where((a) => a.status == s).length;

  int get _totalViews =>
      _articles.where((a) => a.status == _Status.published).fold(0, (sum, a) => sum + a.views);

  _Article? get _featured {
    for (final a in _articles) {
      if (a.featured && a.status == _Status.published) return a;
    }
    return null;
  }

  bool _matches(_Article a) {
    if (_filter != null && a.status != _filter) return false;
    if (_query.isEmpty) return true;
    return a.title.toLowerCase().contains(_query) ||
        a.category.toLowerCase().contains(_query) ||
        a.author.toLowerCase().contains(_query);
  }

  // ───────────── Actions ─────────────

  void _setStatus(_Article a, _Status status) {
    final i = _articles.indexOf(a);
    if (i < 0) return;
    setState(() {
      _articles[i] = a.copyWith(
        status: status,
        dateLabel: status == _Status.published ? 'Just now' : 'Edited just now',
      );
    });
    _toast(status == _Status.published ? 'Article published' : 'Moved to drafts');
  }

  Future<void> _delete(_Article a) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.ltr,
        child: Theme(
          data: Theme.of(ctx).copyWith(
            textTheme: GoogleFonts.montserratTextTheme(Theme.of(ctx).textTheme),
          ),
          child: AlertDialog(
          backgroundColor: _C.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          icon: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _C.danger.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.delete_outline_rounded, color: _C.danger, size: 26),
          ),
          title: Text(
            'Delete this article?',
            style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w700, color: _C.navy, fontSize: 21),
          ),
          content: Text(
            '“${a.title}” will be removed. You can undo this right after.',
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
      ),
    );

    if (confirmed != true || !mounted) return;
    final i = _articles.indexOf(a);
    if (i < 0) return;
    setState(() => _articles.removeAt(i));
    _toast('Article deleted', onUndo: () => setState(() => _articles.insert(i, a)));
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
    final base = Theme.of(context);
    final featured = _featured;
    final showFeatured = _filter == null && _query.isEmpty && featured != null;
    final items = _articles
        .where(_matches)
        .where((a) => !(showFeatured && identical(a, featured)))
        .toList();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Theme(
        data: base.copyWith(textTheme: GoogleFonts.montserratTextTheme(base.textTheme)),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Scaffold(
            backgroundColor: _C.bg,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: widget.onNewArticle ?? () {},
              backgroundColor: _C.gold,
              foregroundColor: Colors.white,
              elevation: 6,
              shape: const StadiumBorder(),
              icon: const Icon(Icons.edit_note_rounded),
              label: const Text('New article', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _Header(
                    onMenuTap: widget.onMenuTap,
                    published: _count(_Status.published),
                    drafts: _count(_Status.draft),
                    scheduled: _count(_Status.scheduled),
                    views: _compact(_totalViews),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 14),
                  sliver: SliverToBoxAdapter(
                    child: _SearchField(
                      onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _FilterBar(
                    selected: _filter,
                    total: _articles.length,
                    counts: {for (final s in _Status.values) s: _count(s)},
                    onSelected: (s) => setState(() => _filter = s),
                  ),
                ),
                if (showFeatured)
                  SliverPadding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 26, 20, 0),
                    sliver: SliverList.list(
                      children: [
                        const _SectionHeader(title: 'Featured story'),
                        const SizedBox(height: 14),
                        _FeaturedCard(article: featured, onTap: () {}),
                      ],
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 28, 20, 14),
                  sliver: SliverToBoxAdapter(
                    child: _SectionHeader(
                      title: _filter == null ? 'All articles' : _filter!.plural,
                      trailing: Text(
                        '${items.length} ${items.length == 1 ? 'article' : 'articles'}',
                        style: const TextStyle(color: _C.muted, fontWeight: FontWeight.w700, fontSize: 12.5),
                      ),
                    ),
                  ),
                ),
                if (items.isEmpty)
                  const SliverToBoxAdapter(child: _EmptyState())
                else
                  SliverPadding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 110),
                    sliver: SliverList.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) {
                        final a = items[i];
                        return _ArticleTile(
                          article: a,
                          onTap: () {},
                          onEdit: () {},
                          onPublish: () => _setStatus(a, _Status.published),
                          onUnpublish: () => _setStatus(a, _Status.draft),
                          onDelete: () => _delete(a),
                        );
                      },
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

// ───────────────────────── Shared pieces ─────────────────────────

class _SmartImage extends StatelessWidget {
  final String path;
  final double iconSize;

  const _SmartImage(this.path, {this.iconSize = 32});

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
          child: Icon(
            Icons.auto_stories_rounded,
            color: _C.goldBright.withValues(alpha: 0.7),
            size: iconSize,
          ),
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
      child: IconButton(
        tooltip: tooltip,
        onPressed: onTap,
        icon: Icon(icon, color: _C.goldBright),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color background;
  final Color foreground;

  const _Badge({
    this.icon,
    required this.text,
    required this.background,
    this.foreground = Colors.white,
  });

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

class _SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const _SectionHeader({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: _C.navy,
            ),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

// ───────────────────────── Header ─────────────────────────

class _Header extends StatelessWidget {
  final VoidCallback? onMenuTap;
  final int published;
  final int drafts;
  final int scheduled;
  final String views;

  const _Header({
    required this.onMenuTap,
    required this.published,
    required this.drafts,
    required this.scheduled,
    required this.views,
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
          // Brass ring in the end corner (mirrors automatically in RTL).
          PositionedDirectional(
            end: -70,
            top: -60,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _C.gold.withValues(alpha: 0.14), width: 22),
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
                            'Content studio',
                            style: TextStyle(fontSize: 12, color: _C.mutedOnNavy, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Blog management',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _RoundIconButton(
                      icon: Icons.insights_rounded,
                      tooltip: 'Blog analytics',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                Text(
                  'Stories that sell\nevery property.',
                  style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.w700,
              
                    fontSize: 29,
                    height: 1.2,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 22),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        _HeaderStat(value: '$published', label: 'Published', highlight: true),
                        const _VDivider(),
                        _HeaderStat(value: '$drafts', label: 'Drafts'),
                        const _VDivider(),
                        _HeaderStat(value: '$scheduled', label: 'Scheduled'),
                        const _VDivider(),
                        _HeaderStat(value: views, label: 'Total views'),
                      ],
                    ),
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
  final bool highlight;

  const _HeaderStat({required this.value, required this.label, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.w700,
              
              fontSize: 23,
              height: 1.15,
              color: highlight ? _C.goldBright : Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, color: _C.mutedOnNavy, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _VDivider extends StatelessWidget {
  const _VDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: Colors.white.withValues(alpha: 0.1),
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
        hintText: 'Search by title, category or author',
        hintStyle: const TextStyle(color: _C.muted, fontSize: 13.5, fontWeight: FontWeight.w500),
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
  final _Status? selected;
  final int total;
  final Map<_Status, int> counts;
  final ValueChanged<_Status?> onSelected;

  const _FilterBar({
    required this.selected,
    required this.total,
    required this.counts,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final options = <(_Status?, String, int)>[
      (null, 'All', total),
      for (final s in _Status.values) (s, s.plural, counts[s] ?? 0),
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final (status, label, count) = options[i];
          final active = status == selected;
          return GestureDetector(
            onTap: () => onSelected(status),
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
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
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
                      '$count',
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

// ───────────────────────── Featured card ─────────────────────────

class _FeaturedCard extends StatelessWidget {
  final _Article article;
  final VoidCallback onTap;

  const _FeaturedCard({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 300,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: _C.navy,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: _C.navy.withValues(alpha: 0.28),
              blurRadius: 30,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _SmartImage(article.image, iconSize: 70),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.35, 1.0],
                  colors: [
                    _C.navy.withValues(alpha: 0.35),
                    _C.navy.withValues(alpha: 0.05),
                    _C.navy.withValues(alpha: 0.96),
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
                  const SizedBox(width: 8),
                  _Badge(text: article.category, background: Colors.black.withValues(alpha: 0.35)),
                ],
              ),
            ),
            PositionedDirectional(
              top: 16,
              end: 16,
              child: _Badge(
                icon: Icons.visibility_rounded,
                text: _compact(article.views),
                background: Colors.black.withValues(alpha: 0.35),
              ),
            ),
            PositionedDirectional(
              start: 20,
              end: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.w700,
              fontSize: 23, height: 1.25, color: Colors.white),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _AuthorAvatar(name: article.author),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.author,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              article.dateLabel,
                              style: const TextStyle(color: _C.mutedOnNavy, fontSize: 11.5),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.menu_book_rounded, size: 15, color: _C.goldBright),
                      const SizedBox(width: 5),
                      Text(
                        '${article.readMinutes} min read',
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                      ),
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

class _AuthorAvatar extends StatelessWidget {
  final String name;

  const _AuthorAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [_C.goldBright, _C.gold]),
      ),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: _C.navySoft,
        child: Text(
          _initials(name),
          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

// ───────────────────────── Article tile ─────────────────────────

enum _Action { edit, publish, unpublish, delete }

class _ArticleTile extends StatelessWidget {
  final _Article article;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onPublish;
  final VoidCallback onUnpublish;
  final VoidCallback onDelete;

  const _ArticleTile({
    required this.article,
    required this.onTap,
    required this.onEdit,
    required this.onPublish,
    required this.onUnpublish,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final a = article;
    final isPublished = a.status == _Status.published;

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
          padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 6, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail sits on the start side (left in English).
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(width: 96, height: 108, child: _SmartImage(a.image)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: SizedBox(
                  height: 108,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              a.category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: _C.gold,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          _menu(isPublished),
                        ],
                      ),
                      Text(
                        a.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.w700,
              fontSize: 15.5, height: 1.3, color: _C.navy),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          _StatusPill(status: a.status),
                          const SizedBox(width: 10),
                          Flexible(
                            child: _Meta(
                              icon: isPublished ? Icons.visibility_outlined : Icons.calendar_today_rounded,
                              text: isPublished ? '${_compact(a.views)} views' : a.dateLabel,
                            ),
                          ),
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

  Widget _menu(bool isPublished) {
    return SizedBox(
      width: 30,
      height: 26,
      child: PopupMenuButton<_Action>(
        padding: EdgeInsets.zero,
        iconSize: 20,
        icon: const Icon(Icons.more_horiz_rounded, color: _C.muted),
        tooltip: 'Article options',
        color: _C.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onSelected: (action) {
          switch (action) {
            case _Action.edit:
              onEdit();
            case _Action.publish:
              onPublish();
            case _Action.unpublish:
              onUnpublish();
            case _Action.delete:
              onDelete();
          }
        },
        itemBuilder: (_) => [
          _item(_Action.edit, Icons.edit_outlined, 'Edit article'),
          if (isPublished)
            _item(_Action.unpublish, Icons.unpublished_outlined, 'Move to drafts')
          else
            _item(_Action.publish, Icons.public_rounded, 'Publish now'),
          const PopupMenuDivider(height: 8),
          _item(_Action.delete, Icons.delete_outline_rounded, 'Delete', color: _C.danger),
        ],
      ),
    );
  }

  PopupMenuItem<_Action> _item(_Action value, IconData icon, String label, {Color color = _C.navy}) {
    return PopupMenuItem<_Action>(
      value: value,
      height: 44,
      child: Row(
        children: [
          Icon(icon, size: 19, color: color),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 13.5)),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final _Status status;

  const _StatusPill({required this.status});

  @override
  Widget build(BuildContext context) {
    final c = status.color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: 12, color: c),
          const SizedBox(width: 4),
          Text(status.label, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: c)),
        ],
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Meta({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: _C.muted),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11.5, color: _C.muted, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Empty state ─────────────────────────

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
            decoration: BoxDecoration(
              color: _C.gold.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_stories_outlined, color: _C.gold, size: 38),
          ),
          const SizedBox(height: 18),
          Text(
            'No articles here yet',
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.w700,
              fontSize: 22, color: _C.navy),
          ),
          const SizedBox(height: 6),
          const Text(
            'Try a different filter or search term, or write a new article.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _C.muted, height: 1.45),
          ),
        ],
      ),
    );
  }
}