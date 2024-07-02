import 'package:flutter/material.dart';

class CollaboratorsPage extends StatefulWidget {
  const CollaboratorsPage({super.key});

  @override
  State<CollaboratorsPage> createState() => _CollaboratorsPageState();
}

class _CollaboratorsPageState extends State<CollaboratorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Colaboradores', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add_outlined),),
    );
  }
}