import 'package:flutter/material.dart';
import 'package:imoveis_app/app/announcement/update_announcement_page.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';

class SuccessCreateAnnouncement extends StatefulWidget {
  final Announcement announcement;
  const SuccessCreateAnnouncement({super.key, required this.announcement});

  @override
  State<SuccessCreateAnnouncement> createState() =>
      _SuccessCreateAnnouncementState();
}

class _SuccessCreateAnnouncementState extends State<SuccessCreateAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/success.png',
              width: 300,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Anúncio criado com sucesso.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Agora você pode adicionar as fotos do seu anúncio e informações adicionais.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),
            ButtonPrimary(
              title: 'Visualizar anúncio',
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UpdateAnnouncementPage(announcement: widget.announcement),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
