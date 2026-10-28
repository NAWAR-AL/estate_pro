import 'package:estate_pro/features/about/presentation/pages/contact_page.dart';
import 'package:estate_pro/features/widgets/custom_button.dart';
import 'package:estate_pro/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PropertiesDetailsPage extends StatelessWidget {
  const PropertiesDetailsPage({
    super.key,
    this.title = 'Modern Villa',
    this.location = 'Los Angeles, CA',
    this.price = '\$450,000',
    this.image = 'assets/images/luxury_villa.jpg',
    this.tag = 'For Sale',
    this.beds = '4',
    this.baths = '3',
    this.area = '320 m²',
  });

  final String title;
  final String location;
  final String price;
  final String image;
  final String tag;
  final String beds;
  final String baths;
  final String area;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE HEADER
            Stack(
              children: [
                SizedBox(
                  height: 320,
                  width: double.infinity,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.secondary,
                      child: const Center(
                        child: Icon(
                          Icons.home_work_outlined,
                          size: 64,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _circleButton(
                            icon: Icons.arrow_back_ios_new_rounded,
                            onTap: () => Navigator.maybePop(context),
                          ),
                          _circleButton(
                            icon: Icons.favorite_border,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to favourites'),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gold,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: AppColors.darkLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.darkLight,
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),

                  // SPECS
                  Row(
                    children: [
                      Expanded(
                        child: _spec(Icons.bed_outlined, beds, 'Bedrooms'),
                      ),
                      const Gap(10),
                      Expanded(
                        child: _spec(Icons.bathtub_outlined, baths, 'Bathrooms'),
                      ),
                      const Gap(10),
                      Expanded(
                        child: _spec(Icons.square_outlined, area, 'Area'),
                      ),
                    ],
                  ),
                  const Gap(24),

                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const Gap(8),
                  const Text(
                    'A thoughtfully designed property offering bright, open '
                    'living spaces and a calm, contemporary feel. Ideally '
                    'located close to schools, shops and transport, this home '
                    'combines everyday comfort with easy access to the city.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.darkLight,
                      height: 1.6,
                    ),
                  ),
                  const Gap(24),

                  const Text(
                    'Amenities',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const Gap(12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: const [
                      _Amenity(Icons.pool_outlined, 'Pool'),
                      _Amenity(Icons.local_parking_outlined, 'Parking'),
                      _Amenity(Icons.wifi_outlined, 'Wi-Fi'),
                      _Amenity(Icons.ac_unit_outlined, 'Air Conditioning'),
                      _Amenity(Icons.fitness_center_outlined, 'Gym'),
                      _Amenity(Icons.security_outlined, 'Security'),
                    ],
                  ),
                  const Gap(30),

                  CustomButton(
                    text: 'Contact Agent',
                    icon: Icons.phone_outlined,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ContactPage(),
                        ),
                      );
                    },
                  ),
                  const Gap(12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: AppColors.primary),
      ),
    );
  }

  Widget _spec(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Icon(icon, size: 22, color: AppColors.gold),
          const Gap(6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const Gap(2),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.darkLight),
          ),
        ],
      ),
    );
  }
}

class _Amenity extends StatelessWidget {
  const _Amenity(this.icon, this.label);

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17, color: AppColors.gold),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12.5, color: AppColors.secondary),
          ),
        ],
      ),
    );
  }
}