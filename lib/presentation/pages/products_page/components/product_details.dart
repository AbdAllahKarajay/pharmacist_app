import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/util/palette.dart';
import '../../../../core/data/models/product.dart';
import '../../../components/appBar/home_app_bar.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: Text(product.commercial_name),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).cardTheme.color,
          ),
          child: Column(children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${"commercial_name".tr}:', style: const TextStyle(color: ColorConfig.primaryLight)),
                Text(product.commercial_name),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${"scientific_name".tr}:', style: const TextStyle(color: ColorConfig.primaryLight)),
                Text(product.scientific_name),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Price:", style: TextStyle(color: ColorConfig.primaryLight),),
                Text("${product.price.toString()} S.P"),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
