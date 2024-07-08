import 'package:flutter/material.dart';
import 'package:imoveis_app/models/lead.dart';
import 'package:imoveis_app/repositories/leads_repository.dart';
import 'package:imoveis_app/widgets/cards/card_lead.dart';

class LeadsPage extends StatefulWidget {
  const LeadsPage({super.key});

  @override
  State<LeadsPage> createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  final LeadsRepository _repository = LeadsRepository();
  List<Lead> leads = [];
  bool isLoading = true;

  loadValues() async {
    try {
      setState(() {
        isLoading = true;
      });

      var res = await _repository.find();

      setState(() {
        leads = res;
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
        title: const Text('Leads', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) => CardLead(lead: leads[index]),
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: leads.length,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add_outlined),),
    );
  }
}