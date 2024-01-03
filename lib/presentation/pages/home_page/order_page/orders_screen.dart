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
    final scrollController = ScrollController();
    listener(){
      if(scrollController.position.atEdge){
        Get.ordersController.getMore();
      }
    }
    scrollController.addListener(listener);
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
              controller: scrollController,
              itemCount: Get.ordersController.orders.length + 1,
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (context, index) {
                if(index == Get.ordersController.orders.length){
                  if(Get.ordersController.moreState.value == LoadingStates.error){
                    return const Center(child: Icon(Icons.cancel_outlined, size: 50, color: Colors.red,));
                  }else if(Get.ordersController.moreState.value == LoadingStates.done){
                    return Center(child: Text("no_more".tr));
                  }else if(Get.ordersController.moreState.value == LoadingStates.nothing){
                    return const Center(child: SizedBox());
                  }else{
                    return const Center(child: CircularProgressIndicator());
                  }
                }
                final order = Get.ordersController.orders[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: OrderCard(
                    order: order,
                  ),
                );
              },
            );
          },
        ),
      );
  }
}
