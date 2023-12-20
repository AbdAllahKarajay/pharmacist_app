import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/presentation/pages/cart_page/cart_controller.dart';
import 'component/product_cart_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cart".tr),
        centerTitle: true,
      ),
      body: GetBuilder<CartController>(
        builder: (controller) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: Get.cartController.products.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductCartTile(
                product:
                    Get.cartController.products.entries.elementAt(index).key,
              ),
            ),
          );
        },
      ),
    );
  }
}
