import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';
import 'package:pharmacist_application/core/data/models/product.dart';
import 'package:pharmacist_application/core/repository/error_handling/remote_exceptions.dart';

import '../../../core/data/models/category_model.dart';
import '../../../core/data/models/company_model.dart';
import '../../../core/repository/remote_datasource.dart';

const staticProducts = [
  Product(
    id: 1,
    scientific_name: "scientific_name",
    commercial_name: "commercial_name",
    company: CompanyModel(id: 1, name: "Company"),
    price: 100,
    category: CategoryModel(id: 1, name: "Category"),
  ),
  Product(
    id: 2,
    scientific_name: "scientific_name2",
    commercial_name: "commercial_name2",
    company: CompanyModel(id: 1, name: "Company"),
    price: 50,
    category: CategoryModel(id: 1, name: "Category"),
  ),
];

class ProductsController extends GetxController {
  final Rx<LoadingStates> state = LoadingStates.nothing.obs;
  final RxList<Product> products = <Product>[].obs;
  RxInt? searchTypeIndex;
  List<String> searchTypes = ["scientific_name", "commercial_name"];
  String get searchType => searchTypes[searchTypeIndex!.value];

  Future<void> getProducts({int? categoryId}) async {
    state.value = LoadingStates.loading;
    try {
      // final newProducts = staticProducts;
      final newProducts = await RemoteDatasource.instance
          .performGetListRequest<Product>("/api/category/$categoryId/medicines",
              fromMap: Product.fromMap);
      // final newProducts = staticProducts;
      state.value = LoadingStates.done;
      products.value = newProducts;
    } on RemoteExceptions {
      state.value = LoadingStates.error;
    }
  }

  Future<void> search({required int categoryId, required String value}) async {
    try {
      searchTypeIndex ??= 0.obs;
      final newProducts = await RemoteDatasource.instance
          .performGetListRequest<Product>("/api/search",
              // params: {"category_id": categoryId, searchType: value},
              fromMap: Product.fromMap);
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
