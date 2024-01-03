class OrderMedicine{
  final int order_id;
  final int medicine_id;
  final String commercial_name;
  final int medicine_amount;

  Map<String, dynamic> toMap() {
    return {
      'order_id': order_id,
      'medicine_id': medicine_id,
      'medicine_commercial_name': commercial_name,
      'medicine_amount': medicine_amount,
    };
  }

  factory OrderMedicine.fromMap(Map<String, dynamic> map) {
    return OrderMedicine(
      order_id: map['order_id'] as int,
      medicine_id: map['medicine_id'] as int,
      commercial_name: map['commercial_name'] as String,
      medicine_amount: map['medicine_amount'] as int,
    );
  }

  const OrderMedicine({
    required this.order_id,
    required this.medicine_id,
    required this.commercial_name,
    required this.medicine_amount,
  });
}