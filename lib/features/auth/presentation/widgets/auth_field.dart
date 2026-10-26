import 'package:flutter/material.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/app_spacing.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final String? Function(String?) validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: AppColors.primaryDark, fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColors.primaryDark, size: 21),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFD8E1DF),
        contentPadding: const EdgeInsets.symmetric(vertical: 17),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(
            color: AppColors.primaryDark,
            width: 1.4,
          ),
        ),
      ),
    );
  }
}

class AuthSocialButtons extends StatelessWidget {
  const AuthSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          icon: const Text(
            'G',
            style: TextStyle(
              color: Color(0xFF4285F4),
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          onTap: () => _showUnavailable(context, 'Google'),
        ),
        const SizedBox(width: 22),
        _SocialButton(
          icon: const Icon(
            Icons.facebook_rounded,
            color: Color(0xFF1877F2),
            size: 24,
          ),
          onTap: () => _showUnavailable(context, 'Facebook'),
        ),
        const SizedBox(width: 22),
        _SocialButton(
          icon: const Icon(Icons.apple, color: Colors.black, size: 24),
          onTap: () => _showUnavailable(context, 'Apple'),
        ),
      ],
    );
  }

  static void _showUnavailable(BuildContext context, String provider) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('Pendaftaran dengan $provider segera tersedia')),
      );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.icon, required this.onTap});

  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFC9F4D1),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(width: 42, height: 42, child: Center(child: icon)),
      ),
    );
  }
}
