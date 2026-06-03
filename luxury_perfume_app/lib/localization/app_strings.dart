import '../providers/app_settings_provider.dart';

abstract final class AppStrings {
  static String t(AppLanguage lang, String key) {
    const en = {
      'featured': 'Featured',
      'categories': 'Categories',
      'search': 'Search',
      'resultsFor': 'Results for',
      'clear': 'Clear',
      'noCategoryItems': 'No perfumes in this category',
      'noSearch': 'No perfumes match your search',
      'addToBasket': 'Add to basket',
      'homeStory':
          'Discover curated fragrances crafted for timeless elegance and modern femininity.',
      'browseCategories': 'Browse Categories',
      'menu': 'Menu',
      'theme': 'Theme',
      'dark': 'Dark',
      'light': 'Light',
      'language': 'Language',
      'english': 'English',
      'amharic': 'Amharic',
      'searchHint': 'Search perfumes...',
      'noFound': 'No perfumes found',
    };
    const am = {
      'featured': 'ተመራጭ',
      'categories': 'ምድቦች',
      'search': 'ፈልግ',
      'resultsFor': 'የፍለጋ ውጤት',
      'clear': 'አጥፋ',
      'noCategoryItems': 'በዚህ ምድብ ምንም ሽቶ የለም',
      'noSearch': 'ከፍለጋዎ ጋር የሚገናኝ ሽቶ አልተገኘም',
      'addToBasket': 'ወደ ቅርጫት ጨምር',
      'homeStory': 'ለረጅም ዘመን ውበት እና ዘመናዊ ሴትነት የተመረጡ ሽቶዎችን ያግኙ።',
      'browseCategories': 'ምድቦችን ክፈት',
      'menu': 'ምናሌ',
      'theme': 'ገጽታ',
      'dark': 'ጨለማ',
      'light': 'ብርሃን',
      'language': 'ቋንቋ',
      'english': 'እንግሊዝኛ',
      'amharic': 'አማርኛ',
      'searchHint': 'ሽቶ ፈልግ...',
      'noFound': 'ምንም ሽቶ አልተገኘም',
    };
    return (lang == AppLanguage.english ? en : am)[key] ?? key;
  }
}
