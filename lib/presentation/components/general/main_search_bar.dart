import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacist_application/core/util/theme.dart';

import '../../../core/util/palette.dart';

class MainSearchBar extends StatefulWidget {
  const MainSearchBar(
      {Key? key,
      required this.controller,
      required this.onCancel,
      this.onChanged})
      : super(key: key);
  final void Function(String)? onChanged;
  final void Function() onCancel;
  final TextEditingController controller;

  @override
  State<MainSearchBar> createState() => _MainSearchBarState();
}

class _MainSearchBarState extends State<MainSearchBar> {
  String oldValue = "";

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: widget.controller,
      hintText: "search".tr,
      onChanged: (value) {
        if (value.isEmpty != oldValue.isEmpty) {
          setState(() {});
        }
        oldValue = value;
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
        if (value.isEmpty) {
          widget.onCancel();
        }
      },
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      trailing: widget.controller.text.isEmpty
          ? []
          : [
              IconButton(
                splashRadius: 20,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    widget.controller.clear();
                    oldValue = "";
                    widget.onCancel();
                    setState(() {});
                  })
            ],
      leading: const Icon(Icons.search, size: 30),
      padding:
          const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12)),
      backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
      side: MaterialStatePropertyAll(
        BorderSide(
          color: Theme.of(context).isDark
              ? ColorConfig.DARK_FieldBorder
              : ColorConfig.FieldBorder,
          width: 2,
        ),
      ),
      elevation: const MaterialStatePropertyAll(0),
    );
  }
}
