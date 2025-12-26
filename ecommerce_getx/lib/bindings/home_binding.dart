import '../app_exports.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProductService>(ProductService());
    Get.put<CartViewModel>(CartViewModel());
    Get.put<ProductViewModel>(ProductViewModel(Get.find<ProductService>()));
  }
}

