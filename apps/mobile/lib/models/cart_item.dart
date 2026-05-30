import 'product.dart';

class CartItem {
  final String id;
  final Product product;
  int quantity;
  final String selectedSize;
  final String selectedColor;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.selectedSize,
    required this.selectedColor,
  });

  double get totalPrice => product.price * quantity;

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }
}
