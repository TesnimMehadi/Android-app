import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/app_settings_provider.dart';
import 'theme/app_theme.dart';
import 'screens/main_shell.dart';
import 'screens/splash_screen.dart';

class LuxuryPerfumeApp extends ConsumerStatefulWidget {
  const LuxuryPerfumeApp({super.key});

  @override
  ConsumerState<LuxuryPerfumeApp> createState() => _LuxuryPerfumeAppState();
}

class _LuxuryPerfumeAppState extends ConsumerState<LuxuryPerfumeApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider);
    return MaterialApp(
      title: 'Maison Élégance',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: _showSplash
            ? SplashScreen(
                key: const ValueKey('splash'),
                onComplete: () => setState(() => _showSplash = false),
              )
            : const MainShell(key: ValueKey('main')),
      ),
    );
  }
}
