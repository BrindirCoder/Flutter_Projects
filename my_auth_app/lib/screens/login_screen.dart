import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/custom_text_field.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // دروستکردنی کۆنتڕۆڵەرەکان بۆ خوێندنەوەی دەقی ناو فیڵدەکان
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // فۆڕم کی (Form Key) بۆ پیاچوونەوەی مەرجەکان (Validation)
  final _formKey = GlobalKey<FormState>();

  // مێتۆدی پیاچوونەوەی لۆگین
  void _handleLogin() {
    // یەکەمجار سەیری مەرجەکانی ناو فیڵدەکان دەکات (وەک درێژی پاسۆرد)
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text;

      // پیاچوونەوەی یوزەرنەیم و پاسۆردە دیاریکراوەکە کە داوات کردبوو
      if (username == 'user' && password == '123456123') {
        // ئەگەر ڕاست بوو، بەکارهێنەر دەبات بۆ پەرەی هۆم
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // ئەگەر زانیارییەکان هەڵە بوون، پەیامێکی سوور پیشان دەدات
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('یوزەرنەیم یان پاسۆردەکە هەڵەیە! ❌'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // ڕەنگی تاریکی پشتەوە
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // بەستنەوەی فۆڕمەکە بە کی-ەکەوە
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ١. بەشی وێنەی باگراوندی سەرەوە وەک دیزاینەکە
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

              // ٢. بەشی ناوەڕۆک و تێکست فیڵدەکان
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // بەکارهێنانەوەی فیڵدی تایبەت بۆ یوزەرنەیم
                    CustomTextField(
                      labelText: 'Username',
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'تکایە یوزەرنەیم بنووسە';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // بەکارهێنانەوەی فیڵدی تایبەت بۆ پاسۆرد
                    CustomTextField(
                      labelText: 'Password',
                      controller: _passwordController,
                      obscureText: true, // شاردنەوەی نووسینەکە چونکە پاسۆردە
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'تکایە پاسۆرد بنووسە';
                        }
                        // مەرجەکە لێرەدایە: ئەگەر کەمتر بوو لە ٨ پیت خەتا دەدات
                        if (value.length < 8) {
                          return 'پاسۆرد نابێت لە ٨ پیت کەمتر بێت!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // بووتۆنی لۆگین (ڕەنگی سپی و دەقی ڕەش وەک دیزاینەکە)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // بەشی خوارەوە بۆ چوونە شاشەی خۆتۆمارکردن
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: AppColors.textGrey),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign up",
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
