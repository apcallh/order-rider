class UserProfile {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? avatarPath;
  final String? carNumber;
  final String? carType;
  final String? fuelType;
  final double fuelEfficiency;
  final double fuelPrice;
  final String currency;

  const UserProfile({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.avatarPath,
    this.carNumber,
    this.carType,
    this.fuelType,
    this.fuelEfficiency = 11.5,
    this.fuelPrice = 2.0,
    this.currency = 'QAR',
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatarPath,
    String? carNumber,
    String? carType,
    String? fuelType,
    double? fuelEfficiency,
    double? fuelPrice,
    String? currency,
  }) =>
      UserProfile(
        id: id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        avatarPath: avatarPath ?? this.avatarPath,
        carNumber: carNumber ?? this.carNumber,
        carType: carType ?? this.carType,
        fuelType: fuelType ?? this.fuelType,
        fuelEfficiency: fuelEfficiency ?? this.fuelEfficiency,
        fuelPrice: fuelPrice ?? this.fuelPrice,
        currency: currency ?? this.currency,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'avatar_path': avatarPath,
        'car_number': carNumber,
        'car_type': carType,
        'fuel_type': fuelType,
        'fuel_efficiency': fuelEfficiency,
        'fuel_price': fuelPrice,
        'currency': currency,
      };

  factory UserProfile.fromJson(Map<String, dynamic> j) => UserProfile(
        id: j['id'] as String,
        name: j['name'] as String,
        email: j['email'] as String?,
        phone: j['phone'] as String?,
        avatarPath: j['avatar_path'] as String?,
        carNumber: j['car_number'] as String?,
        carType: j['car_type'] as String?,
        fuelType: j['fuel_type'] as String?,
        fuelEfficiency: (j['fuel_efficiency'] as num?)?.toDouble() ?? 11.5,
        fuelPrice: (j['fuel_price'] as num?)?.toDouble() ?? 2.0,
        currency: j['currency'] as String? ?? 'QAR',
      );
}
