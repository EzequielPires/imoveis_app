import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:imoveis_app/app_dashboard/account/account_page.dart';
import 'package:imoveis_app/controllers/menu_app_controller.dart';
import 'package:imoveis_app/models/dashboard.dart';
import 'package:imoveis_app/repositories/dashboard_repository.dart';
import 'package:imoveis_app/widgets/aside_menu.dart';
import 'package:imoveis_app/widgets/dashboard_components/chart_adtype_results.dart';
import 'package:imoveis_app/widgets/dashboard_components/chart_month_results.dart';
import 'package:imoveis_app/widgets/dashboard_components/chart_type_results.dart';
import 'package:imoveis_app/widgets/dashboard_components/last_announcements.dart';
import 'package:imoveis_app/widgets/dashboard_components/last_leads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardRepository _repository = DashboardRepository();
  Dashboard? dashboardResults;
  bool isLoading = true;

  List<PropertyByMonth> getLastSevenMonths(List<PropertyByMonth> results) {
    List<PropertyByMonth> months = [];
    DateTime now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      DateTime month = DateTime(now.year, now.month - i, now.day);
      months.add(PropertyByMonth(
          adType: 'venda',
          count: results
              .firstWhere(
                (e) =>
                    e.month ==
                    DateFormat(
                      'yyyy-MM',
                    ).format(month),
                orElse: () =>
                    PropertyByMonth(adType: '', month: '', count: '0'),
              )
              .count,
          month: DateFormat('yyyy-MM').format(month),
          monthFormated: DateFormat('MMMM', 'pt_BR').format(month)));
    }

    return months;
  }

  loadValues() async {
    try {
      setState(() {
        isLoading = true;
      });

      var res = await _repository.find();
      if (res != null) {
        var result = Dashboard(
          monthsRents: getLastSevenMonths(res.monthsRents).reversed.toList(),
          monthsSales: getLastSevenMonths(res.monthsSales).reversed.toList(),
          types: res.types,
          leads: res.leads,
          announcements: res.announcements,
        );

        setState(() {
          dashboardResults = result;
        });
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = dashboardResults?.monthsRents[0].monthFormated ?? '';
        break;
      case 1:
        text = dashboardResults?.monthsRents[1].monthFormated ?? '';
        break;
      case 2:
        text = dashboardResults?.monthsRents[2].monthFormated ?? '';
        break;
      case 3:
        text = dashboardResults?.monthsRents[3].monthFormated ?? '';
        break;
      case 4:
        text = dashboardResults?.monthsRents[4].monthFormated ?? '';
        break;
      case 5:
        text = dashboardResults?.monthsRents[5].monthFormated ?? '';
        break;
      case 6:
        text = dashboardResults?.monthsRents[6].monthFormated ?? '';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  @override
  void initState() {
    loadValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: const AsideMenu(),
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
          title: const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {},
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: IconButton(
                icon: const Icon(Icons.person_outline),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AccountPage(),
                    )),
              ),
            ),
          ]),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ChartMonthResults(
                dashboardResults: dashboardResults,
              ),
              const SizedBox(
                height: 16,
              ),
              LastAnnouncements(dashboardResults: dashboardResults),
              ChartTypeResults(dashboardResults: dashboardResults),
              const SizedBox(
                height: 16,
              ),
              ChartAdTypeResults(dashboardResults: dashboardResults),
              const SizedBox(
                height: 16,
              ),
              LastLeads(dashboardResults: dashboardResults),
            ],
          )),
    );
  }
}
