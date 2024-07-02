import 'package:flutter/material.dart';

class LeadsPage extends StatefulWidget {
  const LeadsPage({super.key});

  @override
  State<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Leads', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add_outlined),),
    );
  }
}