import 'package:flutter/material.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:imoveis_app/widgets/form_components/custom_text_field.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Minha conta',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextField(
              controller: controller,
              label: 'Nome',
              placeholder: 'Insira seu nome',
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              controller: controller,
              label: 'Email',
              placeholder: 'Insira seu email',
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              controller: controller,
              label: 'Telefone',
              placeholder: 'Insira seu telefone',
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              controller: controller,
              label: 'Documento',
              placeholder: 'Insira seu documento',
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              controller: controller,
              label: 'Creci',
              placeholder: 'Insira seu creci',
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(child: ButtonPrimary(title: 'Salvar dados', onPressed: () {},),),
    );
  }
}
