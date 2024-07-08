import 'package:flutter/material.dart';
import 'package:imoveis_app/app_dashboard/collaborators/create_collaborators_page.dart';
import 'package:imoveis_app/models/user.dart';
import 'package:imoveis_app/repositories/collaborators_repository.dart';
import 'package:imoveis_app/widgets/cards/card_collaborator.dart';
import 'package:imoveis_app/widgets/realtor_wrapper.dart';

class CollaboratorsPage extends StatefulWidget {
  const CollaboratorsPage({super.key});

  @override
  State<CollaboratorsPage> createState() => _CollaboratorsPageState();
}

class _CollaboratorsPageState extends State<CollaboratorsPage> {
  final CollaboratorsRepository _repository = CollaboratorsRepository();
  List<User> users = [];
  bool isLoading = true;

  loadValues() async {
    try {
      setState(() {
        isLoading = true;
      });

      var res = await _repository.find();

      setState(() {
        users = res;
      });
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    loadValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Colaboradores',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) => CardCollaborator(collaborator: users[index]),
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: users.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateCollaboratorsPage(),)),
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
