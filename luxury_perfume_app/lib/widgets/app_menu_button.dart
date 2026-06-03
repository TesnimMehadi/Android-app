import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../localization/app_strings.dart';
import '../providers/app_settings_provider.dart';
import '../theme/app_colors.dart';

class AppMenuButton extends ConsumerWidget {
  const AppMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeModeProvider);
    final language = ref.watch(appLanguageProvider);
    String t(String k) => AppStrings.t(language, k);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: AppColors.textPrimary),
      onSelected: (value) {
        if (value == 'theme') {
          ref.read(themeModeProvider.notifier).state = !isDark;
        } else if (value == 'lang') {
          ref.read(appLanguageProvider.notifier).state =
              language == AppLanguage.english
                  ? AppLanguage.amharic
                  : AppLanguage.english;
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'theme',
          child: Row(
            children: [
              Icon(isDark ? Icons.light_mode : Icons.dark_mode, size: 18),
              const SizedBox(width: 8),
              Text('${t('theme')}: ${isDark ? t('dark') : t('light')}'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'lang',
          child: Row(
            children: [
              const Icon(Icons.translate, size: 18),
              const SizedBox(width: 8),
              Text(
                '${t('language')}: '
                '${language == AppLanguage.english ? t('english') : t('amharic')}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
