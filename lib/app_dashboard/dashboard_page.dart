import 'package:flutter/material.dart';
import 'package:imoveis_app/controllers/menu_app_controller.dart';
import 'package:imoveis_app/widgets/aside_menu.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
              onPressed: () {},
            ),
          ),
        ]
      ),
    );
  }
}