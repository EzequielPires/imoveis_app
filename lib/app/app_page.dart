import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:imoveis_app/app/announce/announce_page.dart';
import 'package:imoveis_app/app/favorites/favorites_page.dart';
import 'package:imoveis_app/app/home/home_page.dart';
import 'package:imoveis_app/app/profile/profile_page.dart';
import 'package:imoveis_app/app/search/search_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int selectedIndex = 0;
  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    FavoritesPage(),
    AnnouncePage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        indicatorColor: Colors.indigo,
        selectedIndex: selectedIndex,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 10,
        shadowColor: Colors.black54,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white,),
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search, color: Colors.white,),
            icon: Icon(Icons.search_outlined),
            label: 'Busca',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite, color: Colors.white,),
            icon: Icon(Icons.favorite_outline),
            label: 'Favoritos',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.edit, color: Colors.white,),
            icon: Icon(Icons.edit_outlined),
            label: 'Anuncie',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person, color: Colors.white,),
            icon: Icon(Icons.person_outline),
            label: 'Conta',
          ),
        ],
      ),
    );
  }
}