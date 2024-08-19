class Address {
  final String phone;
  final String name;
  final bool isDefault;
  final String province;
  final String district;
  final String address;

  Address({
    required this.phone,
    required this.name,
    required this.isDefault,
    required this.province,
    required this.district,
    required this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      phone: json['phone'] as String,
      name: json['name'] as String,
      isDefault: json['isDefault'] as bool,
      province: json['province'] as String,
      district: json['district'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'name': name,
      'isDefault': isDefault,
      'province': province,
      'district': district,
      'address': address,
    };
  }
}
