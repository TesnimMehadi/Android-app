import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_assets.dart';
import '../localization/app_strings.dart';
import '../navigation/app_router.dart';
import '../providers/app_settings_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/perfume_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/add_to_basket_button.dart';
import '../widgets/app_menu_button.dart';
import '../widgets/carousel_indicator.dart';
import '../widgets/featured_info_card.dart';
import '../widgets/floating_bottom_nav.dart';
import '../widgets/perfume_image.dart';
import '../widgets/search_sheet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
    this.onNavigateToCart,
    this.onNavigateToCategories,
    this.onNavigateToProfile,
  });

  final VoidCallback? onNavigateToCart;
  final VoidCallback? onNavigateToCategories;
  final VoidCallback? onNavigateToProfile;

  Future<void> _openSearch(BuildContext context, WidgetRef ref) async {
    onNavigateToCategories?.call();
    await Future.delayed(const Duration(milliseconds: 300));
    if (!context.mounted) return;
    final id = await SearchSheet.show(context);
    if (id != null && context.mounted) {
      final perfume = ref.read(perfumeByIdProvider(id));
      if (perfume != null) {
        AppRouter.openProductDetail(context, perfume);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featured = ref.watch(homeFeaturedProvider);
    final cartCount = ref.watch(cartItemCountProvider);
    final allPerfumes = ref.watch(allPerfumesProvider);
    final currentSlide = ref.watch(homeSliderIndexProvider);
    final language = ref.watch(appLanguageProvider);
    String t(String k) => AppStrings.t(language, k);
    final alt1 = allPerfumes.isNotEmpty ? allPerfumes.first : featured;
    final alt2 = allPerfumes.length > 1 ? allPerfumes[1] : featured;
    final slides = [
      featured.copyWith(imageUrl: AppAssets.shalimar1),
      alt1.copyWith(imageUrl: AppAssets.jadore1, id: 'home-slide-2'),
      alt2.copyWith(imageUrl: AppAssets.missDior1, id: 'home-slide-3'),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  const AppMenuButton(),
                  Expanded(
                    child: Text(
                      featured.name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onNavigateToCategories,
                    icon: const Icon(Icons.arrow_forward_ios, size: 20),
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              flex: 5,
              child: PageView.builder(
                onPageChanged: (index) {
                  ref.read(homeSliderIndexProvider.notifier).state = index;
                },
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  final perfume = slides[index];
                  return GestureDetector(
                    onTap: () => AppRouter.openProductDetail(context, perfume),
                    child: Hero(
                      tag: 'perfume_${perfume.id}',
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 28),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(
                            AppTheme.borderRadius,
                          ),
                          boxShadow: AppTheme.elevatedCardShadow,
                        ),
                        padding: const EdgeInsets.all(24),
                        child: PerfumeImage(
                          imagePath: perfume.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 500.ms);
                },
              ),
            ),
            const SizedBox(height: 12),
            CarouselIndicator(count: slides.length, activeIndex: currentSlide),
            const SizedBox(height: 16),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(child: FeaturedInfoCard(perfume: featured)),
                    const SizedBox(height: 8),
                    Text(
                      t('homeStory'),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onNavigateToCategories,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cardRose,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Text(t('browseCategories')),
                      ),
                    ),
                    const SizedBox(height: 12),
                    AddToBasketButton(
                      label: t('addToBasket'),
                      onPressed: () {
                        ref.read(cartProvider.notifier).add(featured);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${featured.name} added to basket',
                              style: GoogleFonts.lato(),
                            ),
                            backgroundColor: AppColors.cardRose,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.all(16),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            FloatingBottomNav(
              cartItemCount: cartCount,
              onBasketTap: onNavigateToCart,
              onProfileTap: onNavigateToProfile,
              onSearchTap: () => _openSearch(context, ref),
              searchLabel: t('search'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
