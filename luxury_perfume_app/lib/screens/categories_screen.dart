import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../localization/app_strings.dart';
import '../models/perfume.dart';
import '../navigation/app_router.dart';
import '../providers/app_settings_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/perfume_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/app_menu_button.dart';
import '../widgets/category_tab_bar.dart';
import '../widgets/floating_bottom_nav.dart';
import '../widgets/perfume_card.dart';
import '../widgets/search_sheet.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({
    super.key,
    this.onNavigateToCart,
    this.onNavigateToProfile,
    this.onNavigateToHome,
  });

  final VoidCallback? onNavigateToCart;
  final VoidCallback? onNavigateToProfile;
  final VoidCallback? onNavigateToHome;

  Future<void> _openSearch(BuildContext context, WidgetRef ref) async {
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
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final perfumes = ref.watch(filteredPerfumesProvider);
    final cartCount = ref.watch(cartItemCountProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final language = ref.watch(appLanguageProvider);
    String t(String k) => AppStrings.t(language, k);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onNavigateToHome,
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    color: AppColors.textPrimary,
                  ),
                  const Spacer(),
                  const AppMenuButton(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t('featured'),
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ).animate().fadeIn(duration: 400.ms),
                  const SizedBox(height: 4),
                  Text(
                    t('categories'),
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 100.ms),
                ],
              ),
            ),
            if (searchQuery.isNotEmpty) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${t('resultsFor')} "$searchQuery"',
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          ref.read(searchQueryProvider.notifier).state = '',
                      child: Text(
                        t('clear'),
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.cardRose,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            CategoryTabBar(
              selected: selectedCategory,
              onSelected: (category) {
                ref.read(selectedCategoryProvider.notifier).state = category;
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: perfumes.isEmpty
                  ? Center(
                      child: Text(
                        searchQuery.isNotEmpty
                            ? t('noSearch')
                            : t('noCategoryItems'),
                        style: GoogleFonts.lato(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  : _StaggeredPerfumeGrid(
                      perfumes: perfumes,
                      onPerfumeTap: (perfume) =>
                          AppRouter.openProductDetail(context, perfume),
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

class _StaggeredPerfumeGrid extends StatelessWidget {
  const _StaggeredPerfumeGrid({
    required this.perfumes,
    required this.onPerfumeTap,
  });

  final List<Perfume> perfumes;
  final void Function(Perfume) onPerfumeTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.72,
          ),
          itemCount: perfumes.length,
          itemBuilder: (context, index) {
            final perfume = perfumes[index];
            final variant = index.isEven
                ? PerfumeCardVariant.rose
                : PerfumeCardVariant.white;

            return Transform.translate(
              offset: Offset(0, index.isOdd ? 20 : 0),
              child: PerfumeCard(
                perfume: perfume,
                variant: variant,
                animationDelay: Duration(milliseconds: 80 * index),
                onTap: () => onPerfumeTap(perfume),
              ),
            );
          },
        );
      },
    );
  }
}
