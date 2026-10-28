import 'package:estate_pro/features/properties/presentation/pages/properties_details_page.dart';
import 'package:estate_pro/features/widgets/custom_appbar.dart';
import 'package:estate_pro/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({super.key});

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  final _searchController = TextEditingController();
  String _query = '';

  static const _properties = <_Property>[
    _Property(
      title: 'Modern Villa',
      location: 'Los Angeles, CA',
      price: '\$450,000',
      tag: 'For Sale',
      image: 'assets/images/luxury_villa.jpg',
      beds: '4',
      baths: '3',
      area: '320 m²',
    ),
    _Property(
      title: 'Family House',
      location: 'New York, NY',
      price: '\$320,000',
      tag: 'For Sale',
      image: 'assets/images/properties/garden_house.jpg',
      beds: '3',
      baths: '2',
      area: '280 m²',
    ),
    _Property(
      title: 'Luxury Apartment',
      location: 'Dubai, UAE',
      price: '\$2,800 /month',
      tag: 'For Rent',
      image: 'assets/images/modern_penthouse.jpg',
      beds: '2',
      baths: '2',
      area: '150 m²',
    ),
    _Property(
      title: 'Beach House',
      location: 'Malibu, CA',
      price: '\$1,250,000',
      tag: 'For Sale',
      image: 'assets/images/properties/beach_house.jpg',
      beds: '5',
      baths: '4',
      area: '420 m²',
    ),
    _Property(
      title: 'City Residence',
      location: 'Istanbul, TR',
      price: '\$95,000',
      tag: 'For Sale',
      image: 'assets/images/properties/city_residence.jpg',
      beds: '2',
      baths: '1',
      area: '110 m²',
    ),
    _Property(
      title: 'Stone House',
      location: 'Bodrum, TR',
      price: '\$680,000',
      tag: 'For Sale',
      image: 'assets/images/properties/stone_house.jpg',
      beds: '4',
      baths: '3',
      area: '300 m²',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_Property> get _filtered {
    if (_query.isEmpty) return _properties;
    final q = _query.toLowerCase();
    return _properties
        .where(
          (p) =>
              p.title.toLowerCase().contains(q) ||
              p.location.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppbar(title: 'Properties'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppColors.darkLight, size: 22),
                  const Gap(10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => setState(() => _query = value),
                      decoration: const InputDecoration(
                        hintText: 'Search properties or cities...',
                        hintStyle: TextStyle(
                          color: AppColors.light,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  if (_query.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                      child: const Icon(
                        Icons.close,
                        color: AppColors.darkLight,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                    child: Text(
                      'No properties found',
                      style: TextStyle(color: AppColors.darkLight),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                    itemCount: _filtered.length,
                    separatorBuilder: (context, index) => const Gap(16),
                    itemBuilder: (context, index) =>
                        _PropertyCard(property: _filtered[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard({required this.property});

  final _Property property;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PropertiesDetailsPage(
              title: property.title,
              location: property.location,
              price: property.price,
              image: property.image,
              tag: property.tag,
              beds: property.beds,
              baths: property.baths,
              area: property.area,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Image.asset(
                      property.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.secondary,
                        child: const Icon(
                          Icons.home_work_outlined,
                          color: AppColors.white,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      property.tag,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          property.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Text(
                        property.price,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gold,
                        ),
                      ),
                    ],
                  ),
                  const Gap(6),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.darkLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        property.location,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.darkLight,
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  Row(
                    children: [
                      _spec(Icons.bed_outlined, property.beds),
                      const SizedBox(width: 18),
                      _spec(Icons.bathtub_outlined, property.baths),
                      const SizedBox(width: 18),
                      _spec(Icons.square_outlined, property.area),
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

  Widget _spec(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 17, color: AppColors.secondary),
        const SizedBox(width: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 13, color: AppColors.darkLight),
        ),
      ],
    );
  }
}

class _Property {
  const _Property({
    required this.title,
    required this.location,
    required this.price,
    required this.tag,
    required this.image,
    required this.beds,
    required this.baths,
    required this.area,
  });

  final String title;
  final String location;
  final String price;
  final String tag;
  final String image;
  final String beds;
  final String baths;
  final String area;
}