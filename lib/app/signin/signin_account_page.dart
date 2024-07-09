import 'package:flutter/material.dart';
import 'package:imoveis_app/app/signup/signup_page.dart';
import 'package:imoveis_app/controllers/authentication_controller.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:provider/provider.dart';

class SigninAccountPage extends StatefulWidget {
  const SigninAccountPage({super.key});

  @override
  State<SigninAccountPage> createState() => _SigninAccountPageState();
}

class _SigninAccountPageState extends State<SigninAccountPage> {
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
      body: Center(
        child: Container(
            alignment: Alignment.topCenter,
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(20),
            child: Consumer<AuthenticationController>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    const Text(
                      'Bem vindo de volta! Que bom ver você, de novo!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 32,
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: const Text(
                          'Esqueceu sua senha?',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ButtonPrimary(
                      title: 'Entrar',
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
                            const Text('Não tem uma conta?'),
                            TextButton(
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupPage(),
                                  )),
                              child: const Text('Registre agora'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
