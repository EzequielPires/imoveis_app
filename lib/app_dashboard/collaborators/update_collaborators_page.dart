import 'package:flutter/material.dart';
import 'package:imoveis_app/factories/collaborator_factory.dart';
import 'package:imoveis_app/helpers/mask.dart';
import 'package:imoveis_app/models/user.dart';
import 'package:imoveis_app/widgets/buttons/button_outlined.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:imoveis_app/widgets/form_components/custom_dropdown.dart';
import 'package:imoveis_app/widgets/form_components/custom_text_field.dart';

class UpdateCollaboratorsPage extends StatefulWidget {
  final User user;
  const UpdateCollaboratorsPage({super.key, required this.user});

  @override
  State<UpdateCollaboratorsPage> createState() =>
      _UpdateCollaboratorsPageState();
}

class _UpdateCollaboratorsPageState extends State<UpdateCollaboratorsPage> {
  final CollaboratorFactory _factory = CollaboratorFactory();

  handleSubmit() async {}

  @override
  void initState() {
    _factory.hydrate(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Atualizar colaborador',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                CustomTextField(
                  controller: _factory.name,
                  label: 'Nome',
                  placeholder: 'Insira o nome completo',
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _factory.phone,
                        label: 'Telefone',
                        placeholder: 'Insira o telefone pra contato',
                        inputFormatters: [phoneFormatter],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: _factory.cpf,
                        label: 'CPF',
                        placeholder: 'Insira o CPF',
                        inputFormatters: [cpfFormatter],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: _factory.email,
                  label: 'Email',
                  placeholder: 'Insira o email',
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomDropdown(
                  controller: _factory.typeController,
                  label: 'Tipo do colaborador',
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 1, label: 'Corretor'),
                    DropdownMenuEntry(value: 2, label: 'Administrador'),
                  ],
                  onSelected: (value) => setState(() {
                    _factory.type = value;
                  }),
                ),
                const SizedBox(
                  height: 16,
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _factory.focusAdType.contains('venda'),
                  title: const Text('Venda de imóveis'),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _factory.focusAdType.add('venda');
                      } else {
                        _factory.focusAdType.remove('venda');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _factory.focusAdType.contains('aluguel'),
                  title: const Text('Locação de imóveis'),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _factory.focusAdType.add('aluguel');
                      } else {
                        _factory.focusAdType.remove('aluguel');
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ButtonOutlined(
                  title: 'Atualizar senha',
                  onPressed: () {},
                ),
              ],
            ),
          ),
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
