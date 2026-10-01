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
            // ============================================================
            // HERO SECTION
            // ============================================================

            Stack(
              children: [
                Image.asset(
                  "assets/images/logo/pexels-ahmetcotur.jpg",
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),

                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB88A58),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Explore Properties",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const Gap(25),

            // ============================================================
            // FEATURED PROPERTIES
            // ============================================================
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                physics: const BouncingScrollPhysics(),

                children: [
                  // ======================================================
                  // CARD 1
                  // ======================================================

                  Card(
                    margin: const EdgeInsets.only(right: 10),
                    // elevation: 3,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SizedBox(
                      width: 220,
                      height: 200,

                      child: Stack(
                        children: [
                          // IMAGE
                          Image.asset(
                            "assets/images/logo/pexels-ahmetcotur.jpg",
                            width: 220,
                            height: 120,
                            fit: BoxFit.cover,
                          ),

                          // FOR SALE
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
                              child: const Text(
                                "For Sale",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          // HEART
                          const Positioned(
                            top: 12,
                            right: 12,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),

                          // INFORMATION
                          Positioned(
                            top: 105,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                14,
                                16,
                                10,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColors.backgroundLight,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Modern Villa",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF153B5B),
                                    ),
                                  ),

                                  Gap(5),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 17,
                                        color: Color(0xFF58728A),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Los Angeles, CA",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF60788F),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Gap(5),

                                  Text(
                                    "\$450,000",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFAE8657),
                                    ),
                                  ),

                                  Gap(8),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.bed_outlined,
                                        size: 18,
                                        color: Color(0xFF45647D),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "4",
                                        style: TextStyle(
                                          color: Color(0xFF60788F),
                                        ),
                                      ),

                                      SizedBox(width: 12),

                                      Icon(
                                        Icons.bathtub_outlined,
                                        size: 18,
                                        color: Color(0xFF45647D),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "3",
                                        style: TextStyle(
                                          color: Color(0xFF60788F),
                                        ),
                                      ),

                                      SizedBox(width: 12),

                                      Icon(
                                        Icons.square_outlined,
                                        size: 17,
                                        color: Color(0xFF45647D),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "320 m²",
                                        style: TextStyle(
                                          color: Color(0xFF60788F),
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

                  // ======================================================
                  // CARD 2
                  // ======================================================
                  Card(
                    margin: const EdgeInsets.only(right: 10),
                    // elevation: 3,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SizedBox(
                      width: 220,
                      height: 280,

                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/logo/pexels-ahmetcotur.jpg",
                            width: 220,
                            height: 120,
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
                              child: const Text(
                                "For Sale",
                                style: TextStyle(
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

                          Positioned(
                            top: 105,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                14,
                                16,
                                10,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColors.backgroundLight,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Family House",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF153B5B),
                                    ),
                                  ),

                                  Gap(5),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 17,
                                        color: Color(0xFF58728A),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "New York, NY",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF60788F),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Gap(5),

                                  Text(
                                    "\$320,000",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFAE8657),
                                    ),
                                  ),

                                  Gap(8),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.bed_outlined,
                                        size: 18,
                                        color: Color(0xFF45647D),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "3",
                                        style: TextStyle(
                                          color: Color(0xFF60788F),
                                        ),
                                      ),

                                      SizedBox(width: 12),

                                      Icon(
                                        Icons.bathtub_outlined,
                                        size: 18,
                                        color: Color(0xFF45647D),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "2",
                                        style: TextStyle(
                                          color: Color(0xFF60788F),
                                        ),
                                      ),

                                      SizedBox(width: 12),

                                      Icon(
                                        Icons.square_outlined,
                                        size: 17,
                                        color: Color(0xFF45647D),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "280 m²",
                                        style: TextStyle(
                                          color: Color(0xFF60788F),
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

                  Card(
                    
                    margin: EdgeInsets.zero,
                    // elevation: 3,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SizedBox(
                      width: 220,
                      height: 280,

                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/logo/pexels-ahmetcotur.jpg",
                            width: 220,
                            height: 120,
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
                              child: const Text(
                                "For Rent",
                                style: TextStyle(
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

                          Positioned(
                            top: 105,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                14,
                                16,
                                10,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColors.backgroundLight,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Luxury Apartment",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF153B5B),
                                    ),
                                  ),

                                  Gap(5),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 17,
                                        color: Color(0xFF58728A),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Dubai, UAE",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF60788F),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Gap(5),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\$2,800",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFAE8657),
                                        ),
                                      ),
                                      Text(
                                        " /month",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFFAE8657),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Gap(8),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.bed_outlined,
                                        size: 18,
                                        color: Color(0xFF45647D),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "2",
                                        style: TextStyle(
                                          color: Color(0xFF60788F),
                                        ),
                                      ),

                                      SizedBox(width: 12),

                                      Icon(
                                        Icons.bathtub_outlined,
                                        size: 18,
                                        color: Color(0xFF45647D),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "2",
                                        style: TextStyle(
                                          color: Color(0xFF60788F),
                                        ),
                                      ),

                                      SizedBox(width: 12),

                                      Icon(
                                        Icons.square_outlined,
                                        size: 17,
                                        color: Color(0xFF45647D),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "150 m²",
                                        style: TextStyle(
                                          color: Color(0xFF60788F),
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
                ],
              ),
            ),

            Gap(30),
          ],
        ),
      ),
    );
  }
}
