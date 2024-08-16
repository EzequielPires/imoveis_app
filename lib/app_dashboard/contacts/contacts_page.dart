import 'package:flutter/material.dart';
import 'package:imoveis_app/app_dashboard/contacts/create_contact_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Contatos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateContactPage(),)), child: const Icon(Icons.add_outlined),),
    );
  }
}