import 'package:estate_pro/features/auth/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:estate_pro/theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<LoginPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Gap(20),
              Image.asset(
                "assets/images/logo/logo.png",
                width: 100,
                height: 100,
              ),
              Text(
                "ESTATE PRO",
                style: TextStyle(fontSize: 30, color: AppColors.primary),
              ),
              Text(
                "Find.Buy.Live",
                style: TextStyle(fontSize: 15, color: AppColors.primary),
              ),
              Gap(15),
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: AppColors.primary,
                ),
              ),
              Text(
                "Login to your account",
                style: TextStyle(fontSize: 20, color: AppColors.primary),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 70, height: 1, color: AppColors.gold),

                  Gap(15),

                  Text(
                    '✦',
                    style: TextStyle(color: AppColors.gold, fontSize: 20),
                  ),

                  Gap(15),

                  Container(width: 70, height: 1, color: AppColors.gold),
                ],
              ),

              Gap(20),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'User Name/ Email',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColors.gold,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),

                        Gap(15),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            hintText: 'Password',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColors.gold,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Forgot Password
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Gap(8),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            foregroundColor: AppColors.backgroundLight,
                          ),

                          onPressed: () {},
                          child: Text("LogIn"),
                        ),
                        Gap(8),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => RegisterPage()),
                            );
                          },
                          child: Text(
                            "Don't have an account? Sign Up",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),

                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Container(height: 1, color: Colors.grey),
                        //     ),

                        //     const Gap(12),

                        //     Text(
                        //       'Or continue with',
                        //       style: TextStyle(
                        //         color: AppColors.gold,
                        //         fontSize: 16,
                        //       ),
                        //     ),

                        //     const Gap(12),

                        //     Expanded(
                        //       child: Container(height: 1, color: Colors.grey),
                        //     ),
                        //   ],
                        // ),
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
