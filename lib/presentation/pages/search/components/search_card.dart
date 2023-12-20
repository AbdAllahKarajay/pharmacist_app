import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/presentation/pages/cart_page/cart_controller.dart';
import 'package:pharmacist_application/presentation/pages/search/search_controller.dart';


class SearchProductCard extends StatelessWidget {
  const SearchProductCard({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final product = Get.searchController.products[index];
    final controller = TextEditingController()
      ..text = Get.cartController.products[product].toString();
    return InkWell(
      onTap: null,
      //     () {
      //   Get.to(ProductDetails(product: product),
      //       transition: Transition.leftToRight);
      // },
      borderRadius: BorderRadius.circular(15),
      child: Obx(
        () {
          if (controller.text !=
              Get.cartController.products[product].toString()) {
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
                  title: "commercial_name".tr, text: product.commercial_name),
              const SizedBox(height: 10),
              _buildField(
                  title: "scientific_name".tr, text: product.scientific_name),
              const SizedBox(height: 10),
              _buildField(title: "price".tr, text: product.commercial_name),
              const SizedBox(height: 10),
              _buildField(title: "category".tr, text: product.category.name),
              const SizedBox(height: 10),
              _buildField(title: "company".tr, text: product.company.name),
              const SizedBox(height: 10),
              _buildField(title: "price".tr, text: product.price.toString() + " S.P".tr),
              if (Get.cartController.products.containsKey(product))
                const SizedBox(height: 10),
              if (Get.cartController.products.containsKey(product))
              _buildField(title: "total_price".tr, text: "${(product.price * Get.cartController.products[product]!).toString()} S.P"),
              // SizedBox(
              //   height: 50,
              //   child: Flex(
              //     direction: Axis.horizontal,
              //     children: [
              //       Flexible(
              //         flex: 2,
              //         fit: FlexFit.tight,
              //         child: Flex(direction: Axis.horizontal, children: []),
              //       ),
              //       const Spacer(),
              //       if (Get.cartController.products.containsKey(product))
              //         Flexible(
              //           flex: 2,
              //           fit: FlexFit.tight,
              //           child: Text("${(product.price * Get.cartController.products[product]!).toString()} S.P    "),
              //         ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 10),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 2,
                    child: IconButton(
                        splashRadius: 25,
                        onPressed: () {
                          Get.cartController.addProduct(product);
                        },
                        icon: const Icon(Icons.add_circle)),
                  ),
                  if (Get.cartController.products.containsKey(product)) ...[
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 3,
                      child: TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            Get.cartController
                                .setProduct(product, int.parse(value));
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 2,
                      child: IconButton(
                          splashRadius: 25,
                          onPressed: () {
                            Get.cartController.removeProduct(product);
                          },
                          icon: const Icon(Icons.remove_circle)),
                    ),
                  ],
                ],
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
            "$title:",
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
