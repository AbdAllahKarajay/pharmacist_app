import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';
import 'package:pharmacist_application/core/data/models/product.dart';
import 'package:pharmacist_application/core/repository/error_handling/remote_exceptions.dart';
import 'package:pharmacist_application/presentation/pages/products_page/products_controller.dart';
class FavoriteController extends GetxController{
  final Rx<LoadingStates> state = LoadingStates.nothing.obs;
  final RxList<Product> products = <Product>[].obs;

  Future<void> getProducts({int? categoryId}) async {
    state.value = LoadingStates.loading;
    try {
      // final newProducts = await RemoteDatasource.instance.performGetListRequest<Product>("/api/category/$categoryId/medicines", fromMap: Product.fromMap);
      final newProducts = staticProducts;
      state.value = LoadingStates.done;
      products.value = newProducts;
    } on RemoteExceptions {
      state.value = LoadingStates.error;
    }
  }

  Future<void> addProduct(int productIndex) async {

  }

  void removeProduct(int productIndex) {

  }
}

extension FindController on GetInterface{
  FavoriteController get favoriteController => Get.find<FavoriteController>();
}