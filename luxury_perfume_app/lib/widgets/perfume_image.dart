import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PerfumeImage extends StatelessWidget {
  const PerfumeImage({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
  });

  final String imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (_, _, _) => Icon(
        Icons.local_drink_outlined,
        size: 48,
        color: AppColors.textSecondary.withValues(alpha: 0.5),
      ),
    );
  }
}
