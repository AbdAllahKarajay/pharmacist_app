import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/presentation/pages/home_page/categories_page/categories_controller.dart';

import '../../../../core/data/enums/loading_states.dart';
import '../../../components/general/error_view.dart';
import '../../products_page/products_page.dart';
import 'components/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Get.categoriesController.getCategories(),
      child: Column(
        children: [
          const SizedBox(height: 10),
          SearchBar(
            hintText: "search for category".tr,
            leading: const Icon(Icons.search),
            onChanged: (value) {
              Get.categoriesController.search(value);
            },
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Obx(
              () {
                if (Get.categoriesController.state.value ==
                    LoadingStates.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (Get.categoriesController.state.value ==
                    LoadingStates.error) {
                  return const Center(child: ErrorView());
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: Get.categoriesController.categories.length,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemBuilder: (context, index) {
                    final category = Get.categoriesController.categories[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: CategoryCard(
                        category: category,
                        onTap: () {
                          Get.to(ProductsPage(category: category),
                              transition: Transition.leftToRight,
                              duration: const Duration(milliseconds: 400));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
