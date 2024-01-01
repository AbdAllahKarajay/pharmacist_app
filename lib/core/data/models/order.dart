import 'order_attributes.dart';
import 'order_medicine.dart';

class Order{
  final int id;
  final OrderAttributes attributes;
  final List<OrderMedicine> medicines;

  const Order({
    required this.id,
    required this.attributes,
    required this.medicines,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'attributes': attributes,
      'medicines': medicines,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: int.parse(map['id']),
      attributes: OrderAttributes.fromMap(map['attributes']),
      medicines: map['medicines'].map<OrderMedicine>((e) => OrderMedicine.fromMap(e)).toList(),
    );
  }
}