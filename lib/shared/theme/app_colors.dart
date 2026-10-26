import 'package:flutter/material.dart';

/// Design tokens and semantic colors for Klinik UAD.
/// Following strict healthcare color specifications:
/// - Primary: #1565C0 (Professional medical blue)
/// - Secondary: #42A5F5 (Clear clinical blue)
/// - Accent: #26A69A (Positive healthcare teal)
/// - Background: #F7F9FC (Clean, spacious clinical background)
/// - Surface: White (#FFFFFF)
/// - Status: Success (#43A047), Warning (#FFC107), Danger (#EF5350)
abstract final class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF2E8B3C);
  static const Color primaryDark = Color(0xFF064E3B);
  static const Color primaryLight = Color(0xFF4CAF50);
  static const Color primaryContainer = Color(0xFFE6F4E8);
  static const Color onPrimary = Colors.white;
  static const Color onPrimaryContainer = Color(0xFF064E3B);

  // Secondary & Accent
  static const Color secondary = Color(0xFF66BB6A);
  static const Color secondaryContainer = Color(0xFFEAF6EB);
  static const Color accent = Color(0xFF26A69A);
  static const Color accentContainer = Color(0xFFE0F2F1);
  static const Color onAccent = Color(0xFF00695C);

  // Background & Surfaces
  static const Color background = Color(0xFFF7F9FC);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF1F4F8);
  static const Color surfaceSubtle = Color(0xFFF8FAFD);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Colors.white;

  // Status & Feedback
  static const Color success = Color(0xFF43A047);
  static const Color successContainer = Color(0xFFE8F5E9);
  static const Color warning = Color(0xFFFFC107);
  static const Color warningContainer = Color(0xFFFFF8E1);
  static const Color danger = Color(0xFFEF5350);
  static const Color dangerContainer = Color(0xFFFFEBEE);
  static const Color info = Color(0xFF1E88E5);
  static const Color infoContainer = Color(0xFFE3F2FD);

  // Borders & Dividers
  static const Color border = Color(0xFFE5E9F0);
  static const Color borderLight = Color(0xFFEDF2F7);
  static const Color divider = Color(0xFFECEFF1);

  // Healthcare Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF42A5F5)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
  );

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFE3F2FD), Color(0xFFF7F9FC)],
  );

  static const LinearGradient walletCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF00695C)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF26A69A), Color(0xFF00897B)],
  );
}
