import 'package:flutter/material.dart';
import 'package:imoveis_app/models/dashboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartAdTypeResults extends StatelessWidget {
  final Dashboard? dashboardResults;
  const ChartAdTypeResults({super.key, required this.dashboardResults});

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
              'Imóveis por finalidade',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 200,
              child: dashboardResults != null
                  ? SfCircularChart(
                      legend: const Legend(isVisible: true),
                      series: <CircularSeries>[
                        PieSeries<Results, String>(
                          dataSource: getData(dashboardResults!),
                          xValueMapper: (Results data, _) => data.label,
                          yValueMapper: (Results data, _) =>
                              data.count,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                        ),
                      ],
                    )
                  : null,
            )
          ],
        ),
      ),
    );
  }
}

class Results {
  String label;
  int count;

  Results({required this.count, required this.label});
}

List<Results> getData(Dashboard dashboard) {
  
  var totalRent = 0;
  var totalSale = 0;

  dashboard.types.forEach((e) {
    totalSale = totalSale + int.parse(e.totalSale);
    totalRent = totalRent + int.parse(e.totalRent);
  });

  List<Results> results = [
    Results(
      count: totalRent,
      label: 'Aluguel',
    ),
    Results(
      count: totalSale,
      label: 'Venda',
    ),
  ];

  return results;
}
