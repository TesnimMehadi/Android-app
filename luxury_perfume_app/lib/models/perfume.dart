class Perfume {
  const Perfume({required this.id, required this.brand, required this.name,
    required this.volume,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
    this.isFeatured = false,
  });

  final String id;
  final String brand;
  final String name;
  final String volume;
  final double price;
  final String imageUrl;
  final String description;
  final String category;
  final bool isFeatured;

  String get formattedPrice => '£${price.toStringAsFixed(2)}';

  Perfume copyWith({
    String? id,
    String? brand,
    String? name,
    String? volume,
    double? price,
    String? imageUrl,
    String? description,
    String? category,
    bool? isFeatured,
  }) {
    return Perfume(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      name: name ?? this.name,
      volume: volume ?? this.volume,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      category: category ?? this.category,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}

enum PerfumeCategory {
  all('ALL'),
  jadore("J'ADORE"),
  missDior('MISS DIOR'),
  poison('POISON'),
  angel('ANGEL');

  const PerfumeCategory(this.label);
  final String label;

  String get filterKey => switch (this) {
        PerfumeCategory.all => 'all',
        PerfumeCategory.jadore => 'jadore',
        PerfumeCategory.missDior => 'miss_dior',
        PerfumeCategory.poison => 'poison',
        PerfumeCategory.angel => 'angel',
      };
}
