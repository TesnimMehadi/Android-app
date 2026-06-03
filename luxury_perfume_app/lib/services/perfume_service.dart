import '../constants/app_assets.dart';
import '../models/perfume.dart';

class PerfumeService {
  static const Perfume homeFeatured = Perfume(
    id: 'home',
    brand: 'MAISON FRANCIS',
    name: 'AQUA UNIVERSALIS',
    volume: '100ML',
    price: 70.00,
    imageUrl: AppAssets.shalimar1,
    description:
        'A fresh, luminous fragrance that evokes the scent of freshly laundered linen drying in the Mediterranean sun.',
    category: 'featured',
    isFeatured: true,
  );

  static final List<Perfume> _perfumes = [
    homeFeatured,
    const Perfume(
      id: 'jadore-1',
      brand: 'DIOR',
      name: "J'ADORE",
      volume: '100ML',
      price: 95.00,
      imageUrl: AppAssets.jadore1,
      description:
          'An iconic floral bouquet — jasmine, ylang-ylang, and rose in golden harmony.',
      category: 'jadore',
    ),
    const Perfume(
      id: 'jadore-2',
      brand: 'DIOR',
      name: "J'ADORE PARFUM D'EAU",
      volume: '50ML',
      price: 88.00,
      imageUrl: AppAssets.jadore2,
      description:
          'Alcohol-free floral freshness — luminous and delicate on the skin.',
      category: 'jadore',
    ),
    const Perfume(
      id: 'jadore-3',
      brand: 'DIOR',
      name: "J'ADORE ABSOLU",
      volume: '75ML',
      price: 110.00,
      imageUrl: AppAssets.jadore3,
      description:
          'An absolute concentration of floral femininity — jasmine sambac and rose centifolia.',
      category: 'jadore',
    ),
    const Perfume(
      id: 'jadore-4',
      brand: 'GUERLAIN',
      name: 'DIAMOND',
      volume: '100ML',
      price: 70.00,
      imageUrl: AppAssets.guerlanDiamond,
      description:
          'An opulent floral bouquet with sparkling diamond-like facets of jasmine and rose.',
      category: 'jadore',
    ),
    const Perfume(
      id: 'jadore-5',
      brand: 'GUERLAIN',
      name: 'SHALIMAR',
      volume: '100ML',
      price: 60.00,
      imageUrl: AppAssets.shalimar,
      description:
          'The legendary oriental masterpiece — warm vanilla, iris, and bergamot in perfect harmony.',
      category: 'jadore',
    ),
    const Perfume(
      id: 'miss-1',
      brand: 'DIOR',
      name: 'MISS DIOR',
      volume: '100ML',
      price: 85.00,
      imageUrl: AppAssets.missDior1,
      description:
          'A romantic floral chypre with notes of peony, rose, and soft musk.',
      category: 'miss_dior',
    ),
    const Perfume(
      id: 'miss-2',
      brand: 'DIOR',
      name: "MISS DIOR ROSE N' ROSES",
      volume: '50ML',
      price: 78.00,
      imageUrl: AppAssets.missDior2,
      description:
          'A vibrant rose bouquet — centifolia and damascena in full bloom.',
      category: 'miss_dior',
    ),
    const Perfume(
      id: 'poison-1',
      brand: 'DIOR',
      name: 'MIDNIGHT POISON',
      volume: '100ML',
      price: 82.00,
      imageUrl: AppAssets.poison1,
      description:
          'A mysterious dark floral — rose, patchouli, and amber in moonlit elegance.',
      category: 'poison',
    ),
    const Perfume(
      id: 'poison-2',
      brand: 'DIOR',
      name: 'PURE POISON',
      volume: '50ML',
      price: 76.00,
      imageUrl: AppAssets.poison2,
      description:
          'Soft lavender and vanilla — an ethereal, powdery floral veil.',
      category: 'poison',
    ),
    const Perfume(
      id: 'angel-1',
      brand: 'PANACHE',
      name: 'ANGEL DUST',
      volume: '100ML',
      price: 72.00,
      imageUrl: AppAssets.angel1,
      description:
          'A celestial gourmand — soft vanilla, musk, and feather-light sweetness.',
      category: 'angel',
    ),
    const Perfume(
      id: 'angel-2',
      brand: 'GIVENCHY',
      name: 'ANGE OU DÉMON',
      volume: '50ML',
      price: 80.00,
      imageUrl: AppAssets.angel2,
      description:
          'Dual nature in one scent — luminous florals meet deep, sensual woods.',
      category: 'angel',
    ),
    const Perfume(
      id: 'angel-3',
      brand: 'MAISON',
      name: 'SCENT OF ANGEL',
      volume: '100ML',
      price: 68.00,
      imageUrl: AppAssets.angel3,
      description:
          'Iconic gourmand — patchouli, chocolate, caramel, and red berries.',
      category: 'angel',
    ),
  ];

  List<Perfume> getAllPerfumes() =>
      List.unmodifiable(_perfumes.where((p) => p.category != 'featured'));

  List<Perfume> getFeaturedPerfumes() => [homeFeatured];

  Perfume getHomeFeatured() => homeFeatured;

  Perfume? getById(String id) {
    try {
      return _perfumes.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Perfume> filterByCategory(String categoryKey) {
    if (categoryKey == 'all') return getAllPerfumes();
    return _perfumes.where((p) => p.category == categoryKey).toList();
  }

  List<Perfume> search(String query, {String categoryKey = 'all'}) {
    final base = filterByCategory(categoryKey);
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return base;
    return base
        .where(
          (p) =>
              p.name.toLowerCase().contains(q) ||
              p.brand.toLowerCase().contains(q),
        )
        .toList();
  }
}
