import 'package:flutter/material.dart';
import 'package:imoveis_app/controllers/filter_announcements_controller.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/models/property_type.dart';
import 'package:imoveis_app/services/api_service.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:imoveis_app/widgets/cards/card_announcement_full.dart';
import 'package:imoveis_app/widgets/custom_dialog_filter.dart';
import 'package:imoveis_app/widgets/form_components/select_city.dart';
import 'package:imoveis_app/widgets/form_components/select_district.dart';
import 'package:imoveis_app/widgets/form_components/select_state.dart';
import 'package:imoveis_app/widgets/form_components/select_type.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiService _apiService = ApiService();
  List<Announcement> announcements = [];
  AnnouncementQuery query = AnnouncementQuery();
  bool isLoading = true;

  findAnnouncements(AnnouncementQuery? queryData) async {
    try {
      setState(() {
        query = queryData ?? AnnouncementQuery();
        isLoading = true;
      });

      var res = await _apiService.get(
          'property?complete=true&status=disponivel${queryData.toString() != 'null' ? queryData.toString() : ''}',
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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    findAnnouncements(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Encontre seu imóvel ideal',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              query.toFilterContent(),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CustomDialogFilter(
                  onSelected: (query) => findAnnouncements(query),
                ),
              );
            },
            icon: const Icon(Icons.tune_outlined),
          ),
        ],
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
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
