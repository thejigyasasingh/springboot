import '../models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      Product(
        id: 1,
        name: 'Wireless Headphones',
        description: 'Noise cancelling over-ear headphones with 30h battery.',
        price: 129.99,
        imageUrl: 'https://via.placeholder.com/200x200.png?text=Headphones',
      ),
      Product(
        id: 2,
        name: 'Smart Watch',
        description: 'Fitness tracking, notifications, and 3-day battery life.',
        price: 89.50,
        imageUrl: 'https://via.placeholder.com/200x200.png?text=Watch',
      ),
      Product(
        id: 3,
        name: 'Mechanical Keyboard',
        description: 'Tactile switches with RGB lighting and detachable cable.',
        price: 74.25,
        imageUrl: 'https://via.placeholder.com/200x200.png?text=Keyboard',
      ),
      Product(
        id: 4,
        name: 'Portable Speaker',
        description: 'Water-resistant speaker with deep bass and 12h playtime.',
        price: 59.99,
        imageUrl: 'https://via.placeholder.com/200x200.png?text=Speaker',
      ),
    ];
  }
}

