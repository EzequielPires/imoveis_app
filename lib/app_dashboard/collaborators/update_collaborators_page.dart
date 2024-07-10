import 'package:flutter/material.dart';
import 'package:imoveis_app/factories/collaborator_factory.dart';
import 'package:imoveis_app/helpers/mask.dart';
import 'package:imoveis_app/models/user.dart';
import 'package:imoveis_app/widgets/buttons/button_outlined.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';

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
                TextFormField(
                  controller: _factory.name,
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
                        controller: _factory.phone,
                        inputFormatters: [phoneFormatter],
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
                        controller: _factory.cpf,
                        inputFormatters: [cpfFormatter],
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
                  controller: _factory.email,
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
                DropdownMenu(
                  controller: _factory.typeController,
                  expandedInsets: const EdgeInsets.all(0),
                  label: const Text('Tipo do colaborador'),
                  onSelected: (value) => setState(() {
                    _factory.type = value;
                  }),
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 1, label: 'Corretor'),
                    DropdownMenuEntry(value: 2, label: 'Administrador'),
                  ],
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
