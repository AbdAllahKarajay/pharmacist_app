import 'package:flutter/material.dart';

import '../../../../../core/data/models/category_model.dart';
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).cardTheme.color,
        ),
        child: Center(child: Text(order.total_price.toString())),
      ),
    );
  }
}
