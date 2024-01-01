import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/data/models/order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({Key? key, required this.order, required this.onTap})
      : super(key: key);
  final Order order;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(15),
        //   color: Theme.of(context).cardTheme.color,
        // ),
        child: ExpansionTile(
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
          children:
            order.medicines.map((e) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(e.medicine_id.toString()),
                Text("medicine_amount".tr + e.medicine_amount.toString()),
              ],
            )).toList()
        ),
      ),
    );
  }
}
