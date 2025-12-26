import '../app_exports.dart';

class CartViewModel extends GetxController {
  final items = <int, CartItem>{}.obs;

  void addProduct(Product product) {
    final existing = items[product.id];
    if (existing != null) {
      items[product.id] =
          existing.copyWith(quantity: existing.quantity + 1);
    } else {
      items[product.id] = CartItem(product: product, quantity: 1);
    }
    items.refresh();
  }

  void removeProduct(Product product) {
    final existing = items[product.id];
    if (existing == null) return;

    if (existing.quantity > 1) {
      items[product.id] =
          existing.copyWith(quantity: existing.quantity - 1);
    } else {
      items.remove(product.id);
    }
    items.refresh();
  }

  void clearCart() => items.clear();

  int get totalItems =>
      items.values.fold(0, (count, item) => count + item.quantity);

  double get totalPrice =>
      items.values.fold(0, (total, item) => total + item.lineTotal);

  List<CartItem> get cartItems => items.values.toList(growable: false);
}


