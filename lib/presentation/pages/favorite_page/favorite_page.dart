import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'favorite_controller.dart';

import 'component/product_favorite_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("favorites".tr),
        centerTitle: true,
      ),
      body: Obx(()=> ListView.builder(itemCount: Get.favoriteController.products.length, itemBuilder: (context, index) => ProductFavoriteTile(product: Get.favoriteController.products.elementAt(index)))),
    );
  }
}
