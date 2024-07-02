import 'package:flutter/material.dart';
import 'package:imoveis_app/app/signin/signin_account_page.dart';
import 'package:imoveis_app/controllers/authentication_controller.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscureText = true;

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Consumer<AuthenticationController>(
          builder: (context, value, child) {
            return Column(
              children: [
                const Text(
                  'Olá! Registre-se para começar!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: value.email,
                  decoration: InputDecoration(
                      label: const Text('Nome'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: value.email,
                        decoration: InputDecoration(
                            label: const Text('Telefone'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: TextFormField(
                        controller: value.email,
                        decoration: InputDecoration(
                            label: const Text('CPF'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: value.email,
                  decoration: InputDecoration(
                      label: const Text('Email'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: value.password,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    label: const Text('Senha'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: _togglePasswordView,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ButtonPrimary(
                  title: 'Continuar',
                  isLoading: value.isLoading,
                  onPressed: () => value.signin(),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Já tem uma conta?'),
                        TextButton(
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SigninAccountPage(),
                              )),
                          child: const Text('Entrar agora'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
