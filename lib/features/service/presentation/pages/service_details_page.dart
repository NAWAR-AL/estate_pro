import 'package:estate_pro/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.features = const [],
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> features;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        foregroundColor: const Color(0xFF153B5B),
        title: const Text(
          "Service Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF153B5B),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB88A58),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, color: Colors.white, size: 30),
                  ),
                  const Gap(16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFCBD5E1),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),

            // OVERVIEW
            const Text(
              "Overview",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF153B5B),
              ),
            ),
            const Gap(8),
            Text(
              "Our $title service is designed to make your real estate "
              "experience simple and stress-free. From the first step to the "
              "final signature, our dedicated team stands by your side and "
              "handles every detail with professionalism.",
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF58728A),
                height: 1.55,
              ),
            ),
            const Gap(24),

            // WHAT WE OFFER
            const Text(
              "What We Offer",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF153B5B),
              ),
            ),
            const Gap(12),
            if (features.isEmpty)
              _buildFeature(Icons.check_circle, "Trusted and transparent process")
            else
              for (final feature in features)
                _buildFeature(Icons.check_circle, feature),
            const Gap(28),

            // CTA BUTTON
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB88A58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Request $title",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFB88A58), size: 20),
          const Gap(10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF3C5266),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}