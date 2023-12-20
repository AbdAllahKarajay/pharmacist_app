import 'package:get/get.dart';

import '../../../core/data/enums/loading_states.dart';
import '../../../core/data/models/category_model.dart';
import '../../../core/data/models/company_model.dart';
import '../../../core/data/models/product.dart';
import '../../../core/repository/error_handling/remote_exceptions.dart';

class SearchGetController extends GetxController{
  final Rx<LoadingStates> state = LoadingStates.nothing.obs;
  final RxList<Product> products = <Product>[].obs;

  static const staticProducts = [
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
    Product(
      id: 3,
      scientific_name: "scientific_name3",
      commercial_name: "commercial_name3",
      company: CompanyModel(id: 1, name: "Company"),
      price: 50,
      category: CategoryModel(id: 1, name: "Category"),
    ),
    Product(
      id: 4,
      scientific_name: "scientific_name4",
      commercial_name: "commercial_name4",
      company: CompanyModel(id: 1, name: "Company"),
      price: 50,
      category: CategoryModel(id: 1, name: "Category"),
    ),
  ];

  RxInt selectedType = 0.obs;

  RxString searchText = "".obs;

  Future<void> getProducts() async {
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
}

extension FindAuthController on GetInterface{
  SearchGetController get searchController => Get.find<SearchGetController>();
}