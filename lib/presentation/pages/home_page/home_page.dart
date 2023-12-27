import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/data/enums/loading_states.dart';
import 'package:pharmacist_application/presentation/components/appBar/home_app_bar.dart';
import 'package:pharmacist_application/presentation/components/general/error_view.dart';

import 'package:pharmacist_application/presentation/pages/home_page/categories_page/categories_controller.dart';
import 'package:pharmacist_application/presentation/pages/home_page/categories_page/categories_screen.dart';

import '../products_page/products_page.dart';
import 'categories_page/components/category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  late final TabController tabController;
  @override
  void initState() {
    tabController  = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Get.categoriesController.getCategories();
    return Scaffold(
      appBar: HomeAppBar(
        searchController: TextEditingController(),
        search: true,
        searchButton: true,
        bottom: true,
        controller: tabController,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TabBarView(
          controller: tabController,
          children: [
            CategoriesScreen(),
            Column(),
          ],
        ),
      ),
    );
  }
}