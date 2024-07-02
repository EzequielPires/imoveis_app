import 'package:flutter/material.dart';
import 'package:imoveis_app/app/app_page.dart';
import 'package:imoveis_app/app/signin/signin_account_page.dart';
import 'package:imoveis_app/app/signup/signup_page.dart';
import 'package:imoveis_app/widgets/buttons/button_outlined.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset('assets/interior.jpg', fit: BoxFit.cover, width: double.infinity,),),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ButtonPrimary(title: 'Entrar', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SigninAccountPage(),)),),
                const SizedBox(height: 16,),
                ButtonOutlined(title: 'Criar conta', onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage(),)),),
                const SizedBox(height: 8,),
                TextButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AppPage(),)), child: const Text('Continuar como convidado'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
