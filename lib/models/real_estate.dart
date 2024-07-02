class RealEstate {
  String? id;
  String? name;
  String? logo;
  String? email;
  String? cellPhone;

  RealEstate({
    this.id,
    this.name,
    this.email,
    this.logo,
    this.cellPhone,
  });

  factory RealEstate.fromJson(Map<String, dynamic> json) {
    return RealEstate(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      logo: json['logo'],
      cellPhone: json['cellPhone'],
    );
  }
}