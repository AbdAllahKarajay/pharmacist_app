import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/models/category_model.dart';
import 'package:pharmacist_application/presentation/components/appBar/home_app_bar.dart';

import '../../../core/data/enums/loading_states.dart';
import '../../components/general/error_view.dart';
import '../../components/general/theme_button.dart';
import 'components/product_card.dart';
import 'components/product_details.dart';
import 'products_controller.dart';

class ProductsPage extends StatelessWidget {
  const

   ProductsPage({Key? key, required this.category}) : super(key: key);
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    Get.productsController.getProducts(categoryId: category.id);
    return Scaffold(
      appBar: HomeAppBar(
        title: Text(category.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: RefreshIndicator(
          onRefresh: () => Get.productsController.getProducts(categoryId: category.id),
          child: Obx(
                () {
              if (Get.productsController.state.value ==
                  LoadingStates.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (Get.productsController.state.value ==
                  LoadingStates.error) {
                return const Center(child: ErrorView());
              }
              return ListView.builder(
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 1),
                itemCount: Get.productsController.products.length,
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ProductCard(
                      index: index,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
