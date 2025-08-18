class UserModel {
  final String psid;
  final String email;
  final String name;
  final bool? isAdmin;
  final String password;

  UserModel({
    required this.psid,
    required this.email,
    required this.name,
    this.isAdmin,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        psid: json['psid']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        isAdmin: json['isAdmin'] != null
            ? (json['isAdmin'] == 1 || json['isAdmin'] == true)
            : (json['isAdmin'] ?? false),
        password: json['password']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        'psid': psid,
        'email': email,
        'name': name,
        'isAdmin': isAdmin,
        'password': password,
      };

  Map<String, dynamic> toSafeJson() => {
        'psid': psid,
        'email': email,
        'name': name,
        'isAdmin': isAdmin,
      };

  UserModel copyWith({
    String? psid,
    String? email,
    String? name,
    bool? isAdmin,
    String? password,
  }) {
    return UserModel(
      psid: psid ?? this.psid,
      email: email ?? this.email,
      name: name ?? this.name,
      isAdmin: isAdmin ?? this.isAdmin,
      password: password ?? this.password,
    );
  }
}
