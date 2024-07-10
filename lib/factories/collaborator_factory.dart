import 'package:flutter/material.dart';
import 'package:imoveis_app/models/user.dart';

class CollaboratorFactory {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController typeController = TextEditingController();
  List<String> focusAdType = [];
  int? type;

  hydrate(User user) {
    type = user.role == 'realtor' ? 1 : user.role == 'realtor' ? 2 : null ;
    typeController.text = user.role == 'realtor' ? 'Corretor' : user.role == 'admin' ? 'Administrador' : '' ;
    focusAdType = user.focusAdType ?? [];
    name.text = user.name ?? '';
    phone.text = user.cellPhone ?? '';
    cpf.text = user.document ?? '';
    email.text = user.email ?? '';
  }
}