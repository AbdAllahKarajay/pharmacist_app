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
    print('attributes');
    print(map['attributes']);
    return Order(
      id: int.parse(map['id']),
      attributes: OrderAttributes.fromMap(map['attributes']),
      medicines: map['medicines'].map<OrderMedicine>((e) {
        print('e');
        print(e);
        return OrderMedicine(
          order_id: e['pivot']['order_id'],
          medicine_id: e['pivot']['medicine_id'],
          commercial_name: e['commercial_name'],
          medicine_amount: e['pivot']['medicine_amount'],
        );
      }).toList(),
    );
  }

  Order copyWith({
    int? id,
    OrderAttributes? attributes,
    List<OrderMedicine>? medicines,
  }) {
    return Order(
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      medicines: medicines ?? this.medicines,
    );
  }
}