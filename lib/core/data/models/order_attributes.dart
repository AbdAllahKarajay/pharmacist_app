class OrderAttributes{
  final int pharmacist_id;
  final String status;
  final String date;
  final int paid;
  final int total_price;
  final int? warehouse_id;

  const OrderAttributes({
    required this.pharmacist_id,
    required this.status,
    required this.date,
    required this.paid,
    required this.total_price,
    this.warehouse_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'pharmacist_id': this.pharmacist_id,
      'status': this.status,
      'date': this.date,
      'paid': this.paid,
      'total_price': this.total_price,
      'warehouse_id': this.warehouse_id,
    };
  }

  factory OrderAttributes.fromMap(Map<String, dynamic> map) {
    return OrderAttributes(
      pharmacist_id: map['pharmacist_id'] as int,
      status: map['status'] as String,
      date: map['date'] as String,
      paid: map['paid'] as int,
      total_price: map['total_price'] as int,
      warehouse_id: map['warehouse_id'] as int?,
    );
  }
}