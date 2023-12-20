import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';
import 'package:pharmacist_application/presentation/components/appBar/home_app_bar.dart';
import 'package:pharmacist_application/presentation/components/general/error_view.dart';

import 'package:pharmacist_application/presentation/pages/categories_page/categories_controller.dart';
import 'package:pharmacist_application/presentation/pages/categories_page/components/category_card.dart';

import '../products_page/products_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> with TickerProviderStateMixin{
  late final TabController tabController;
  @override
  void initState() {
    tabController  = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Get.categoriesController.getCategories();
    return Scaffold(
      appBar: HomeAppBar(
        searchController: TextEditingController(),
        search: true,
        searchButton: true,
        bottom: true,
        controller: tabController,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TabBarView(
          controller: tabController,
          children: [
            RefreshIndicator(
              onRefresh: () => Get.categoriesController.getCategories(),
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
                            Get.to(ProductsPage(category: category), transition: Transition.leftToRight, duration: const Duration(milliseconds: 400));
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Column(),
          ],
        ),
      ),
    );
  }
}