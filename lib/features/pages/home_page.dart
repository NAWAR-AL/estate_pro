import 'package:estate_pro/features/blog/presentation/pages/blog_details_page.dart';
import 'package:estate_pro/features/blog/presentation/pages/blog_page.dart';
import 'package:estate_pro/features/properties/presentation/pages/properties_details_page.dart';
import 'package:estate_pro/features/properties/presentation/pages/properties_page.dart';
import 'package:estate_pro/features/service/presentation/pages/service_details_page.dart';
import 'package:estate_pro/features/widgets/custom_bottom_navbar.dart';
import 'package:estate_pro/features/widgets/custom_button.dart';
import 'package:estate_pro/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          
          children: [
            Gap(4),
            // HEADER
            Container(
              color: AppColors.backgroundLight,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SafeArea(
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    
                    children: [
                      Gap(5),
                      Image.asset(
                        "assets/images/logo/logo.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.contain,
                      ),
                      const Gap(8),
                      const Text(
                        "ESTATE PRO",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF153B5B),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.notifications_outlined,
                              color: Color(0xFF153B5B),
                              size: 24,
                            ),
                          ),
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: Color(0xFF153B5B),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ),
            ),
            // HERO
            Stack(
              children: [
                Image.asset(
                  "assets/images/logo/pexels-ahmetcotur.jpg",
                  width: double.infinity,
                  height: 380,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          Colors.black.withValues(alpha: 0.5),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(40),
                        const Text(
                          "FIND YOUR Perfect Home",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        const Gap(20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: Color(0xFF58728A),
                                size: 22,
                              ),
                              const Gap(10),
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Search for properties, cities, or areas...",
                                    hintStyle: TextStyle(
                                      color: Color(0xFF58728A),
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB88A58),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Icon(
                                  Icons.tune,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                        CustomButton(
                          text: "Explore Properties",
                          icon: Icons.arrow_forward,
                          height: 52,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PropertiesPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Gap(25),
            // FEATURED
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Featured Properties",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF153B5B),
                      
                      
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PropertiesPage(),
                        ),
                      );
                    },
                    child:  Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB88A58),
                      
                      ),
                    ),
                  ),
                ],
              ),
            ),
             Gap(12),
            SizedBox(
              height: 310,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding:  EdgeInsets.symmetric(horizontal: 16),
                physics:  BouncingScrollPhysics(),
                
                children: [
                  _buildFeaturedCard(
                    context,
                    "Modern Villa",
                    "For Sale",
                    "Los Angeles, CA",
                    "\$450,000",
                    "4",
                    "3",
                    "320 m²",
                  ),
                  _buildFeaturedCard(
                    context,
                    "Family House",
                    "For Sale",
                    "New York, NY",
                    "\$320,000",
                    "3",
                    "2",
                    "280 m²",
                  ),
                  _buildFeaturedCard(
                    context,
                    "Luxury Apartment",
                    "For Rent",
                    "Dubai, UAE",
                    "\$2,800 /month",
                    "2",
                    "2",
                    "150 m²",
                  ),
                ],
              ),
            ),
            const Gap(30),
            // SERVICES
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Text(
                    "Our Services",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF153B5B),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      _serviceTile(
                        icon: Icons.home_outlined,
                        title: "Buying",
                        subtitle: "Find your dream home with ease",
                        features: const [
                          "Browse verified property listings",
                          "Schedule guided property visits",
                          "Negotiation support on your behalf",
                          "Help with paperwork and contracts",
                        ],
                      ),
                      const Gap(12),
                      _serviceTile(
                        icon: Icons.attach_money,
                        title: "Selling",
                        subtitle: "Get the best value for your property",
                        features: const [
                          "Free property valuation",
                          "Professional photography & marketing",
                          "Connect with serious buyers",
                          "Closing and legal support",
                        ],
                      ),
                    ],
                  ),
                  const Gap(12),
                  Row(
                    children: [
                      _serviceTile(
                        icon: Icons.key_outlined,
                        title: "Renting",
                        subtitle: "Flexible options for your short or long stay",
                        features: const [
                          "Short and long term options",
                          "Verified landlords and units",
                          "Transparent lease agreements",
                          "Move-in assistance",
                        ],
                      ),
                      const Gap(12),
                      _serviceTile(
                        icon: Icons.admin_panel_settings_outlined,
                        title: "Property Management",
                        subtitle: "Professional care for your investment",
                        features: const [
                          "Tenant screening & placement",
                          "Rent collection and reminders",
                          "Maintenance and repairs",
                          "Regular performance reports",
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(30),
            const Gap(30),
            // NEWS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Latest News & Insights",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF153B5B),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BlogPage()),
                    ),
                    child: const Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB88A58),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BlogDetailsPage(),
                      ),
                    ),
                    child: _buildNewsCard(
                      "Top 10 Tips for Buying Your First Home",
                      "Real Estate Tips",
                      "May 15, 2025",
                    ),
                  ),
                  const Gap(12),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BlogDetailsPage(),
                      ),
                    ),
                    child: _buildNewsCard(
                      "The Future of Real Estate in 2025",
                      "Market Trends",
                      "May 10, 2025",
                    ),
                  ),
                ],
              ),
            ),
            const Gap(80),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(),
    );
  }

  Widget _buildFeaturedCard(
    BuildContext context,
    String title,
    String tag,
    String location,
    String price,
    String beds,
    String baths,
    String area,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PropertiesDetailsPage()),
        );
      },
      child: Card(
        color: AppColors.backgroundLight,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.only(right: 10),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      "assets/images/logo/pexels-ahmetcotur.jpg",
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFBE8B4D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 12,
                      right: 12,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF153B5B),
                      ),
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 17,
                          color: Color(0xFF58728A),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF60788F),
                          ),
                        ),
                      ],
                    ),
                    const Gap(6),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFAE8657),
                      ),
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        const Icon(
                          Icons.bed_outlined,
                          size: 16,
                          color: Color(0xFF45647D),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          beds,
                          style: const TextStyle(color: Color(0xFF60788F)),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.bathtub_outlined,
                          size: 16,
                          color: Color(0xFF45647D),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          baths,
                          style: const TextStyle(color: Color(0xFF60788F)),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.square_outlined,
                          size: 16,
                          color: Color(0xFF45647D),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          area,
                          style: const TextStyle(color: Color(0xFF60788F)),
                        ),
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

  Widget _serviceTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<String> features,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceDetailsPage(
              icon: icon,
              title: title,
              subtitle: subtitle,
              features: features,
            ),
          ),
        ),
        child: _buildServiceCard(icon, title, subtitle),
      ),
    );
  }

  Widget _buildServiceCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFB88A58).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFFB88A58), size: 24),
          ),
          const Gap(12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF153B5B),
            ),
          ),
          const Gap(4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF58728A),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(String title, String category, String date) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/logo/pexels-ahmetcotur.jpg",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB88A58).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB88A58),
                    ),
                  ),
                ),
                const Gap(8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF153B5B),
                    height: 1.3,
                  ),
                ),
                const Gap(6),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Color(0xFF58728A),
                    ),
                    const Gap(4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF58728A),
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
