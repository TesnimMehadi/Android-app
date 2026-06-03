import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppLanguage { english, amharic }

final themeModeProvider = StateProvider<bool>((ref) => false);
final appLanguageProvider =
    StateProvider<AppLanguage>((ref) => AppLanguage.english);
