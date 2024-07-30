import 'package:flutter/material.dart';
import 'package:imoveis_app/models/dashboard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartMonthResults extends StatelessWidget {
  final Dashboard? dashboardResults;
  const ChartMonthResults({super.key, required this.dashboardResults});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Captação de Imóveis',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 200,
              child: dashboardResults != null
                  ? SfCartesianChart(
                      legend: const Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: [
                        ColumnSeries<PropertyByMonth, String>(
                          name: 'Aluguel',
                          dataSource: dashboardResults?.monthsRents ?? [],
                          xValueMapper: (PropertyByMonth data, _) =>
                              data.monthFormated,
                          yValueMapper: (PropertyByMonth data, _) =>
                              double.parse(data.count),
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                        ),
                        ColumnSeries<PropertyByMonth, String>(
                          name: 'Venda',
                          dataSource: dashboardResults?.monthsSales ?? [],
                          xValueMapper: (PropertyByMonth data, _) =>
                              data.monthFormated,
                          yValueMapper: (PropertyByMonth data, _) =>
                              double.parse(data.count),
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                        ),
                      ],
                      primaryXAxis: const CategoryAxis(
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
  }
}
