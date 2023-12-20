import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/models/product.dart';
class CartController extends GetxController{
  // final Rx<LoadingStates> state = LoadingStates.nothing.obs;
  final RxMap<Product, int> products = <Product, int>{}.obs;

  void addProduct(Product product) {
      products[product] = (products[product]??0) + 1;
  }

  void setProduct(Product product, int value) {
    if(value == 0){
      products.remove(product);
    }else{
      products[product] = value;
    }
  }

  void removeProduct(Product product) {
    if(products[product]!>1){
      products[product] = products[product]! - 1;
    }else{
      remove(product);
    }
  }

  void remove(Product product) {
    products.remove(product);
    update();
  }
}

extension FindController on GetInterface{
  CartController get cartController => Get.find<CartController>();
}