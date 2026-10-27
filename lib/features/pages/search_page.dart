import 'package:estate_pro/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PropertySearchPage extends StatelessWidget {
  const PropertySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(child: PropertySearchBody()),
    );
  }
}

class PropertySearchBody extends StatelessWidget {
  const PropertySearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = <String>['3 Bedroom', '1 Bath', '350K-900K'];

    final properties = <PropertyListing>[
      PropertyListing(
        title: 'Rose Cottage',
        location: 'Bondi NSW 2026',
        rating: '4.2',
        price: '\$50,000/n',
        bedrooms: '3 Bedroom',
        imagePath: 'assets/images/1.jpg',
      ),
      PropertyListing(
        title: 'Serendipity',
        location: 'Balmain NSW 2041',
        rating: '4.5',
        price: '\$30,000/n',
        bedrooms: '3 Bedroom',
        imagePath: 'assets/images/home2.jpg',
      ),
      PropertyListing(
        title: 'Willow House',
        location: 'Surry Hills NSW 2010',
        rating: '4.4',
        price: '\$45,000/n',
        bedrooms: '2 Bedroom',
        imagePath: 'assets/images/home3.jpg',
      ),
      PropertyListing(
        title: 'The Mews',
        location: 'Paddington NSW 2021',
        rating: '4.8',
        price: '\$65,000/n',
        bedrooms: '4 Bedroom',
        imagePath: 'assets/images/home4.jpg',
      ),
      PropertyListing(
        title: 'Parkview Heights',
        location: 'Chippendale NSW 2008',
        rating: '4.6',
        price: '\$70,000/n',
        bedrooms: '2 Bedroom',
        imagePath: 'assets/images/home5.jpg',
      ),
    ];

    return Column(
      children: [
        const PropertySearchHeader(),
        const SizedBox(height: 12),
        PropertyFilterChips(filters: filters),
        const SizedBox(height: 14),
        const PropertyResultsHeader(),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemCount: properties.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final property = properties[index];
              return PropertyCard(property: property);
            },
          ),
        ),
      ],
    );
  }
}

class PropertySearchHeader extends StatelessWidget {
  const PropertySearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
            color: AppColors.primary,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Search Property',
                style:
                    Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ) ??
                    const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.link_rounded, size: 21),
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class PropertyFilterChips extends StatelessWidget {
  final List<String> filters;

  const PropertyFilterChips({super.key, required this.filters});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final filter = filters[index];
          return FilterChipWidget(label: filter);
        },
      ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;

  const FilterChipWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.close_rounded, size: 16, color: AppColors.white),
        ],
      ),
    );
  }
}

class PropertyResultsHeader extends StatelessWidget {
  const PropertyResultsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              '134 Result',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            'Sort by: Date',
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkLight,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ) ??
                const TextStyle(
                  color: AppColors.darkLight,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}

class PropertyListing {
  final String title;
  final String location;
  final String rating;
  final String price;
  final String bedrooms;
  final String imagePath;

  PropertyListing({
    required this.title,
    required this.location,
    required this.rating,
    required this.price,
    required this.bedrooms,
    required this.imagePath,
  });
}

class PropertyCard extends StatelessWidget {
  final PropertyListing property;

  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 190,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      property.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const PropertyImagePlaceholder();
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Row(
                    children: [
                      _ImageOverlayChip(label: 'Home'),
                      const SizedBox(width: 8),
                      _ImageOverlayChip(label: property.bedrooms),
                      const SizedBox(width: 8),
                      _ImageOverlayChip(label: 'For Rent'),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.favorite_border,
                        size: 20,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.title,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.darkLight,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        property.location,
                        style: const TextStyle(
                          color: AppColors.darkLight,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: AppColors.gold),
                    const SizedBox(width: 4),
                    Text(
                      property.rating,
                      style: const TextStyle(
                        color: AppColors.darkLight,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      property.price,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 26,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Detail',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
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

class PropertyImagePlaceholder extends StatelessWidget {
  const PropertyImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.secondary, AppColors.primary],
        ),
      ),
      child: const Center(
        child: Icon(Icons.home_outlined, size: 56, color: AppColors.white),
      ),
    );
  }
}

class _ImageOverlayChip extends StatelessWidget {
  final String label;

  const _ImageOverlayChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
