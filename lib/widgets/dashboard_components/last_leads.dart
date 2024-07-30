import 'package:flutter/material.dart';
import 'package:imoveis_app/models/dashboard.dart';
import 'package:imoveis_app/widgets/cards/card_lead.dart';

class LastLeads extends StatelessWidget {
  final Dashboard? dashboardResults;
  const LastLeads({super.key, required this.dashboardResults});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Últimos contatos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: dashboardResults?.leads != null
                  ? dashboardResults!.leads
                      .map((e) => CardLead(lead: e))
                      .toList()
                  : [],
            ),
          ],
        ),
      ),
    );
  }
}
