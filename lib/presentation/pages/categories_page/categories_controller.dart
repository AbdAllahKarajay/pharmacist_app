import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';
import 'package:pharmacist_application/core/repository/error_handling/remote_exceptions.dart';
import 'package:pharmacist_application/core/repository/remote_datasource.dart';

import '../../../core/data/models/category_model.dart';

class CategoriesController extends GetxController{
  final Rx<LoadingStates> state = LoadingStates.nothing.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  Future<void> getCategories() async {
    state.value = LoadingStates.loading;
    try{
      List<CategoryModel> newCategories = await RemoteDatasource.instance.performGetListRequest<CategoryModel>("/api/category", fromMap: CategoryModel.fromMap);
      // final newCategories = List.generate(10, (index) => CategoryModel(id: 1, name: "Category $index"));
      state.value = LoadingStates.done;
      categories.value = newCategories;
    }on RemoteExceptions{
      state.value = LoadingStates.error;
    }
  }

}

extension FindCategoriesController on GetInterface{
  CategoriesController get categoriesController => Get.find<CategoriesController>();
}