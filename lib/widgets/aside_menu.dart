import 'package:flutter/material.dart';
import 'package:imoveis_app/app_dashboard/collaborators/collaborators_page.dart';
import 'package:imoveis_app/app_dashboard/contacts/contacts_page.dart';
import 'package:imoveis_app/app_dashboard/leads/leads_page.dart';
import 'package:imoveis_app/app_dashboard/properties/properties_page.dart';
import 'package:imoveis_app/app_dashboard/reports/reports_page.dart';

class AsideMenu extends StatefulWidget {
  const AsideMenu({super.key});

  @override
  State<AsideMenu> createState() => _AsideMenuState();
}

class _AsideMenuState extends State<AsideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset(
                "assets/logo.png",
                width: 200,
              ),
            ),
          ),
          ListTile(
            title: const Text("Dashboard"),
            leading: const Icon(Icons.grid_view_outlined),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: const Text("Propriedades"),
            leading: const Icon(Icons.home_work_outlined),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PropertiesPage(),
              ),
            ),
          ),
          ListTile(
            title: const Text("Colaboradores"),
            leading: const Icon(Icons.manage_accounts_outlined),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CollaboratorsPage(),
              ),
            ),
          ),
          ListTile(
            title: const Text("Contatos"),
            leading: const Icon(Icons.person_2_outlined),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactsPage(),
              ),
            ),
          ),
          ListTile(
            title: const Text("Relatórios"),
            leading: const Icon(Icons.bar_chart_outlined),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ReportsPage(),
              ),
            ),
          ),
          ListTile(
            title: const Text("Leads"),
            leading: const Icon(Icons.trending_up_outlined),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LeadsPage(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text("Conta"),
            leading: const Icon(Icons.person_outlined),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Sair"),
            leading: const Icon(Icons.exit_to_app_outlined),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
