import 'package:flutter/material.dart';
import 'package:imoveis_app/models/dashboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartTypeResults extends StatelessWidget {
  final Dashboard? dashboardResults;
  const ChartTypeResults({super.key, required this.dashboardResults});

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
              'Imóveis por tipo',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 200,
              child: dashboardResults != null
                  ? SfCircularChart(
                      legend: const Legend(isVisible: true),
                      series: <CircularSeries>[
                        PieSeries<PropertyByType, String>(
                          dataSource: dashboardResults?.types,
                          xValueMapper: (PropertyByType data, _) => data.type,
                          yValueMapper: (PropertyByType data, _) =>
                              double.parse(data.totalRent) +
                              double.parse(data.totalSale),
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
