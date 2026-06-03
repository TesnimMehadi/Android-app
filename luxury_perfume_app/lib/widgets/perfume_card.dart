import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/perfume.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'perfume_image.dart';

class PerfumeCard extends StatelessWidget {
  const PerfumeCard({
    super.key,
    required this.perfume,
    required this.onTap,
    this.variant = PerfumeCardVariant.rose,
    this.animationDelay = Duration.zero,
    this.heroTag,
  });

  final Perfume perfume;
  final VoidCallback onTap;
  final PerfumeCardVariant variant;
  final Duration animationDelay;
  final String? heroTag;

  bool get _isRose => variant == PerfumeCardVariant.rose;

  @override
  Widget build(BuildContext context) {
    final bgColor = _isRose ? AppColors.cardRose : AppColors.white;
    final textColor = _isRose ? AppColors.white : AppColors.textPrimary;
    final subColor =
        _isRose ? AppColors.white.withValues(alpha: 0.85) : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: heroTag ?? 'perfume_${perfume.id}',
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
              boxShadow: AppTheme.elevatedCardShadow,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: PerfumeImage(
                      imagePath: perfume.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  perfume.brand.toUpperCase(),
                  style: GoogleFonts.lato(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: subColor,
                    letterSpacing: 1.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${perfume.name} ${perfume.volume}',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  perfume.formattedPrice,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms, delay: animationDelay)
        .slideY(begin: 0.15, end: 0, duration: 500.ms, delay: animationDelay);
  }
}

enum PerfumeCardVariant { rose, white }
