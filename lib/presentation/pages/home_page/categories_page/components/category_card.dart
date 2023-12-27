import 'package:flutter/material.dart';

import '../../../../../core/data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.category, required this.onTap})
      : super(key: key);
  final CategoryModel category;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).cardTheme.color,
        ),
        child: Center(child: Text(category.name)),
      ),
    );
  }
}
