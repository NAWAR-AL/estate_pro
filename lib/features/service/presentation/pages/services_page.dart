import 'package:estate_pro/features/service/presentation/pages/service_details_page.dart';
import 'package:estate_pro/features/widgets/custom_appbar.dart';
import 'package:estate_pro/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  static const _services = <_ServiceInfo>[
    _ServiceInfo(
      icon: Icons.home_outlined,
      title: 'Buying',
      subtitle: 'Find your dream home with ease',
      description:
          'Browse verified listings, visit properties with confidence and '
          'let our team handle the negotiation and paperwork for you.',
      features: [
        'Browse verified property listings',
        'Schedule guided property visits',
        'Negotiation support on your behalf',
        'Help with paperwork and contracts',
      ],
    ),
    _ServiceInfo(
      icon: Icons.attach_money,
      title: 'Selling',
      subtitle: 'Get the best value for your property',
      description:
          'From valuation to closing, we market your property to the right '
          'buyers and help you get the best possible price.',
      features: [
        'Free property valuation',
        'Professional photography & marketing',
        'Connect with serious buyers',
        'Closing and legal support',
      ],
    ),
    _ServiceInfo(
      icon: Icons.key_outlined,
      title: 'Renting',
      subtitle: 'Flexible options for your short or long stay',
      description:
          'Find the right rental with transparent terms, whether you are '
          'staying for a few months or settling in for good.',
      features: [
        'Short and long term options',
        'Verified landlords and units',
        'Transparent lease agreements',
        'Move-in assistance',
      ],
    ),
    _ServiceInfo(
      icon: Icons.admin_panel_settings_outlined,
      title: 'Property Management',
      subtitle: 'Professional care for your investment',
      description:
          'We take care of tenants, rent collection and maintenance so your '
          'property stays in great shape and performs well.',
      features: [
        'Tenant screening & placement',
        'Rent collection and reminders',
        'Maintenance and repairs',
        'Regular performance reports',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppbar(title: 'Our Services'),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: _services.length,
        separatorBuilder: (context, index) => const Gap(14),
        itemBuilder: (context, index) {
          final service = _services[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ServiceDetailsPage(
                    icon: service.icon,
                    title: service.title,
                    subtitle: service.subtitle,
                    features: service.features,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(18),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(service.icon, color: AppColors.gold, size: 26),
                  ),
                  const Gap(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const Gap(5),
                        Text(
                          service.description,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: AppColors.darkLight,
                            height: 1.5,
                          ),
                        ),
                        const Gap(8),
                        const Row(
                          children: [
                            Text(
                              'View details',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.gold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              size: 15,
                              color: AppColors.gold,
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
        },
      ),
    );
  }
}

class _ServiceInfo {
  const _ServiceInfo({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.features,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final List<String> features;
}