import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/presentation/components/appBar/home_app_bar.dart';
import 'package:pharmacist_application/presentation/pages/search/search_controller.dart';

import '../../../core/data/enums/loading_states.dart';
import '../../components/general/error_view.dart';
import 'components/search_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.searchController.getProducts(Get.searchController.searchText.value);
    final controller = TextEditingController(text: Get.searchController.searchText.value);
    return Scaffold(
      appBar: HomeAppBar(
        searchController: controller,
        search: true,
        searchEnable: true,
        onSearch: (p0) => Get.searchController.getProducts(p0),
      ),
      body: Column(
        children: [
          Obx(
            ()=> Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: Text(Get.searchController.searchTypes[0].tr),
                    onSelected: (value) {
                      if(value) {
                        Get.searchController.searchTypeIndex.value = 0;
                        Get.searchController.getProducts(controller.text);
                      }
                    },
                    selected:
                    Get.searchController.searchTypeIndex.value ==
                        0,
                    selectedColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 15,),
                  ChoiceChip(
                    label: Text(Get.searchController.searchTypes[1].tr),
                    onSelected: (value) {
                      if(value) {
                        Get.searchController.searchTypeIndex.value = 1;
                        Get.searchController.getProducts(controller.text);
                      }
                    },
                    selected:
                    Get.searchController.searchTypeIndex!.value ==
                        1,
                    selectedColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (Get.searchController.state.value == LoadingStates.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (Get.searchController.state.value == LoadingStates.error) {
                  return const Center(child: ErrorView());
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      // const SizedBox(height: 10),
                      // Align(alignment: AlignmentDirectional.centerStart, child: Text("${"search_by".tr}:")),
                      // Wrap(
                      //   alignment: WrapAlignment.center,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //       child: ChoiceChip(
                      //         selectedColor: Theme.of(context).primaryColor,
                      //           label: Text('category'.tr,style: const TextStyle(fontSize: 13)),
                      //           onSelected: (value) =>
                      //               Get.searchController.selectedType.value = 1,
                      //           selected: Get.searchController.selectedType.value == 1),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //       child: ChoiceChip(
                      //           selectedColor: Theme.of(context).primaryColor,
                      //           label: Text('medicine_name'.tr,style: const TextStyle(fontSize: 13)),
                      //           onSelected: (value) =>
                      //               Get.searchController.selectedType.value = 2,
                      //           selected: Get.searchController.selectedType.value == 2),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //       child: ChoiceChip(
                      //           selectedColor: Theme.of(context).primaryColor,
                      //           label: Text('company'.tr,style: const TextStyle(fontSize: 13)),
                      //           onSelected: (value) =>
                      //               Get.searchController.selectedType.value = 3,
                      //           selected: Get.searchController.selectedType.value == 3),
                      //     ),
                      //   ],
                      // ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemCount: Get.searchController.products.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SearchProductCard(
                              index: index,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
