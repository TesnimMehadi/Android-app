import 'package:flutter/material.dart';
import '../models/perfume.dart';
import '../screens/product_detail_screen.dart';

class LuxuryPageRoute<T> extends PageRouteBuilder<T> {
  LuxuryPageRoute({required Widget page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutCubic,
            );
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.05),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 450),
        );
}

abstract final class AppRouter {
  static Future<void> openProductDetail(
    BuildContext context,
    Perfume perfume,
  ) {
    return Navigator.of(context).push(
      LuxuryPageRoute(
        page: ProductDetailScreen(perfume: perfume),
      ),
    );
  }
}
