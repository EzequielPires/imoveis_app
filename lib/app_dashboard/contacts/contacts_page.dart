import 'package:flutter/material.dart';

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
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add_outlined),),
    );
  }
}