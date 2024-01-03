import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/presentation/pages/home_page/order_page/order_controller.dart';

import '../../../../../core/data/models/order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key, required this.order}) : super(key: key);
  final Order order;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        textColor: Theme.of(context).textTheme.bodyMedium!.color,
        iconColor: Theme.of(context).textTheme.bodyMedium!.color,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        trailing: order.attributes.status != 'pending'? null: IconButton(
            onPressed: () => Get.ordersController.deleteOrder(order.id),
            icon: const Icon(Icons.delete)),
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  order.attributes.status,
                  style: const TextStyle(fontSize: 12),
                ),
                const Spacer(),
                Text(
                  order.attributes.total_price.toString() + " S.P".tr,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(order.attributes.date),
                const Spacer(),
                Text(order.attributes.paid == 0 ? "unpaid".tr : "paid".tr),
              ],
            ),
            const SizedBox(height: 10),
            Text("${"medicine_count".tr}: ${order.medicines.length}"),
          ],
        ),
        children: [
          const Divider(),
          const SizedBox(height: 8),
          ...order.medicines
              .map((e) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Spacer(),
                      SizedBox(
                          width: ListTileTheme.of(context).horizontalTitleGap),
                      Text(e.medicine_id.toString()),
                      const Spacer(),
                      Text("medicine_amount".tr + e.medicine_amount.toString()),
                      const Spacer(),
                    ],
                  ))
              .toList(),
        ]);
  }
}
