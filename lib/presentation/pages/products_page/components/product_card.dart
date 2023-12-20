import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../cart_page/cart_controller.dart';
import '../products_controller.dart';


class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final product = Get.productsController.products[index];
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
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Row(
                children: [
                  Text(product.commercial_name,style: const TextStyle(fontSize: 12),),
                  const Spacer(),
                  Text(product.price.toString() + " S.P".tr, style: const TextStyle(fontSize: 12),),
                ],
              ),
              // _buildField(
              //     title: product.commercial_name,
              //     text: product.price.toString() + " S.P".tr),
              const SizedBox(height: 10),
              Align(alignment: AlignmentDirectional.centerStart, child: Text(product.scientific_name, style: const TextStyle(fontSize: 12),)),
              // _buildField(
              //     title: "${"scientific_name".tr}:",
              //     text: product.scientific_name),
              // const SizedBox(height: 10),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      product.company.name,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: IconButton(
                        splashRadius: 12,
                        onPressed: Get.cartController.products.containsKey(product)? null:  () {
                          Get.cartController.addProduct(product);
                        },
                        icon:  Icon(Icons.add_circle, color: !Get.cartController.products.containsKey(product)? null: Colors.transparent,)),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      product.category.name,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              // _buildField(title: product.company.name, text: product.category.name),
              // const SizedBox(height: 10),
              // _buildField(title: "company".tr, text: product.company.name),
              // const SizedBox(height: 10),
              // _buildField(title: "price".tr, text: product.price.toString() + " S.P".tr),
              // if (Get.cartController.products.containsKey(product))
              //   _buildField(title: "total_price".tr, text: "${(product.price * Get.cartController.products[product]!).toString()} S.P"),
              if (Get.cartController.products.containsKey(product))
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          IconButton(
                              splashRadius: 25,
                              onPressed: () {
                                Get.cartController.addProduct(product);
                              },
                              icon: const Icon(Icons.add_circle)),
                          const SizedBox(width: 10),
                          Flexible(
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
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Align(alignment: AlignmentDirectional.centerEnd, child: Text("${(product.price * Get.cartController.products[product]!).toString()} S.P")),
                    ),
                  ],
                ),
                // Flex(
                //   direction: Axis.horizontal,
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Flexible(
                //       flex: 2,
                //       child: IconButton(
                //           splashRadius: 25,
                //           onPressed: () {
                //             Get.cartController.addProduct(product);
                //           },
                //           icon: const Icon(Icons.add_circle)),
                //     ),
                //     const SizedBox(width: 10),
                //     Flexible(
                //       flex: 3,
                //       child: TextField(
                //         controller: controller,
                //         textAlign: TextAlign.center,
                //         decoration: InputDecoration(
                //             border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(25))),
                //         inputFormatters: [
                //           FilteringTextInputFormatter.digitsOnly
                //         ],
                //         keyboardType: TextInputType.number,
                //         onChanged: (value) {
                //           if (value.isNotEmpty) {
                //             Get.cartController
                //                 .setProduct(product, int.parse(value));
                //           }
                //         },
                //       ),
                //     ),
                //     const SizedBox(width: 10),
                //     Flexible(
                //       flex: 2,
                //       child: IconButton(
                //           splashRadius: 25,
                //           onPressed: () {
                //             Get.cartController.removeProduct(product);
                //           },
                //           icon: const Icon(Icons.remove_circle)),
                //     ),
                //   ],
                // ),
            ]),
          );
        },
      ),
    );
  }

}
