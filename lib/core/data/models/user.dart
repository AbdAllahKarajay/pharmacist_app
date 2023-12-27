class User{
  // final String id;
  final String token;
  // final String phone;


  const User({
    required this.token,
    // required this.id,
    // required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'token': token,
      // 'phone': phone,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      // id: map['id'] as String,
      token: map['token'] as String,
      // phone: map['phone'] as String,
    );
  }
}