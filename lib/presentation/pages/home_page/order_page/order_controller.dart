import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';
import 'package:pharmacist_application/core/data/models/order.dart';
import 'package:pharmacist_application/core/data/models/product.dart';
import 'package:pharmacist_application/core/repository/error_handling/remote_exceptions.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/repository/remote_datasource.dart';

class OrderController extends GetxController{
  final Rx<LoadingStates> state = LoadingStates.nothing.obs;
  final RxList<Order> orders = <Order>[].obs;
  int page = 2;

  Future<void> getOrders() async {
    state.value = LoadingStates.loading;
    try{
      List<Order> newOrders = await RemoteDatasource.instance.performGetListRequest<Order>("/api/order", fromMap: Order.fromMap);
      page = 2;
      orders.value = newOrders;
      state.value = LoadingStates.done;
    }on RemoteExceptions{
      state.value = LoadingStates.error;
    }
  }

  Future<void> getMore() async {
    try {
      if(page == -1){
        return;
      }
      List<Order> newOrders = await RemoteDatasource.instance.performGetListRequest<Order>("/api/order/${page++}", fromMap: Order.fromMap);
      if(newOrders.isEmpty){
        page = -1;
      }else{
        orders.addAll(newOrders);
      }
    } on RemoteExceptions {
      state.value = LoadingStates.error;
    }
  }

  makeOrder(int totalPrice, Map<Product, int> products) async {
    state.value = LoadingStates.loading;
    try{
      Order newOrder = await RemoteDatasource.instance.performPostRequest<Order>("/api/order", fromMap: Order.fromMap, body: {
        "date": intl.DateFormat("yyyy-MM-dd").format(DateTime.now()),
        "total_price": totalPrice,
        "medicines": products.entries.map((e) => {
          "id": e.key.id,
          "medicine_amount": e.value
        }).toList(),
      });
      orders.add(newOrder);
      state.value = LoadingStates.done;
    }on RemoteExceptions{
      state.value = LoadingStates.error;
    }
  }
}

extension FindOrderController on GetInterface{
  OrderController get ordersController => Get.find<OrderController>();
}