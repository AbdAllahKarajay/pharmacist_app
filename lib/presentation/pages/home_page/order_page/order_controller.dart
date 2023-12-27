import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';
import 'package:pharmacist_application/core/data/models/order.dart';
import 'package:pharmacist_application/core/repository/error_handling/remote_exceptions.dart';

import '../../../../core/data/models/category_model.dart';
import '../../../../core/repository/remote_datasource.dart';

class OrderController extends GetxController{
  final Rx<LoadingStates> state = LoadingStates.nothing.obs;
  final RxList<Order> orders = <Order>[].obs;

  Future<void> getOrders() async {
    state.value = LoadingStates.loading;
    try{
      List<Order> newOrders = await RemoteDatasource.instance.performGetListRequest<Order>("/api/order", fromMap: Order.fromMap);
      state.value = LoadingStates.done;
      orders.value = newOrders;
    }on RemoteExceptions{
      state.value = LoadingStates.error;
    }
  }

}

extension FindOrderController on GetInterface{
  OrderController get ordersController => Get.find<OrderController>();
}