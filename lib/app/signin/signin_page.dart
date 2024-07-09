import 'package:flutter/material.dart';
import 'package:imoveis_app/app/app_page.dart';
import 'package:imoveis_app/app/signin/signin_account_page.dart';
import 'package:imoveis_app/app/signin/signin_account_real_estate_page.dart';
import 'package:imoveis_app/app/signup/signup_page.dart';
import 'package:imoveis_app/app/signup/signup_real_estate_page.dart';
import 'package:imoveis_app/widgets/buttons/button_outlined.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              'assets/interior.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.topCenter,
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TabBar(controller: _tabController, tabs: const [
                    Tab(
                      child: Text('Área do cliente'),
                    ),
                    Tab(
                      child: Text('Área da imobiliária'),
                    ),
                  ]),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 200,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Column(
                          children: [
                            ButtonPrimary(
                              title: 'Entrar',
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SigninAccountPage(),
                                  )),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ButtonOutlined(
                              title: 'Criar conta',
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupPage(),
                                  )),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextButton(
                                onPressed: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AppPage(),
                                    )),
                                child: const Text('Continuar como convidado'))
                          ],
                        ),
                        Column(
                          children: [
                            ButtonPrimary(
                              title: 'Entrar',
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SigninAccountRealEstatePage(),
                                  )),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ButtonOutlined(
                              title: 'Criar conta',
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SignupRealEstatePage(),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
