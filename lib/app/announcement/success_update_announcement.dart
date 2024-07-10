import 'package:flutter/material.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';

class SuccessUpdateAnnouncement extends StatefulWidget {
  final Announcement announcement;
  const SuccessUpdateAnnouncement({super.key, required this.announcement});

  @override
  State<SuccessUpdateAnnouncement> createState() =>
      _SuccessUpdateAnnouncementState();
}

class _SuccessUpdateAnnouncementState extends State<SuccessUpdateAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
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
                'Anúncio atualizado com sucesso.',
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
                title: 'Visualizar anúncios',
                onPressed: () => Navigator.pop(
                  context,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
