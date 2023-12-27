class Order{
  final int total_price;
  final String date;
  final List<MedicineCount> medicines;

  const Order({
    required this.total_price,
    required this.date,
    required this.medicines,
  });

  Map<String, dynamic> toMap() {
    return {
      'total_price': this.total_price,
      'date': this.date,
      'medicines': this.medicines,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      total_price: map['total_price'] as int,
      date: map['date'] as String,
      medicines: map['medicines'].map<MedicineCount>((e) => MedicineCount.fromMap(e)).toList(),
    );
  }
}

class MedicineCount{
  final int id;
  final int medicine_amount;

  const MedicineCount({
    required this.id,
    required this.medicine_amount,
  });

  factory MedicineCount.fromMap(Map<String, dynamic> map) {
    return MedicineCount(
      id: map['id'] as int,
      medicine_amount: map['medicine_amount'] as int,
    );
  }
}