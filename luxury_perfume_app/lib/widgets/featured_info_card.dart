import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/perfume.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class FeaturedInfoCard extends StatelessWidget {
  const FeaturedInfoCard({super.key, required this.perfume});

  final Perfume perfume;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
      decoration: BoxDecoration(
        color: AppColors.cardRose,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        boxShadow: AppTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            perfume.name,
            style: GoogleFonts.playfairDisplay(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            perfume.description,
            style: GoogleFonts.lato(
              fontSize: 13,
              height: 1.6,
              color: AppColors.white.withValues(alpha: 0.9),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          Text(
            perfume.formattedPrice,
            style: GoogleFonts.lato(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
