import 'package:flutter/material.dart';
import 'package:imoveis_app/app/announcement/create_announcement_page.dart';
import 'package:imoveis_app/controllers/authentication_controller.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/repositories/announcements_repository.dart';
import 'package:imoveis_app/widgets/cards/card_announcement_dashboard.dart';
import 'package:provider/provider.dart';

class PropertiesPage extends StatefulWidget {
  const PropertiesPage({super.key});

  @override
  State<PropertiesPage> createState() => _PropertiesPageState();
}

class _PropertiesPageState extends State<PropertiesPage> {
  late AuthenticationController _controller;
  final AnnouncementsRepository _repository = AnnouncementsRepository();
  List<Announcement> announcements = [];
  bool isLoading = true;

  loadValues() async {
    try {
      setState(() {
        isLoading = true;
      });

      var res = await _repository.find(QueryAnnouncement(realEstateId: _controller.realEstate?.id,), _controller.accessToken);

      setState(() {
        announcements = res;
      });
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
    _controller = context.read<AuthenticationController>();
    loadValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Propriedades',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.tune_outlined))],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) => CardAnnouncementDashboard(announcement: announcements[index]),
        itemCount: announcements.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16,),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateAnnouncementPage(),
            )),
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
