import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmacist_application/core/config/global_data.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';
import 'package:pharmacist_application/core/repository/error_handling/remote_exceptions.dart';

import '../../../../core/data/models/category_model.dart';
import '../../../../core/repository/remote_datasource.dart';

class CategoriesController extends GetxController{
  final Rx<LoadingStates> state = LoadingStates.nothing.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  List<CategoryModel>? categories2;

  Future<void> getCategories() async {
    state.value = LoadingStates.loading;
    try{
      print('Authorization:' 'Bearer ${Get.globalData.token}');
      List<CategoryModel> newCategories = await RemoteDatasource.instance.performGetListRequest<CategoryModel>("/api/category", fromMap: CategoryModel.fromMap);
      // final newCategories = List.generate(10, (index) => CategoryModel(id: 1, name: "Category $index"));
      state.value = LoadingStates.done;
      categories.value = newCategories;
      categories2 = newCategories;
    }on RemoteExceptions{
      state.value = LoadingStates.error;
    }
  }

  void search(String value) {
    if(value.isEmpty){
      categories.value = categories2!;
    }else{
      categories.value = categories2?.where((p0) => p0.name.contains(value)).toList() ?? [];
    }
  }

}

extension FindCategoriesController on GetInterface{
  CategoriesController get categoriesController => Get.find<CategoriesController>();
}