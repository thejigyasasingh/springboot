import 'package:ecommerce_getx/app_exports.dart';
import 'package:ecommerce_getx/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const product = Product(
    id: 1,
    name: 'Test Product',
    description: 'Test',
    price: 20,
    imageUrl: '',
  );

  late CartViewModel cartController;

  setUp(() {
    cartController = CartViewModel();
  });

  test('addProduct increments quantity and totals', () {
    cartController.addProduct(product);
    cartController.addProduct(product);

    expect(cartController.totalItems, 2);
    expect(cartController.totalPrice, 40);
    expect(cartController.cartItems.first.quantity, 2);
  });

  test('removeProduct decrements and removes when quantity is zero', () {
    cartController.addProduct(product);
    cartController.addProduct(product);

    cartController.removeProduct(product);
    expect(cartController.totalItems, 1);
    expect(cartController.cartItems.first.quantity, 1);

    cartController.removeProduct(product);
    expect(cartController.totalItems, 0);
    expect(cartController.cartItems, isEmpty);
  });

  test('clearCart empties cart', () {
    cartController.addProduct(product);
    cartController.clearCart();

    expect(cartController.totalItems, 0);
    expect(cartController.cartItems, isEmpty);
  });
}

