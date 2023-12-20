import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/models/category_model.dart';
import 'package:pharmacist_application/presentation/components/appBar/home_app_bar.dart';

import '../../../core/data/enums/loading_states.dart';
import '../../components/general/error_view.dart';
import 'components/product_card.dart';
import 'products_controller.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key, required this.category}) : super(key: key);
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController();
    Get.productsController.getProducts(categoryId: category.id);
    return Scaffold(
      appBar: HomeAppBar(
        title: Text(category.name),
        centerTitle: true,
        search: true,
        searchController: textEditingController,
        onSearch: (p0) {
          Get.productsController.search(categoryId: category.id, value: p0);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: RefreshIndicator(
          onRefresh: () =>
              Get.productsController.getProducts(categoryId: category.id),
          child: Obx(
            () {
              if (Get.productsController.state.value == LoadingStates.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (Get.productsController.state.value == LoadingStates.error) {
                return const Center(child: ErrorView());
              }
              return Column(
                children: [
                  if (Get.productsController.searchTypeIndex != null) 
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ChoiceChip(
                            label: Text(Get.productsController.searchTypes[0].tr),
                            onSelected: (value) {
                              if(value) {
                                Get.productsController.searchTypeIndex?.value = 0;
                                Get.sear
                              }
                            },
                            selected:
                                Get.productsController.searchTypeIndex!.value ==
                                    0,
                            selectedColor: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 15,),
                          ChoiceChip(
                            label: Text(Get.productsController.searchTypes[1].tr),
                            onSelected: (value) {
                              if(value) {
                                Get.productsController.searchTypeIndex?.value = 1;
                              }
                            },
                            selected:
                                Get.productsController.searchTypeIndex!.value ==
                                    1,
                            selectedColor: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                  ),
                  Expanded(
                    child: ListView.builder(
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
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
