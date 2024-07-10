import 'package:imoveis_app/models/real_estate.dart';

class User {
  String? id;
  String? name;
  String? avatar;
  String? email;
  String? cellPhone;
  String? document;
  String? creci;
  bool? isGoogleAuth;
  String? idGoogle;
  RealEstate? realEstate;
  bool? isRealEstate;
  String? role;
  List<String>? focusAdType;

  User({this.id, this.name, this.email, this.cellPhone, this.avatar, this.creci, this.document, this.focusAdType, this.idGoogle, this.isGoogleAuth, this.isRealEstate, this.realEstate, this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      cellPhone: json['cellPhone'] as String?,
      document: json['document'] as String?,
      creci: json['creci'] as String?,
      isGoogleAuth: json['isGoogleAuth'] as bool?,
      idGoogle: json['idGoogle'] as String?,
      realEstate: json['realEstate'] != null
          ? RealEstate.fromJson(json['realEstate'] as Map<String, dynamic>)
          : null,
      isRealEstate: json['isRealEstate'] as bool?,
      role: json['role'] as String?,
      focusAdType: (json['focusAdType'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
    );
  }
}
