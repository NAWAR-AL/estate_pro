import 'package:estate_pro/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _AboutHero(),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1120),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 64,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        _IntroductionSection(),
                        SizedBox(height: 64),
                        _PurposeSection(),
                        SizedBox(height: 64),
                        _FeaturesSection(),
                        SizedBox(height: 64),
                        _ClosingSection(),
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

class _AboutHero extends StatelessWidget {
  const _AboutHero();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 700;
        final horizontalPadding = isWide ? 56.0 : 24.0;

        return SizedBox(
          height: isWide ? 500 : 440,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/hero_villa.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.94),
                      AppColors.primary.withValues(alpha: 0.68),
                      AppColors.primary.withValues(alpha: 0.20),
                    ],
                    stops: const [0, 0.58, 1],
                  ),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1120),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 40,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 650),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white.withValues(alpha: 0.13),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color:
                                      AppColors.white.withValues(alpha: 0.35),
                                ),
                              ),
                              child: Text(
                                'A BETTER WAY TO FIND YOUR PLACE',
                                style: GoogleFonts.montserrat(
                                  color: AppColors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'About Estate Pro',
                              style: GoogleFonts.playfairDisplay(
                                color: AppColors.white,
                                fontSize: isWide ? 58 : 42,
                                height: 1.08,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              'A thoughtful space to explore properties, '
                              'discover useful services, and move closer to '
                              'a place that feels like yours.',
                              style: GoogleFonts.montserrat(
                                color: AppColors.white.withValues(alpha: 0.90),
                                fontSize: isWide ? 16 : 14,
                                height: 1.8,
                              ),
                            ),
                            const SizedBox(height: 28),
                            Container(
                              width: 52,
                              height: 3,
                              decoration: BoxDecoration(
                                color: AppColors.gold,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _IntroductionSection extends StatelessWidget {
  const _IntroductionSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        final copy = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionEyebrow(label: 'WHO WE ARE'),
            const SizedBox(height: 16),
            Text(
              'Real estate, made more approachable.',
              style: GoogleFonts.playfairDisplay(
                color: AppColors.primary,
                fontSize: isWide ? 38 : 32,
                height: 1.18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Estate Pro brings property discovery and related services '
              'together in one considered experience. Whether you are '
              'looking around or narrowing down your options, the platform '
              'helps you explore at your own pace.',
              style: GoogleFonts.montserrat(
                color: AppColors.secondary,
                fontSize: 14,
                height: 1.9,
              ),
            ),
          ],
        );

        final highlight = Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.home_work_outlined,
                color: AppColors.gold,
                size: 30,
              ),
              const SizedBox(height: 20),
              Text(
                'A place to begin',
                style: GoogleFonts.playfairDisplay(
                  color: AppColors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Explore homes and property information with a clear, '
                'easy-to-follow experience.',
                style: GoogleFonts.montserrat(
                  color: AppColors.white.withValues(alpha: 0.78),
                  fontSize: 13,
                  height: 1.8,
                ),
              ),
            ],
          ),
        );

        if (!isWide) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [copy, const SizedBox(height: 28), highlight],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 6, child: copy),
            const SizedBox(width: 56),
            Expanded(flex: 4, child: highlight),
          ],
        );
      },
    );
  }
}

class _PurposeSection extends StatelessWidget {
  const _PurposeSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;
          final heading = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionEyebrow(label: 'OUR PURPOSE'),
              const SizedBox(height: 14),
              Text(
                'Helping every search feel a little clearer.',
                style: GoogleFonts.playfairDisplay(
                  color: AppColors.primary,
                  fontSize: 30,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          );
          final description = Text(
            'Finding a property is a personal journey. Estate Pro is designed '
            'to make the process easier to navigate by bringing discovery, '
            'saved favourites, and property-related services into view.',
            style: GoogleFonts.montserrat(
              color: AppColors.secondary,
              fontSize: 14,
              height: 1.9,
            ),
          );

          if (!isWide) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [heading, const SizedBox(height: 18), description],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: heading),
              const SizedBox(width: 48),
              Expanded(child: description),
            ],
          );
        },
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  static const _features = [
    _Feature(
      icon: Icons.search_rounded,
      title: 'Explore properties',
      description:
          'Browse property listings and discover options that match what '
          'you are looking for.',
    ),
    _Feature(
      icon: Icons.bookmark_border_rounded,
      title: 'Keep favourites close',
      description:
          'Save properties you are interested in and return to them as you '
          'continue your search.',
    ),
    _Feature(
      icon: Icons.design_services_outlined,
      title: 'Discover helpful services',
      description:
          'Find property-related services designed to support different '
          'parts of your real estate journey.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionEyebrow(label: 'THE ESTATE PRO EXPERIENCE'),
        const SizedBox(height: 14),
        Text(
          'Everything you need to explore.',
          style: GoogleFonts.playfairDisplay(
            color: AppColors.primary,
            fontSize: 34,
            height: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 800
                ? 3
                : constraints.maxWidth >= 520
                    ? 2
                    : 1;
            final cardWidth =
                (constraints.maxWidth - (columns - 1) * 18) / columns;

            return Wrap(
              spacing: 18,
              runSpacing: 18,
              children: [
                for (final feature in _features)
                  SizedBox(
                    width: cardWidth,
                    child: _FeatureCard(feature: feature),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _Feature {
  const _Feature({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature});

  final _Feature feature;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 220),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(feature.icon, color: AppColors.gold, size: 25),
          ),
          const SizedBox(height: 20),
          Text(
            feature.title,
            style: GoogleFonts.montserrat(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            feature.description,
            style: GoogleFonts.montserrat(
              color: AppColors.darkLight,
              fontSize: 12,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _ClosingSection extends StatelessWidget {
  const _ClosingSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EAE2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.stars_outlined, color: AppColors.gold, size: 28),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your next chapter starts with a place.',
                  style: GoogleFonts.playfairDisplay(
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Take your time, explore your options, and make the journey '
                  'your own.',
                  style: GoogleFonts.montserrat(
                    color: AppColors.secondary,
                    fontSize: 13,
                    height: 1.8,
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

class _SectionEyebrow extends StatelessWidget {
  const _SectionEyebrow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.montserrat(
        color: AppColors.gold,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.8,
      ),
    );
  }
}
