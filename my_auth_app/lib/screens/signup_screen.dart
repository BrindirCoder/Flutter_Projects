import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_text_field.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // دروستکردنی کۆنتڕۆڵەرەکان بۆ خوێندنەوەی سێ فیڵدەکە
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // فۆڕم کی بۆ چاودێریکردنی مەرجەکان
  final _formKey = GlobalKey<FormState>();

  // مێتۆدی جێبەجێکردنی دروستکردنی هەژمار
  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      // ئەگەر هەموو مەرجەکان سەرکەوتوو بوون، نامەیەکی سەرکەوتن پیشان دەدات
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('هەژمارەکەت بە سەرکەوتوویی دروستکرا! 🎉'),
          backgroundColor: Colors.green,
        ),
      );

      // بەکارهێنەر دەباتەوە بۆ شاشەی لۆگین تا بتوانێت بچێتە ژوورەوە
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // ڕەنگی تاریکی پشتەوە
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ١. بەشی وێنەی سەرەوە (کۆشکەکەی ناو دیزاینەکەت)
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // ٢. بەشی نووسین و فیڵدەکان
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // فیڵدی یەکەم: ئیمەیڵ
                    CustomTextField(
                      labelText: 'Email',
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'تکایە ئیمەیڵ بنووسە';
                        }
                        // دەکرێت مەرجی ئیمەیڵی فەرمی (RegExp) لێرە دابنرێت، بەڵام بۆ سادەیی تەنها پیاچوونەوەی بەتاڵی دەکەین
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // فیڵدی دووەم: پاسۆرد
                    CustomTextField(
                      labelText: 'Password',
                      controller: _passwordController,
                      obscureText: true, // شاردنەوەی نووسینەکە
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'تکایە پاسۆرد بنووسە';
                        }
                        if (value.length < 8) {
                          return 'پاسۆرد نابێت لە ٨ پیت کەمتر بێت!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // فیڵدی سێیەم: دووبارەکردنەوەی پاسۆرد
                    CustomTextField(
                      labelText: 'Confirm Password',
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'تکایە پاسۆردەکە دووبارە بنووسەوە';
                        }
                        // مەرجی سەرەکی: بەراوردکردنی ئەم فیڵدە لەگەڵ فیڵدی پێشوو
                        if (value != _passwordController.text) {
                          return 'پاسۆردەکان وەک یەک نین! ❌';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // بووتۆنی Sign Up
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _handleSignUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // بەشی خوارەوە بۆ گەڕانەوە بۆ لۆگین
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: AppColors.textGrey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}
 