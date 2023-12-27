import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/presentation/pages/home_page/categories_page/categories_controller.dart';
import 'package:pharmacist_application/presentation/pages/home_page/order_page/order_controller.dart';

import '../../../../core/data/enums/loading_states.dart';
import '../../../components/general/error_view.dart';
import '../../products_page/products_page.dart';
import 'components/order_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      RefreshIndicator(
        onRefresh: () => Get.ordersController.getOrders(),
        child: Obx(
              () {
            if (Get.ordersController.state.value ==
                LoadingStates.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (Get.ordersController.state.value ==
                LoadingStates.error) {
              return const Center(child: ErrorView());
            }
            return ListView.builder(
              itemCount: Get.ordersController.orders.length,
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (context, index) {
                final order = Get.ordersController.orders[index];
                return OrderCard(
                  order: order,
                  onTap: (){},
                );
              },
            );
          },
        ),
      );
  }
}
