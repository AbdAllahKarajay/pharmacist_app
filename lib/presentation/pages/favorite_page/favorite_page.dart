import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/data/enums/loading_states.dart';
import '../../components/appBar/home_app_bar.dart';
import '../../components/general/error_view.dart';
import 'favorite_controller.dart';

import 'component/product_favorite_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: Text('favorites'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: RefreshIndicator(
          onRefresh: () =>
              Get.favoriteController.getProducts(),
          child: Obx(
                () {
              if (Get.favoriteController.state.value == LoadingStates.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (Get.favoriteController.state.value == LoadingStates.error) {
                return const Center(child: ErrorView());
              }
              return ListView.builder(
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 1),
                itemCount: Get.favoriteController.products.length,
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: FavoProductCard(
                      index: index,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),);
  }
}
