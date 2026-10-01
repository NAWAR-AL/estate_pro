import 'package:estate_pro/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:estate_pro/theme/app_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                "Find • Buy • Live",
                style: TextStyle(fontSize: 15, color: AppColors.primary),
              ),
              Gap(15),
              Text(
                "Create Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: AppColors.primary,
                ),
              ),
              Text("Join Estate Pro and start your journey with us"),

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
                            hintText: 'Full Name',
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
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Email Address',
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
                            prefixIcon: Icon(Icons.phone),
                            hintText: 'Phone',
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
                        Gap(15),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            hintText: 'Confrim Password',
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
                        Gap(8),
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                              activeColor: AppColors.gold,
                              side: const BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),

                            Expanded(
                              child: Text(
                                'I agree to the Terms of Service and Privacy Policy',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Gap(5),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            foregroundColor: AppColors.backgroundLight,
                          ),

                          onPressed: () {},
                          child: Text("Sign Up"),
                        ),
                        Gap(8),

                          TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPage() ),
                        );
                      },
                      child: Text(
                        "Already have an account? Login",
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
