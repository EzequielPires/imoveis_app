import 'package:flutter/material.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';

class CreateCollaboratorsPage extends StatefulWidget {
  const CreateCollaboratorsPage({super.key});

  @override
  State<CreateCollaboratorsPage> createState() =>
      _CreateCollaboratorsPageState();
}

class _CreateCollaboratorsPageState extends State<CreateCollaboratorsPage> {
  handleSubmit() async {

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Cadastrar colaborador',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                label: Text('Nome'),
                hintText: 'Insira o nome completo',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      label: Text('Telefone'),
                      hintText: 'Insira o telefone pra contato',
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      label: Text('CPF'),
                      hintText: 'Insira o CPF',
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                label: Text('Email'),
                hintText: 'Insira o email',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                label: Text('Senha'),
                hintText: 'Insira a senha',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const DropdownMenu(
              expandedInsets: EdgeInsets.all(0),
              label: Text('Tipo do colaborador'),
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 1, label: 'Corretor'),
                DropdownMenuEntry(value: 2, label: 'Administrador'),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: false,
              title: const Text('Venda de imóveis'),
              onChanged: (value) {
              },
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: false,
              title: const Text('Locação de imóveis'),
              onChanged: (value) {
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ButtonPrimary(
          title: 'Salvar imóvel',
          onPressed: handleSubmit,
        ),
      ),
    );
  }
}
