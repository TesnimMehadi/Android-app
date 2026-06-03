import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onComplete});

  final VoidCallback onComplete;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_drink_outlined,
              size: 56,
              color: AppColors.cardRose.withValues(alpha: 0.8),
            )
                .animate()
                .fadeIn(duration: 800.ms)
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  duration: 800.ms,
                  curve: Curves.easeOutBack,
                ),
            const SizedBox(height: 24),
            Text(
              'MAISON',
              style: GoogleFonts.playfairDisplay(
                fontSize: 14,
                letterSpacing: 6,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 400.ms),
            const SizedBox(height: 4),
            Text(
              'Élégance',
              style: GoogleFonts.playfairDisplay(
                fontSize: 42,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                letterSpacing: 2,
              ),
            )
                .animate()
                .fadeIn(duration: 800.ms, delay: 600.ms)
                .slideY(begin: 0.2, end: 0, duration: 800.ms, delay: 600.ms),
            const SizedBox(height: 8),
            Text(
              'Parfumerie',
              style: GoogleFonts.lato(
                fontSize: 12,
                letterSpacing: 4,
                color: AppColors.cardRose,
                fontWeight: FontWeight.w400,
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms, delay: 900.ms),
          ],
        ),
      ),
    );
  }
}
