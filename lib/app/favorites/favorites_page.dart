import 'package:flutter/material.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/services/api_service.dart';
import 'package:imoveis_app/widgets/cards/card_announcement_full.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final ApiService _apiService = ApiService();
  List<Announcement> announcements = [];

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
          announcements = data;
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
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Favoritos',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              'Aqui estão os imóveis que você marcou como favoritos.',
              maxLines: 2,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) =>
            CardAnnouncementFull(announcement: announcements[index]),
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: announcements.length,
      ),
    );
  }
}
