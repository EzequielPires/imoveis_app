import 'package:flutter/material.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
              'Conta',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              'Aqui você pode editar seus dados.',
              maxLines: 2,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(24),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(),
                  Center(
                    child: Image.asset(
                      'assets/logo.png',
                      width: 164,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Acesse sua conta ou cadastre-se para favoritar e criar alertas.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ButtonPrimary(
                    title: 'Entrar',
                    onPressed: () {},
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Buscas salvas e alertas'),
                    trailing: const Icon(Icons.chevron_right),
                    iconColor: Colors.indigo,
                    onTap: () {},
                  ),
                  Divider(color: Colors.grey[200],),
                  ListTile(
                    title: const Text('Avaliar anunciantes'),
                    trailing: const Icon(Icons.chevron_right),
                    iconColor: Colors.indigo,
                    onTap: () {},
                  ),
                  Divider(color: Colors.grey[200],),
                  ListTile(
                    title: const Text('Central de ajuda'),
                    trailing: const Icon(Icons.chevron_right),
                    iconColor: Colors.indigo,
                    onTap: () {},
                  ),
                  Divider(color: Colors.grey[200],),
                  ListTile(
                    title: const Text('Institucional'),
                    trailing: const Icon(Icons.chevron_right),
                    iconColor: Colors.indigo,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Termos de uso'),
                    trailing: const Icon(Icons.chevron_right),
                    iconColor: Colors.indigo,
                    onTap: () {},
                  ),
                  Divider(color: Colors.grey[200],),
                  ListTile(
                    title: const Text('Política de privacidade'),
                    trailing: const Icon(Icons.chevron_right),
                    iconColor: Colors.indigo,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
