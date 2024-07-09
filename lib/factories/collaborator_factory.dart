import 'package:flutter/material.dart';

class CollaboratorFactory {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  List<String> focusAdType = [];
  int? type;
}