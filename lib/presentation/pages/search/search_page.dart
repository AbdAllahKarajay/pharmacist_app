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
    Get.searchController.getProducts();
    return Scaffold(
      appBar: HomeAppBar(
        searchController: TextEditingController(text: Get.searchController.searchText.value),
        search: true,
        searchEnable: true,

      ),
      body: Obx(
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
                const SizedBox(height: 10),
                Align(alignment: AlignmentDirectional.centerStart, child: Text("${"search_by".tr}:")),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        selectedColor: Theme.of(context).primaryColor,
                          label: Text('category'.tr,style: const TextStyle(fontSize: 13)),
                          onSelected: (value) =>
                              Get.searchController.selectedType.value = 1,
                          selected: Get.searchController.selectedType.value == 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                          selectedColor: Theme.of(context).primaryColor,
                          label: Text('medicine_name'.tr,style: const TextStyle(fontSize: 13)),
                          onSelected: (value) =>
                              Get.searchController.selectedType.value = 2,
                          selected: Get.searchController.selectedType.value == 2),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                          selectedColor: Theme.of(context).primaryColor,
                          label: Text('company'.tr,style: const TextStyle(fontSize: 13)),
                          onSelected: (value) =>
                              Get.searchController.selectedType.value = 3,
                          selected: Get.searchController.selectedType.value == 3),
                    ),
                  ],
                ),
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
    );
  }
}
