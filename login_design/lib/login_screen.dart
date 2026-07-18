import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A005C),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            // image
            Image.asset(
              'assets/login_image.jpg',
              height: 220,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            /////
            const Text(
              "Welcome Back",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Please Log into your existing account",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white60, fontSize: 16),
            ),
            const SizedBox(height: 24),
            const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Your Email",
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Color(0xFF130970),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // password box
            const TextField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Your Pssword ",
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Color(0xFF130970),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.white30, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
            ),
            // button
            const SizedBox(height: 24),
            SizedBox(
              height: 55,
              child: FilledButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF1AD293)),

                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
                child: Text(
                  "Log In",
                  style: TextStyle(
                    color: Color(0xFF0A005C),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
