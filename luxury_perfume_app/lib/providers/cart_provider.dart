import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../models/perfume.dart';
import '../services/cart_service.dart';

final cartServiceProvider = Provider<CartService>((ref) {
  return CartService();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier(this._service) : super(_service.items);

  final CartService _service;

  void add(Perfume perfume) {
    _service.addItem(perfume);
    state = List.from(_service.items);
  }

  void remove(String perfumeId) {
    _service.removeItem(perfumeId);
    state = List.from(_service.items);
  }

  void updateQuantity(String perfumeId, int quantity) {
    _service.updateQuantity(perfumeId, quantity);
    state = List.from(_service.items);
  }

  void clear() {
    _service.clear();
    state = [];
  }

  int get itemCount => _service.itemCount;
  double get total => _service.total;
  String get formattedTotal => _service.formattedTotal;
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier(ref.watch(cartServiceProvider));
});

final cartItemCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider.notifier).itemCount;
});

final cartTotalProvider = Provider<String>((ref) {
  return ref.watch(cartProvider.notifier).formattedTotal;
});
