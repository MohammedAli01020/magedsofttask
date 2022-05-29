class Account {
  Account({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.updatedAt,
    required this.createdAt,
  });

  int id;
  String name;
  String email;
  String password;
  String phone;
  DateTime updatedAt;
  DateTime createdAt;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
      };
}
