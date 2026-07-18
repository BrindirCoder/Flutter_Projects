import 'package:flutter/material.dart';
import 'package:my_auth_app/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(color: AppColors.textGrey, fontSize: 14),
        ),
        const SizedBox(height: 18),

        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: AppColors.containerFill,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            errorStyle: const TextStyle(color: Colors.redAccent),
          ),
          validator: validator,
          
        ),
      ],
    );
  }
}
