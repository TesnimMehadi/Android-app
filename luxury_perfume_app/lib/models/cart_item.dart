import 'perfume.dart';

class CartItem {
  const CartItem({
    required this.perfume,
    this.quantity = 1,
  });

  final Perfume perfume;
  final int quantity;

  double get total => perfume.price * quantity;

  String get formattedTotal => '£${total.toStringAsFixed(2)}';

  CartItem copyWith({Perfume? perfume, int? quantity}) {
    return CartItem(
      perfume: perfume ?? this.perfume,
      quantity: quantity ?? this.quantity,
    );
  }
}
