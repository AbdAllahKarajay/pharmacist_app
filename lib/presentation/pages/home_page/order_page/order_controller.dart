import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';
import 'package:pharmacist_application/core/data/models/order.dart';
import 'package:pharmacist_application/core/data/models/product.dart';
import 'package:pharmacist_application/core/repository/error_handling/remote_exceptions.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/repository/remote_datasource.dart';

class OrderController extends GetxController{
  final Rx<LoadingStates> state = LoadingStates.nothing.obs;
  final Rx<LoadingStates> moreState = LoadingStates.nothing.obs;
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
      moreState.value = LoadingStates.loading;
    try {
      if(page == -1){
        return;
      }
      List<Order> newOrders = await RemoteDatasource.instance.performGetListRequest<Order>("/api/order/",params: {"page": page}, fromMap: Order.fromMap);
      page++;
      if(newOrders.isEmpty){
        page = -1;
      }else{
        orders.addAll(newOrders);
      }
      moreState.value = LoadingStates.done;
    } on RemoteExceptions {
      moreState.value = LoadingStates.error;
    }
  }

  makeOrder(int totalPrice, Map<Product, int> products) async {
    state.value = LoadingStates.loading;
    try{
      await RemoteDatasource.instance.performPostRequest("/api/order", body: {
        "date": intl.DateFormat("yyyy-MM-dd").format(DateTime.now()),
        "total_price": totalPrice,
        "medicines": products.entries.map((e) => {
          "id": e.key.id,
          "medicine_amount": e.value
        }).toList(),
      });
      getOrders();
      state.value = LoadingStates.done;
    }on RemoteExceptions{
      state.value = LoadingStates.error;
    }
  }

  deleteOrder(int id) async {
    state.value = LoadingStates.loading;
    try {
      await RemoteDatasource.instance.performDeleteRequest("/api/order/$id");
      state.value = LoadingStates.done;
      orders.removeWhere((element) => element.id == id);
    } on RemoteExceptions {
      state.value = LoadingStates.error;
    }
  }
}

extension FindOrderController on GetInterface{
  OrderController get ordersController => Get.find<OrderController>();
}