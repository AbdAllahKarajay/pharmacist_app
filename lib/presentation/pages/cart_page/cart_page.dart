import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/presentation/components/general/main_filled_button.dart';
import 'package:pharmacist_application/presentation/pages/cart_page/cart_controller.dart';
import 'package:pharmacist_application/presentation/pages/home_page/order_page/order_controller.dart';
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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: Get.cartController.products.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductCartTile(
                      product:
                          Get.cartController.products.entries.elementAt(index).key,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(()=> Text("${"total_price".tr}: ${Get.cartController.total_price}")),
              const SizedBox(height: 20),
              Center(child: MainFilledButton(onTap: () async {
                Get.back();
                await Get.ordersController.makeOrder(Get.cartController.total_price, Get.cartController.products);
                await Future.delayed(const Duration(milliseconds: 500));
                Get.cartController.products.clear();
              }, child: Text("send".tr))),
              const SizedBox(height: 60),
            ],
          );
        },
      ),
    );
  }
}
