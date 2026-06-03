import '../models/cart_item.dart';
import '../models/perfume.dart';

class CartService {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get total =>
      _items.fold(0.0, (sum, item) => sum + item.total);

  String get formattedTotal => '£${total.toStringAsFixed(2)}';

  bool get isEmpty => _items.isEmpty;

  void addItem(Perfume perfume) {
    final index = _items.indexWhere((i) => i.perfume.id == perfume.id);
    if (index >= 0) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
    } else {
      _items.add(CartItem(perfume: perfume));
    }
  }

  void removeItem(String perfumeId) {
    _items.removeWhere((i) => i.perfume.id == perfumeId);
  }

  void updateQuantity(String perfumeId, int quantity) {
    final index = _items.indexWhere((i) => i.perfume.id == perfumeId);
    if (index < 0) return;
    if (quantity <= 0) {
      removeItem(perfumeId);
    } else {
      _items[index] = _items[index].copyWith(quantity: quantity);
    }
  }

  void clear() => _items.clear();
}
