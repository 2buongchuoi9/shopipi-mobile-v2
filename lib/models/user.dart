enum Role {
  ADMIN,
  USER,
  SHOP,
  MOD,
}

class User {
  final String id;
  final String name;
  final String email;
  final String? image;
  final String? slug;
  final bool status;
  final bool verify;
  final String authType;
  final List<String> roles;
  final String? phone;
  final List<String> address;
  final List<String> followers;
  final String createdAt;
  final String? oauth2Id;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    this.slug,
    required this.status,
    required this.verify,
    required this.authType,
    required this.roles,
    this.phone,
    required this.address,
    required this.followers,
    required this.createdAt,
    this.oauth2Id,
  });

  factory User.initialUser() {
    return User(
      id: '',
      name: '',
      email: '',
      status: false,
      verify: false,
      authType: '',
      roles: [],
      address: [],
      followers: [],
      createdAt: '',
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      image: json['image'] as String?,
      slug: json['slug'] as String?,
      status: json['status'] as bool? ?? false,
      verify: json['verify'] as bool? ?? false,
      authType: json['authType'] as String? ?? '',
      roles: List<String>.from(json['roles'] ?? []),
      phone: json['phone'] as String?,
      address: List<String>.from(json['address'] ?? []),
      followers: List<String>.from(json['followers'] ?? []),
      createdAt: json['createdAt'] as String? ?? '',
      oauth2Id: json['oauth2Id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'image': image,
        'slug': slug,
        'status': status,
        'verify': verify,
        'authType': authType,
        'roles': roles,
        'phone': phone,
        'address': address,
        'followers': followers,
        'createdAt': createdAt,
        'oauth2Id': oauth2Id,
      };
}
