import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Blog list page + article details page in ONE file.
/// Typography: Playfair Display for titles, Montserrat for text and buttons.
class _C {
  static const navy = Color(0xFF0B1F33);
  static const navySoft = Color(0xFF17324F);
  static const gold = Color(0xFFAE8657);
  static const goldBright = Color(0xFFD4AF37);
  static const bg = Color(0xFFF6F5F1);
  static const surface = Colors.white;
  static const ink = Color(0xFF1E293B);
  static const muted = Color(0xFF64748B);
  static const mutedOnNavy = Color(0xFF9FB0C3);
  static const border = Color(0xFFE8E3D9);
  static const track = Color(0xFFF1EFEA);
  static const danger = Color(0xFFDC2626);
}

TextStyle _title(double size, {Color color = _C.navy, double? height}) =>
    GoogleFonts.playfairDisplay(fontSize: size, fontWeight: FontWeight.w700, color: color, height: height);

/// Brand fonts + English left-to-right.
Widget blogBranded(BuildContext context, Widget child) {
  final base = Theme.of(context);
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Theme(
      data: base.copyWith(textTheme: GoogleFonts.montserratTextTheme(base.textTheme)),
      child: child,
    ),
  );
}

String compactNumber(int n) => n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}K' : '$n';

// ───────────────────────── Model & sample articles ─────────────────────────

/// A blog article. Body lines starting with "## " are subheadings and
/// lines starting with "> " are pull quotes; everything else is a paragraph.
class BlogArticle {
  final String id;
  final String title;
  final String excerpt;
  final String category;
  final String author;
  final String authorRole;
  final String authorAvatar;
  final String date;
  final String image;
  final int readMinutes;
  final int views;
  final int likes;
  final List<String> tags;
  final List<String> body;

  const BlogArticle({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.category,
    required this.author,
    required this.authorRole,
    required this.authorAvatar,
    required this.date,
    required this.image,
    required this.readMinutes,
    required this.views,
    required this.likes,
    required this.tags,
    required this.body,
  });
}

/// Sample articles: replace with your API. Images reuse `assets/images/blog/`
/// and author photos reuse the avatars you already added.
const blogArticles = <BlogArticle>[
  BlogArticle(
    id: 'b1',
    title: 'Why Bodrum became the new riviera for luxury buyers',
    excerpt: 'White villages, quiet bays and a new generation of homes have turned the peninsula into a year-round address.',
    category: 'Market insights',
    author: 'Leyla Demir',
    authorRole: 'Senior property advisor',
    authorAvatar: 'assets/images/messages/leyla.jpg',
    date: 'Sep 28, 2026',
    image: 'assets/images/blog/featured.jpg',
    readMinutes: 6,
    views: 12480,
    likes: 842,
    tags: ['Bodrum', 'Luxury market', 'Coastal living'],
    body: [
      'For years Bodrum was a summer story: a few busy months, then shuttered shops and empty marinas. That rhythm has changed. More buyers now treat the peninsula as a home rather than a holiday, and the market has quietly reshaped itself around them.',
      '## A season that no longer ends',
      'Better flight connections, year-round restaurants and a growing number of international schools have stretched the season far beyond August. Owners who once rented out their villas for the summer now spend spring and autumn here themselves.',
      '> The buyers we meet today are not looking for a holiday home. They are looking for a second life.',
      '## What buyers are asking for',
      'Privacy comes first. Homes set back from the busiest bays, with mature gardens and uninterrupted sea views, are in highest demand. Close behind are modern comforts that older stone houses rarely offer: underfloor heating, solar power and space to work from home.',
      'Villages such as Yalıkavak, Türkbükü and Gündoğan each have their own character, so we always suggest spending a few days in each before deciding.',
      '## Our advice',
      'Visit outside the high season, check the access road in winter, and ask for a full title deed review before you sign. A beautiful view is easy to find here; a well-documented home is what protects your investment.',
    ],
  ),
  BlogArticle(
    id: 'b2',
    title: 'A buyer’s guide to citizenship by investment',
    excerpt: 'What the process looks like, the documents you will need, and the mistakes we help clients avoid.',
    category: 'Guides',
    author: 'Omar Haddad',
    authorRole: 'Investment consultant',
    authorAvatar: 'assets/images/messages/omar.jpg',
    date: 'Sep 24, 2026',
    image: 'assets/images/blog/article_1.jpg',
    readMinutes: 8,
    views: 3920,
    likes: 311,
    tags: ['Citizenship', 'Investment', 'Legal'],
    body: [
      'Buying property as a route to residence or citizenship is one of the most common questions we hear. The process is straightforward when it is well prepared, and frustrating when it is not.',
      '## Start with the rules, not the property',
      'Programme requirements change from time to time, so the first step is always to confirm the current rules with a licensed lawyer. Only then does it make sense to shortlist homes that qualify.',
      '> Choose the home you would want even without the passport. That is the one that holds its value.',
      '## Documents to prepare early',
      'Passports, proof of address, bank statements showing the source of funds and certified translations take the longest. Preparing them before you travel can save weeks.',
      '## How we help',
      'Our legal partners check the title deed, the valuation report and the payment trail, so every step of your application is backed by clean paperwork.',
    ],
  ),
  BlogArticle(
    id: 'b3',
    title: 'Five sea-view apartments in Antalya worth a visit',
    excerpt: 'Balconies over the Mediterranean, walkable neighbourhoods and homes that rent well in every season.',
    category: 'Listings',
    author: 'Leyla Demir',
    authorRole: 'Senior property advisor',
    authorAvatar: 'assets/images/messages/leyla.jpg',
    date: 'Sep 20, 2026',
    image: 'assets/images/blog/article_2.jpg',
    readMinutes: 4,
    views: 2860,
    likes: 204,
    tags: ['Antalya', 'Apartments', 'Sea view'],
    body: [
      'Antalya offers something rare: city life and a beach in the same afternoon. We visited dozens of apartments this month and these neighbourhoods stood out.',
      '## Konyaaltı',
      'Long promenades, quiet streets behind the beach and newer buildings with generous balconies. A favourite with families and long-stay renters.',
      '## Lara',
      'Wider avenues, larger plots and resort-style complexes with pools and gardens. Ideal for buyers who want space and calm.',
      '> A balcony facing the sea is worth more than an extra bedroom facing the street.',
      'Ask our team for the full shortlist, with floor plans and viewing slots for next week.',
    ],
  ),
  BlogArticle(
    id: 'b4',
    title: 'How we verify every listing before it goes live',
    excerpt: 'Behind every photo on Estate Pro is a checklist. Here is what happens before a home reaches you.',
    category: 'Behind the scenes',
    author: 'Ahmed Pasha',
    authorRole: 'Head of listings',
    authorAvatar: 'assets/images/admin_avatar.jpg',
    date: 'Sep 16, 2026',
    image: 'assets/images/blog/article_3.jpg',
    readMinutes: 5,
    views: 1740,
    likes: 158,
    tags: ['Trust', 'Verification', 'Estate Pro'],
    body: [
      'A listing is a promise. Before any home appears on Estate Pro, our team checks that the promise can be kept.',
      '## Ownership and documents',
      'We confirm that the seller owns the property and that the title deed matches the address, size and type described in the listing.',
      '## A visit, not just photos',
      'An agent visits every home in person, checks the condition and takes new photos when the originals do not reflect reality.',
      '> If we would not send our own family to see it, it does not go live.',
      'Only after these checks does a listing receive the verified badge you see on the app.',
    ],
  ),
  BlogArticle(
    id: 'b5',
    title: 'Istanbul rental yields: reading the numbers',
    excerpt: 'Which districts balance price and demand, and how to think about returns beyond the headline figure.',
    category: 'Market insights',
    author: 'Omar Haddad',
    authorRole: 'Investment consultant',
    authorAvatar: 'assets/images/messages/omar.jpg',
    date: 'Sep 12, 2026',
    image: 'assets/images/blog/article_4.jpg',
    readMinutes: 7,
    views: 2140,
    likes: 189,
    tags: ['Istanbul', 'Rental yield', 'Investment'],
    body: [
      'Headline yields make for easy comparisons, but they rarely tell the whole story. A sensible estimate starts with realistic rent, then subtracts every cost an owner actually pays.',
      '## Location still decides everything',
      'Districts close to business centres, universities and metro lines tend to rent quickly and hold their tenants longer. That stability often matters more than a slightly higher rent.',
      '> The best yield is the one you can collect every month without a gap.',
      '## Costs people forget',
      'Building fees, maintenance, furnishing, management and periods between tenants all reduce the final return. Our advisors include each of them when preparing a forecast.',
    ],
  ),
  BlogArticle(
    id: 'b6',
    title: 'Designing a penthouse that ages gracefully',
    excerpt: 'Natural materials, honest light and a few pieces you will love for decades.',
    category: 'Interiors',
    author: 'Selin Aydın',
    authorRole: 'Interior designer',
    authorAvatar: 'assets/images/users/mia.jpg',
    date: 'Sep 8, 2026',
    image: 'assets/images/blog/article_5.jpg',
    readMinutes: 6,
    views: 1980,
    likes: 276,
    tags: ['Interiors', 'Penthouse', 'Design'],
    body: [
      'Trends move quickly; good rooms do not. A penthouse deserves a design that will feel right in ten years, not just in this season’s magazines.',
      '## Let the view lead',
      'Keep window lines clear, choose low furniture near the glass and let the city or the sea become the main artwork of the room.',
      '## Materials that improve with time',
      'Oak, stone, linen and brass all gain character as they age. They forgive daily life far better than glossy finishes.',
      '> Buy fewer pieces, but buy the ones you will want to keep.',
      'Finish with warm, layered lighting so the home feels as good at night as it does in daylight.',
    ],
  ),
];

// ───────────────────────── Details page ─────────────────────────

class BlogDetailsPage extends StatefulWidget {
  final BlogArticle article;

  const BlogDetailsPage({super.key, required this.article});

  @override
  State<BlogDetailsPage> createState() => _BlogDetailsPageState();
}

class _BlogDetailsPageState extends State<BlogDetailsPage> {
  final _scroll = ScrollController();
  final _progress = ValueNotifier<double>(0);
  late int _likes = widget.article.likes;
  bool _liked = false;
  bool _saved = false;

  BlogArticle get a => widget.article;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      final max = _scroll.position.maxScrollExtent;
      _progress.value = max <= 0 ? 0 : (_scroll.offset / max).clamp(0.0, 1.0);
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    _progress.dispose();
    super.dispose();
  }

  void _toggleLike() {
    HapticFeedback.lightImpact();
    setState(() {
      _liked = !_liked;
      _likes += _liked ? 1 : -1;
    });
  }

  void _toggleSave() {
    setState(() => _saved = !_saved);
    _toast(_saved ? 'Saved to your reading list' : 'Removed from your reading list');
  }

  void _share() {
    Clipboard.setData(ClipboardData(text: a.title));
    _toast('Title copied, ready to share');
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(fontWeight: FontWeight.w700)),
          behavior: SnackBarBehavior.floating,
          backgroundColor: _C.navy,
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 96),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      );
  }

  void _openRelated(BlogArticle next) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => BlogDetailsPage(article: next),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut), child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final related = [
      ...blogArticles.where((x) => x.id != a.id && x.category == a.category),
      ...blogArticles.where((x) => x.id != a.id && x.category != a.category),
    ].take(3).toList();
    final top = MediaQuery.paddingOf(context).top;

    return blogBranded(
      context,
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: _C.bg,
          body: Stack(
            children: [
              CustomScrollView(
                controller: _scroll,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 420,
                    pinned: true,
                    stretch: true,
                    backgroundColor: _C.navy,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    leadingWidth: 64,
                    leading: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 14),
                      child: _GlassButton(
                        icon: Icons.arrow_back_rounded,
                        tooltip: 'Back',
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                    actions: [
                      _GlassButton(
                        icon: _saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                        tooltip: 'Save',
                        color: _saved ? _C.goldBright : Colors.white,
                        onTap: _toggleSave,
                      ),
                      const SizedBox(width: 8),
                      _GlassButton(icon: Icons.ios_share_rounded, tooltip: 'Share', onTap: _share),
                      const SizedBox(width: 14),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [StretchMode.zoomBackground],
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Hero(tag: 'blog-${a.id}', child: _BlogImage(a.image, iconSize: 80)),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0, 0.3, 0.55, 1],
                                colors: [
                                  _C.navy.withValues(alpha: 0.55),
                                  _C.navy.withValues(alpha: 0.0),
                                  _C.navy.withValues(alpha: 0.15),
                                  _C.navy.withValues(alpha: 0.92),
                                ],
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            start: 22,
                            end: 22,
                            bottom: 48,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _Pill(text: a.category, background: _C.goldBright, foreground: _C.navy),
                                const SizedBox(height: 12),
                                Text(a.title, style: _title(29, color: Colors.white, height: 1.18)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(22, 0, 22, 120),
                    sliver: SliverList.list(
                      children: [
                        _AuthorRow(article: a),
                        const SizedBox(height: 18),
                        _MetaStrip(article: a),
                        const SizedBox(height: 24),
                        Text(
                          a.excerpt,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 19,
                            height: 1.55,
                            fontStyle: FontStyle.italic,
                            color: _C.navySoft,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Container(height: 1, color: _C.border),
                        const SizedBox(height: 22),
                        ..._buildBody(a.body),
                        const SizedBox(height: 26),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final t in a.tags)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _C.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: _C.border),
                                ),
                                child: Text(
                                  '# $t',
                                  style: const TextStyle(color: _C.navySoft, fontSize: 12, fontWeight: FontWeight.w700),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        _AuthorCard(article: a),
                        const SizedBox(height: 34),
                        Text('Continue reading', style: _title(22)),
                        const SizedBox(height: 14),
                        for (final r in related) ...[
                          _RelatedTile(article: r, onTap: () => _openRelated(r)),
                          const SizedBox(height: 12),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              // Gold reading-progress line under the status bar.
              Positioned(
                top: top,
                left: 0,
                right: 0,
                child: ValueListenableBuilder<double>(
                  valueListenable: _progress,
                  builder: (_, v, __) => Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: FractionallySizedBox(
                      widthFactor: v,
                      child: Container(
                        height: 3,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [_C.gold, _C.goldBright]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Floating action bar
              PositionedDirectional(
                start: 22,
                end: 22,
                bottom: 22,
                child: SafeArea(
                  top: false,
                  child: _ReaderBar(
                    liked: _liked,
                    likes: _likes,
                    saved: _saved,
                    onLike: _toggleLike,
                    onSave: _toggleSave,
                    onShare: _share,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBody(List<String> lines) {
    final out = <Widget>[];
    var first = true;
    for (final line in lines) {
      if (line.startsWith('## ')) {
        out.add(Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 10),
          child: Text(line.substring(3), style: _title(22, height: 1.25)),
        ));
      } else if (line.startsWith('> ')) {
        out.add(_PullQuote(text: line.substring(2)));
      } else {
        out.add(Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: first ? _DropCapParagraph(text: line) : _Paragraph(text: line),
        ));
        first = false;
      }
    }
    return out;
  }
}

// ───────────────────────── Pieces ─────────────────────────

class _BlogImage extends StatelessWidget {
  final String path;
  final double iconSize;

  const _BlogImage(this.path, {this.iconSize = 30});

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
            child: Icon(Icons.auto_stories_rounded, color: _C.goldBright.withValues(alpha: 0.7), size: iconSize),
          ),
        );
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  final String name;
  final String path;
  final double size;

  const _Avatar({required this.name, required this.path, this.size = 44});

  @override
  Widget build(BuildContext context) {
    final initials = name.split(' ').take(2).map((p) => p[0]).join();
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
          child: Image.asset(
            path,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => ColoredBox(
              color: _C.navySoft,
              child: Center(
                child: Text(
                  initials,
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

class _GlassButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color color;

  const _GlassButton({required this.icon, required this.tooltip, required this.onTap, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.black.withValues(alpha: 0.3),
        shape: CircleBorder(side: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
        child: IconButton(tooltip: tooltip, onPressed: onTap, icon: Icon(icon, color: color, size: 21)),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;

  const _Pill({required this.text, required this.background, required this.foreground});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(color: foreground, fontSize: 11.5, fontWeight: FontWeight.w800)),
    );
  }
}

class _AuthorRow extends StatelessWidget {
  final BlogArticle article;

  const _AuthorRow({required this.article});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Avatar(name: article.author, path: article.authorAvatar, size: 46),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(article.author, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: _C.navy)),
                  const SizedBox(width: 5),
                  const Icon(Icons.verified_rounded, size: 15, color: _C.gold),
                ],
              ),
              const SizedBox(height: 2),
              Text(article.authorRole, style: const TextStyle(color: _C.muted, fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: _C.gold,
            side: const BorderSide(color: _C.gold, width: 1.4),
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            minimumSize: const Size(0, 36),
            textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5),
          ),
          child: const Text('Follow'),
        ),
      ],
    );
  }
}

class _MetaStrip extends StatelessWidget {
  final BlogArticle article;

  const _MetaStrip({required this.article});

  @override
  Widget build(BuildContext context) {
    Widget item(IconData icon, String text) => Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: _C.gold),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _C.navySoft),
                ),
              ),
            ],
          ),
        );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _C.border),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            item(Icons.calendar_today_rounded, article.date),
            const VerticalDivider(width: 1, color: _C.border),
            item(Icons.menu_book_rounded, '${article.readMinutes} min read'),
            const VerticalDivider(width: 1, color: _C.border),
            item(Icons.visibility_outlined, '${compactNumber(article.views)} views'),
          ],
        ),
      ),
    );
  }
}

const _bodyStyle = TextStyle(fontSize: 15.5, height: 1.8, color: _C.ink, fontWeight: FontWeight.w500);

class _Paragraph extends StatelessWidget {
  final String text;

  const _Paragraph({required this.text});

  @override
  Widget build(BuildContext context) => Text(text, style: _bodyStyle);
}

/// First paragraph opens with a large gold initial, like a printed magazine.
class _DropCapParagraph extends StatelessWidget {
  final String text;

  const _DropCapParagraph({required this.text});

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text[0],
            style: GoogleFonts.playfairDisplay(
              fontSize: 54,
              height: 0.9,
              fontWeight: FontWeight.w700,
              color: _C.gold,
            ),
          ),
          TextSpan(text: text.substring(1)),
        ],
      ),
      style: _bodyStyle,
    );
  }
}

class _PullQuote extends StatelessWidget {
  final String text;

  const _PullQuote({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [_C.navySoft, _C.navy],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('“', style: _title(54, color: _C.goldBright, height: 0.6)),
          const SizedBox(height: 6),
          Text(
            text,
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              height: 1.45,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Container(width: 40, height: 3, color: _C.goldBright),
        ],
      ),
    );
  }
}

class _AuthorCard extends StatelessWidget {
  final BlogArticle article;

  const _AuthorCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _C.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _C.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Avatar(name: article.author, path: article.authorAvatar, size: 56),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Written by', style: TextStyle(color: _C.muted, fontSize: 11.5, fontWeight: FontWeight.w600)),
                    Text(article.author, style: _title(19)),
                    Text(article.authorRole, style: const TextStyle(color: _C.gold, fontSize: 12, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Shares field notes from viewings, negotiations and handovers, so you can buy with confidence.',
            style: TextStyle(color: _C.muted, fontSize: 13, height: 1.55, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_bubble_rounded, size: 18),
                  label: const Text('Ask a question'),
                  style: FilledButton.styleFrom(
                    backgroundColor: _C.navy,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 46),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RelatedTile extends StatelessWidget {
  final BlogArticle article;
  final VoidCallback onTap;

  const _RelatedTile({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _C.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color: _C.border)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(width: 84, height: 84, child: _BlogImage(article.image)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.category,
                      style: const TextStyle(color: _C.gold, fontSize: 11.5, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: _title(15.5, height: 1.3),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${article.readMinutes} min read',
                      style: const TextStyle(color: _C.muted, fontSize: 11.5, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: _C.muted),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReaderBar extends StatelessWidget {
  final bool liked;
  final int likes;
  final bool saved;
  final VoidCallback onLike;
  final VoidCallback onSave;
  final VoidCallback onShare;

  const _ReaderBar({
    required this.liked,
    required this.likes,
    required this.saved,
    required this.onLike,
    required this.onSave,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: _C.navy,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: _C.navy.withValues(alpha: 0.35), blurRadius: 24, offset: const Offset(0, 10)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: onLike,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (c, anim) => ScaleTransition(scale: anim, child: c),
                child: Icon(
                  liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  key: ValueKey(liked),
                  color: liked ? _C.danger : Colors.white,
                ),
              ),
              label: Text(
                compactNumber(likes),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Container(width: 1, height: 26, color: Colors.white.withValues(alpha: 0.12)),
          Expanded(
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.mode_comment_outlined, color: Colors.white),
              label: const Text('Comment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ),
          Container(width: 1, height: 26, color: Colors.white.withValues(alpha: 0.12)),
          IconButton(
            tooltip: 'Save',
            onPressed: onSave,
            icon: Icon(saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                color: saved ? _C.goldBright : Colors.white),
          ),
          IconButton(
            tooltip: 'Share',
            onPressed: onShare,
            icon: const Icon(Icons.ios_share_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════ Blog list page ═════════════════════════

/// The public journal: a featured story, categories and every article.
/// Tapping any article opens [BlogDetailsPage].
class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  String _category = 'All';
  String _query = '';

  void _open(BlogArticle a) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 450),
        reverseTransitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, __, ___) => BlogDetailsPage(article: a),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut), child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['All', ...{for (final a in blogArticles) a.category}];
    final featured = blogArticles.first;
    final showFeatured = _category == 'All' && _query.isEmpty;
    final list = blogArticles.where((a) {
      if (showFeatured && a.id == featured.id) return false;
      if (_category != 'All' && a.category != _category) return false;
      if (_query.isEmpty) return true;
      return a.title.toLowerCase().contains(_query) || a.author.toLowerCase().contains(_query);
    }).toList();
    final top = MediaQuery.paddingOf(context).top;

    return blogBranded(
      context,
      AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: _C.bg,
          body: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Container(
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
                            border: Border.all(color: _C.gold.withValues(alpha: 0.13), width: 24),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, top + 14, 20, 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (Navigator.of(context).canPop()) ...[
                                  Material(
                                    color: Colors.white.withValues(alpha: 0.08),
                                    shape: const CircleBorder(),
                                    child: IconButton(
                                      tooltip: 'Back',
                                      onPressed: () => Navigator.of(context).maybePop(),
                                      icon: const Icon(Icons.arrow_back_rounded, color: _C.goldBright),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Estate Pro',
                                        style: TextStyle(color: _C.mutedOnNavy, fontSize: 12, fontWeight: FontWeight.w600),
                                      ),
                                      Text('The Journal', style: _title(20, color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 22),
                            Text('Stories, guides and\nmarket insights.', style: _title(28, color: Colors.white, height: 1.2)),
                            const SizedBox(height: 18),
                            TextField(
                              onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              cursorColor: _C.goldBright,
                              decoration: InputDecoration(
                                hintText: 'Search articles or authors',
                                hintStyle: const TextStyle(color: _C.mutedOnNavy, fontSize: 13.5),
                                prefixIcon: const Icon(Icons.search_rounded, color: _C.mutedOnNavy),
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
                      ),
                    ],
                  ),
                ),
              ),
              // Categories
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 62,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, i) {
                      final c = categories[i];
                      final active = c == _category;
                      return GestureDetector(
                        onTap: () => setState(() => _category = c),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: active ? _C.navy : _C.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: active ? _C.navy : _C.border),
                          ),
                          child: Text(
                            c,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: active ? Colors.white : _C.navy,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (showFeatured)
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 0),
                  sliver: SliverToBoxAdapter(child: _FeaturedCard(article: featured, onTap: () => _open(featured))),
                ),
              SliverPadding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 28, 20, 14),
                sliver: SliverToBoxAdapter(child: Text('Latest articles', style: _title(21))),
              ),
              if (list.isEmpty)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: Text('No articles found', style: TextStyle(color: _C.muted, fontWeight: FontWeight.w600)),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 40),
                  sliver: SliverList.separated(
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (_, i) => _ArticleCard(article: list[i], onTap: () => _open(list[i])),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Img extends StatelessWidget {
  final String path;

  const _Img(this.path);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => const DecoratedBox(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [_C.navySoft, _C.navy])),
        child: Center(child: Icon(Icons.auto_stories_rounded, color: _C.goldBright)),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final BlogArticle article;
  final VoidCallback onTap;

  const _FeaturedCard({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 340,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: _C.navy,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: _C.navy.withValues(alpha: 0.28), blurRadius: 28, offset: const Offset(0, 14))],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(tag: 'blog-${article.id}', child: _Img(article.image)),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.3, 1],
                  colors: [Colors.transparent, _C.navy.withValues(alpha: 0.96)],
                ),
              ),
            ),
            PositionedDirectional(
              top: 16,
              start: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: _C.goldBright, borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded, size: 13, color: _C.navy),
                    SizedBox(width: 4),
                    Text('Editor’s pick', style: TextStyle(color: _C.navy, fontSize: 11, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              start: 20,
              end: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.category,
                      style: const TextStyle(color: _C.goldBright, fontSize: 12, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(article.title, maxLines: 3, overflow: TextOverflow.ellipsis,
                      style: _title(24, color: Colors.white, height: 1.2)),
                  const SizedBox(height: 10),
                  Text(
                    '${article.author}  |  ${article.readMinutes} min read',
                    style: const TextStyle(color: _C.mutedOnNavy, fontSize: 12, fontWeight: FontWeight.w600),
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

class _ArticleCard extends StatelessWidget {
  final BlogArticle article;
  final VoidCallback onTap;

  const _ArticleCard({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _C.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: const BorderSide(color: _C.border)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  width: 104,
                  height: 116,
                  child: Hero(tag: 'blog-${article.id}', child: _Img(article.image)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.category,
                        style: const TextStyle(color: _C.gold, fontSize: 11.5, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 4),
                    Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: _title(16.5, height: 1.28)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.menu_book_rounded, size: 14, color: _C.muted),
                        const SizedBox(width: 4),
                        Text('${article.readMinutes} min',
                            style: const TextStyle(color: _C.muted, fontSize: 11.5, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 12),
                        const Icon(Icons.visibility_outlined, size: 14, color: _C.muted),
                        const SizedBox(width: 4),
                        Text(compactNumber(article.views),
                            style: const TextStyle(color: _C.muted, fontSize: 11.5, fontWeight: FontWeight.w600)),
                      ],
                    ),
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