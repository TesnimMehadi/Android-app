import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/perfume.dart';
import '../services/perfume_service.dart';

final perfumeServiceProvider = Provider<PerfumeService>((ref) {
  return PerfumeService();
});

final homeFeaturedProvider = Provider<Perfume>((ref) {
  return ref.watch(perfumeServiceProvider).getHomeFeatured();
});

final allPerfumesProvider = Provider<List<Perfume>>((ref) {
  return ref.watch(perfumeServiceProvider).getAllPerfumes();
});

final selectedCategoryProvider =
    StateProvider<PerfumeCategory>((ref) => PerfumeCategory.all);

final searchQueryProvider = StateProvider<String>((ref) => '');
final homeSliderIndexProvider = StateProvider<int>((ref) => 0);

final filteredPerfumesProvider = Provider<List<Perfume>>((ref) {
  final category = ref.watch(selectedCategoryProvider);
  final query = ref.watch(searchQueryProvider);
  final service = ref.watch(perfumeServiceProvider);
  return service.search(query, categoryKey: category.filterKey);
});

final perfumeByIdProvider = Provider.family<Perfume?, String>((ref, id) {
  return ref.watch(perfumeServiceProvider).getById(id);
});
