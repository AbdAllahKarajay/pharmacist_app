import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';
import 'package:pharmacist_application/core/data/models/product.dart';
import 'package:pharmacist_application/core/repository/error_handling/remote_exceptions.dart';

import '../../../core/repository/remote_datasource.dart';

class ProductsController extends GetxController {
  final Rx<LoadingStates> state = LoadingStates.nothing.obs;
  final Rx<LoadingStates> moreState = LoadingStates.nothing.obs;
  final RxList<Product> products = <Product>[].obs;
  RxInt? searchTypeIndex;
  List<String> searchTypes = ["scientific_name", "commercial_name"];
  int page = 2;

  String get searchType => searchTypes[searchTypeIndex!.value];

  Future<void> getProducts({required int categoryId}) async {
    state.value = LoadingStates.loading;
    try {
      final newProducts = await RemoteDatasource.instance
          .performGetListRequest<Product>("/api/category/$categoryId/medicines",
              fromMap: Product.fromMap);
      page = 2;
      products.value = newProducts;
      state.value = LoadingStates.done;
    } on RemoteExceptions {
      state.value = LoadingStates.error;
    }
  }

  Future<void> getMore({required int categoryId}) async {
    moreState.value = LoadingStates.loading;
    try {
      if (page == -1) {
        return;
      }
      final newProducts =
          await RemoteDatasource.instance.performGetListRequest<Product>(
        "/api/category/$categoryId/medicines/",
        params: {
          "page": page,
        },
        fromMap: Product.fromMap,
      );
      page++;
      if (newProducts.isEmpty) {
        page = -1;
      } else {
        products.addAll(newProducts);
      }
      moreState.value = LoadingStates.done;
    } on RemoteExceptions {
      moreState.value = LoadingStates.error;
    }
  }

  Future<void> search({required int categoryId, required String value}) async {
    try {
      searchTypeIndex ??= 0.obs;
      final newProducts =
          await RemoteDatasource.instance.performGetListRequest<Product>(
        "/api/search",
        params: {"category_id": categoryId, searchType: value},
        fromMap: Product.fromMap,
      );
      state.value = LoadingStates.done;
      products.value = newProducts;
    } on RemoteExceptions {
      state.value = LoadingStates.error;
    }
  }
}

extension FindController on GetInterface {
  ProductsController get productsController => Get.find<ProductsController>();
}
