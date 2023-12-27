import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../cart_controller.dart';

import '../../../../core/data/models/product.dart';
import '../../products_page/components/product_details.dart';

class ProductCartTile extends StatelessWidget {
  const ProductCartTile({Key? key, required this.product}) : super(key: key);
  final Product product;


  @override
  Widget build(BuildContext context) {
    // final product = Get.productsController.products[productt];
    final controller = TextEditingController()
      ..text = Get.cartController.products[product].toString();
    return InkWell(
      onTap: () {
        Get.to(ProductDetails(product: product),
            transition: Transition.leftToRight);
      },
      borderRadius: BorderRadius.circular(15),
      child: Obx(
            () {
          if (controller.text != Get.cartController.products[product].toString()) {
            controller.text = Get.cartController.products[product].toString();
          }
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              border: Get.cartController.products.containsKey(product)
                  ? Border.all(color: Colors.green)
                  : null,
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).cardTheme.color,
            ),
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              const SizedBox(height: 10),
              _buildField(
                  title: product.commercial_name, text: "${product.price.toString()} S.P"),
              const SizedBox(height: 10),
              _buildField(
                  title: "${"scientific_name".tr}:", text: product.scientific_name),
              const SizedBox(height: 10),
              _buildField(title: "${"price".tr}:", text: product.commercial_name),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: Get.cartController.products.containsKey(product)
                            ? [
                          IconButton(
                              splashRadius: 25,
                              onPressed: () {
                                Get.cartController.addProduct(product);
                              },
                              icon: const Icon(Icons.add_circle)),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 30,
                            child: TextField(
                              controller: controller,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              // onTapOutside: (pointer){
                              //   print(Get.cartController.products[product]);
                              // },
                              onChanged: (value) {
                                // print(int.parse(value));
                                if (value.isNotEmpty) {
                                  Get.cartController.setProduct(
                                      product, int.parse(value));
                                }
                              },
                              onSubmitted: (value) {
                                // if(!value.isEmpty){
                                //   Get.cartController.setProduct(index, int.parse(value));
                                // }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                              splashRadius: 25,
                              onPressed: () {
                                Get.cartController.removeProduct(product);
                              },
                              icon: const Icon(Icons.remove_circle)),
                        ]
                            : [
                          IconButton(
                              onPressed: () {
                                Get.cartController.addProduct(product);
                              },
                              icon: const Icon(Icons.add_circle)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text("${(product.price * Get.cartController.products[product]!).toString()} S.P"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ]),
          );
        },
      ),
    );
  }

  _buildField({
    required String title,
    String? text,
    Widget? child,
  }) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        const Spacer(),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: child ??
              Text(
                text ?? "",
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.start,
              ),
        ),
      ],
    );
  }
}
