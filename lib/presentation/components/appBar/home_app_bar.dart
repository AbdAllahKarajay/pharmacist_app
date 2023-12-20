import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/config/config.dart';
import 'package:pharmacist_application/core/util/palette.dart';
import 'package:pharmacist_application/core/util/theme.dart';
import 'package:pharmacist_application/presentation/components/general/favorite_button.dart';
import 'package:pharmacist_application/presentation/components/general/theme_button.dart';
import 'package:pharmacist_application/presentation/pages/search/search_controller.dart';

import '../../pages/search/search_page.dart';
import '../../pages/settings/settings_page.dart';
import '../general/cart_button.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController? searchController;

  HomeAppBar(
      {Key? key,
      this.title,
      this.centerTitle,
      this.onSearch,
      this.search = false,
      this.searchEnable = false,
      this.searchButton = false,
      this.bottom = false,
      this.controller, this.searchController})
      : preferredSize =
            Size.fromHeight(bottom ? kToolbarHeight * 2 : kToolbarHeight),
        super(key: key);
  final void Function(String)? onSearch;
  final Widget? title;
  final bool? centerTitle;
  final bool search;
  final bool searchEnable;
  final bool searchButton;
  final bool bottom;
  final TabController? controller;

  @override
  final Size preferredSize; // default is 56.0

  @override
  createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool _search = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: !widget.bottom
          ? null
          : TabBar(
              indicatorColor: ColorConfig.WHITE,
              tabs: const [
                Tab(text: "Products"),
                Tab(text: "My Orders"),
              ],
              controller: widget.controller),
      title: widget.search && (widget.searchEnable || _search)
          ? SizedBox(
              height: 50,
              child: TextField(
                // elevation: const MaterialStatePropertyAll(0),
                controller: widget.searchController,
                textAlignVertical: TextAlignVertical.bottom,
                cursorColor: ColorConfig.WHITE,
                onChanged: widget.onSearch,
                onSubmitted: !widget.searchButton? null : (value) {
                  Get.searchController.searchText.value = value;
                  Get.to(() => const SearchPage(),
                        transition: Transition.upToDown,
                        duration: const Duration(milliseconds: 400));
                },
                style: const TextStyle(color: ColorConfig.WHITE),
                decoration: InputDecoration(
                  prefixIcon: IconButton(onPressed: (){
                    if(widget.searchButton){
                      Get.searchController.searchText.value = widget.searchController!.text;
                      Get.to(() => const SearchPage(),
                          transition: Transition.upToDown,
                          duration: const Duration(milliseconds: 400));
                    }
                    else if(widget.onSearch != null){
                      widget.onSearch!(widget.searchController!.text);
                    }
                  }, icon: const Icon(Icons.search, color: ColorConfig.WHITE)),
                  suffixIcon: widget.searchEnable
                      ? null
                      : IconButton(
                          splashRadius: 25,
                          onPressed: () {
                            setState(() => _search = false);
                          },
                          icon: const Icon(Icons.cancel, color: ColorConfig.WHITE),
                        ),
                  hintText: "search".tr,
                  hintStyle: const TextStyle(color: ColorConfig.WHITE),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: ColorConfig.WHITE, width: 2)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: ColorConfig.WHITE, width: 2)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(color: ColorConfig.WHITE, width: 2)),
                ),
                // leading: const Icon(Icons.search),
                // trailing: widget.searchEnable
                //     ? null
                //     : [
                //         IconButton(
                //           splashRadius: 25,
                //           onPressed: () {
                //             setState(() => _search = false);
                //           },
                //           icon: const Icon(Icons.remove),
                //         ),
                //       ],
                // hintText: "Search",
                // hintStyle: const MaterialStatePropertyAll(
                //     TextStyle(color: ColorConfig.WHITE)),
                // side: const MaterialStatePropertyAll(
                //     BorderSide(color: ColorConfig.WHITE)),
                // backgroundColor:
                //     const MaterialStatePropertyAll(Colors.transparent),
                // shape: const MaterialStatePropertyAll(CircleBorder()),
              ),
            )
          : widget.title ?? Text("appName".tr),
      centerTitle: widget.centerTitle,
      actions: [
        if (widget.searchButton && !widget.search ||
            (widget.search && (!widget.searchEnable && !_search)))
          IconButton(
              splashRadius: 25,
              onPressed: () {
                if (widget.searchButton && !widget.search) {
                  Get.to(() => const SearchPage(),
                      transition: Transition.upToDown,
                      duration: const Duration(milliseconds: 400));
                } else {
                  setState(() => _search = true);
                }
              },
              icon: const Icon(Icons.search)),
        const FavoriteButton(),
        const CartButton(),
        IconButton(
            splashRadius: 25,
            onPressed: () => Get.to(() => const SettingsPage(),
                transition: Transition.upToDown,
                duration: const Duration(milliseconds: 400)),
            icon: const Icon(Icons.settings))
        // PopupMenuButton(
        //   splashRadius: 25,
        //   color: ColorConfig.WHITE,
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        //   offset: const Offset(0, 40),
        //   itemBuilder: (context) => [
        //     PopupMenuItem(
        //       child: const Text("settings"),
        //       onTap: () => Get.to(() => const SettingsPage()),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
