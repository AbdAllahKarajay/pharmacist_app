import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';
import 'package:pharmacist_application/core/data/models/product.dart';
import 'package:pharmacist_application/core/repository/error_handling/remote_exceptions.dart';
import 'package:pharmacist_application/presentation/pages/products_page/products_controller.dart';

import '../../../core/repository/remote_datasource.dart';

class FavoriteController extends GetxController {
  final Rx<LoadingStates> state = LoadingStates.nothing.obs;
  final RxList<Product> products = <Product>[].obs;

  Future<void> getProducts() async {
    state.value = LoadingStates.loading;
    try {
      final newProducts = await RemoteDatasource.instance
          .performGetListRequest<Product>("/api/favorit",
              fromMap: Product.fromMap);
      state.value = LoadingStates.done;
      products.value = newProducts;
    } on RemoteExceptions {
      state.value = LoadingStates.error;
    }
  }

  Future<void> addProduct(Product product) async {
    state.value = LoadingStates.loading;
    await RemoteDatasource.instance.performPostRequest<Product>("/api/favorit",
        fromMap: Product.fromMap, body: {
          "medicin_id": product.id
        });
    products.add(product);
    state.value = LoadingStates.done;
  }

  Future<void> removeProduct(Product product) async {
    state.value = LoadingStates.loading;
    await RemoteDatasource.instance.performDeleteRequest("/api/favorit",
        body: {
          "medicin_id": product.id
        });products.remove(product);
    state.value = LoadingStates.done;
  }

  isFavorite(int id) {
    return products.any((element) => element.id == id);
  }
}

extension FindController on GetInterface {
  FavoriteController get favoriteController => Get.find<FavoriteController>();
}
