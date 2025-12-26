import '../app_exports.dart';

class ProductViewModel extends GetxController {
  ProductViewModel(this._service);

  final ProductService _service;
  final products = <Product>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final result = await _service.fetchProducts();
      products.assignAll(result);
    } catch (_) {
      errorMessage.value = 'Failed to load products';
    } finally {
      isLoading.value = false;
    }
  }
}


