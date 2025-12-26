import '../app_exports.dart';

class HomePage extends GetView<ProductViewModel> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Get.find<CartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopEasy application'),
        actions: [
          Obx(() {
            final count = cartViewModel.totalItems;
            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                //   onPressed: () => _showCartSheet(context, cartViewModel),
                  onPressed: () => Get.to(() => const CartPage()),
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
                if (count > 0)
                  Positioned(
                    right: 8,
                    top: 10,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final error = controller.errorMessage.value;
        if (error != null) {
          return Center(
            child: Text(error),
          );
        }

        final products = controller.products;
        if (products.isEmpty) {
          return const Center(child: Text('No products available'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: products.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (_, index) {
            final product = products[index];
            return ProductCard(
              product: product,
              onAddToCart: () => cartViewModel.addProduct(product),
            );
          },
        );
      }),
    );
  }

  void _showCartSheet(BuildContext context, CartViewModel cartController) {
    Get.bottomSheet(
      Obx(() {
        final items = cartController.cartItems;
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: items.isEmpty
                ? const SizedBox(
                    height: 120,
                    child: Center(child: Text('Your cart is empty')),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Text(
                        'Your Cart',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: items.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (_, index) {
                            final item = items[index];
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue.shade50,
                                  child: Text(item.quantity.toString()),
                                ),
                                title: Text(item.product.name),
                                subtitle: Text(
                                  '\$${item.product.price.toStringAsFixed(2)} x ${item.quantity}',
                                ),
                                trailing: SizedBox(
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                onPressed: () => cartController
                                    .removeProduct(item.product),
                                        icon: const Icon(
                                            Icons.remove_circle_outline),
                                      ),
                                      IconButton(
                                onPressed: () => cartController
                                    .addProduct(item.product),
                                        icon: const Icon(
                                            Icons.add_circle_outline),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\$${cartController.totalPrice.toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: cartController.clearCart,
                                child: const Text('Clear'),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Checkout flow not implemented',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Checkout'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        );
      }),
      isScrollControlled: true,
    );
  }
}

