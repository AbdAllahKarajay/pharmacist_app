import 'package:pharmacist_application/core/data/models/category_model.dart';

import 'company_model.dart';

class Product{
  final int id;
  final String scientific_name;
  final String commercial_name;
  final int price;
  final CompanyModel  company;
  final CategoryModel category;

  const Product({
    required this.id,
    required this.scientific_name,
    required this.commercial_name,
    required this.company,
    required this.price,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'scientific_name': scientific_name,
      'commercial_name': commercial_name,
      'company': company,
      'price': price,
      'category': category,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      scientific_name: map['scientific_name'] as String,
      commercial_name: map['commercial_name'] as String,
      company: CompanyModel.fromMap(map['company']),
      price: map['price'] as int,
      category: CategoryModel.fromMap(map['category']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}