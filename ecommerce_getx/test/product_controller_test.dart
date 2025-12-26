import 'package:ecommerce_getx/app_exports.dart';
import 'package:ecommerce_getx/models/product.dart';
import 'package:ecommerce_getx/services/product_service.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeProductService extends ProductService {
  FakeProductService(this.products);

  final List<Product> products;

  @override
  Future<List<Product>> fetchProducts() async => products;
}

class ErrorProductService extends ProductService {
  @override
  Future<List<Product>> fetchProducts() {
    throw Exception('Network error');
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ProductController', () {
    test('loadProducts populates products list', () async {
      final controller = ProductViewModel(
        FakeProductService(
          const [
            Product(
              id: 99,
              name: 'Test Product',
              description: 'Desc',
              price: 10,
              imageUrl: '',
            ),
          ],
        ),
      );

      await controller.loadProducts();

      expect(controller.products.length, 1);
      expect(controller.products.first.id, 99);
      expect(controller.errorMessage.value, isNull);
      expect(controller.isLoading.value, isFalse);
    });

    test('loadProducts sets error message when service throws', () async {
      final controller = ProductViewModel(ErrorProductService());

      await controller.loadProducts();

      expect(controller.products, isEmpty);
      expect(controller.errorMessage.value, isNotNull);
    });
  });
}

