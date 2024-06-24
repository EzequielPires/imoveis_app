import 'package:flutter/material.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';

class AnnouncePage extends StatefulWidget {
  const AnnouncePage({super.key});

  @override
  State<AnnouncePage> createState() => _AnnouncePageState();
}

class _AnnouncePageState extends State<AnnouncePage> {
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
              'Anuncie',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              'Aqui você pode anunciar seus imóveis.',
              maxLines: 2,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Precisa vender seu imóvel antes de adquirir um novo?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Anuncie seu imóvel e conecte-se diretamente com compradores interessados.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            ButtonPrimary(
              title: 'Anuncie',
              onPressed: () {},
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Proprietário: gerencie seu anúncio'),
            ),
          ],
        ),
      ),
    );
  }
}
