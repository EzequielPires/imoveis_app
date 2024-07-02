class User {
  String? id;
  String? name;
  String? avatar;
  String? email;
  String? cellPhone;

  User({
    this.id,
    this.name,
    this.email,
    this.cellPhone,
    this.avatar
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      cellPhone: json['cell_phone'],
      avatar: json['avatar'],
    );
  }
}