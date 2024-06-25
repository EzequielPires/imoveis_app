import 'package:flutter/material.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/services/api_service.dart';
import 'package:imoveis_app/widgets/cards/card_announcement.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  List<Announcement> recent = [];

  findAnnouncements() async {
    try {
      var res = await _apiService.get(
          'property?complete=true&status=disponivel',
          {'origin': 'https://imoveis.portalcatalao.com.br'});
      if (res['success']) {
        var results = res['properties'] as List;
        List<Announcement> data = results
            .map(
              (e) => Announcement.fromJson(e),
            )
            .toList();

        setState(() {
          recent = data;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    findAnnouncements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Boa tarde, Ezequiel',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Recomendados para você',
                    style: TextStyle(
                        fontSize: 36, fontWeight: FontWeight.w700, height: 1.1),
                  ),
                ],
              ),
            ),
            const Divider(
              endIndent: 20,
              indent: 20,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, right: 20, bottom: 8),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Imóveis populares',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Text('Inpirados em suas buscas'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 432,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CardAnnouncement(
                  announcement: recent[index],
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 16,
                ),
                itemCount: recent.length,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, right: 20, bottom: 8),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Imóveis recentes',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Text('Inpirados em suas buscas'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 432,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CardAnnouncement(
                  announcement: recent[index],
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 16,
                ),
                itemCount: recent.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
