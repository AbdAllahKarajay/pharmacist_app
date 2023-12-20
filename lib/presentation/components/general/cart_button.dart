import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/cart_page/cart_page.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashRadius: 25,
        onPressed: () => Get.to(const CartPage(), transition: Transition.upToDown, duration: const Duration(milliseconds: 400)),
        icon: const Icon(Icons.shopping_cart_outlined));
  }
}
