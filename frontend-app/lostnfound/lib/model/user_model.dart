class UserModel {
  final String psid;
  final String email;
  final String name;
  final bool isAdmin;
  final String password; 

  UserModel({
    required this.psid,
    required this.email,
    required this.name,
    required this.isAdmin,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        psid: json['psid'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        isAdmin: (json['isAdmin'] as bool?) ?? false,
        password: json['password'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'psid': psid,
        'email': email,
        'name': name,
        'isAdmin': isAdmin,
        'password': password, // server expects it on signup
      };

  // For storing without password:
  Map<String, dynamic> toSafeJson() => {
        'psid': psid,
        'email': email,
        'name': name,
        'isAdmin': isAdmin,
      };
}
