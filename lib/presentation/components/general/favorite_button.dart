import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pages/cart_page/cart_page.dart';
import '../../pages/favorite_page/favorite_page.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashRadius: 25,
        onPressed: () => Get.to(const FavoritePage(), transition: Transition.upToDown, duration: const Duration(milliseconds: 400)),
        icon: const Icon(Icons.favorite));
  }
}
