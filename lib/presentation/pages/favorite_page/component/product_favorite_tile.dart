import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/data/models/product.dart';

class ProductFavoriteTile extends StatelessWidget {
  const ProductFavoriteTile({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.scientific_name),
      // subtitle: Text(product.details),
      trailing: Text("${product.price} ${"S.P".tr}"),
    );
  }
}
