import 'package:flutter/material.dart';
import 'package:imoveis_app/app/app_page.dart';
import 'package:imoveis_app/app/signin/signin_page.dart';
import 'package:imoveis_app/controllers/authentication_controller.dart';
import 'package:imoveis_app/models/user.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final AuthenticationController _authenticationController;

  void authListene() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    var userState = _authenticationController.userState;
    var user = _authenticationController.user;
    handleRoute(userState, user);
  }

  handleRoute(UserState userState, User? user) {
    if (userState == UserState.logged) {
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const AppPage(),
          ),
        );
      }
    } else if (userState == UserState.loggedOut) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SigninPage(),
        ),
      );
    }
  }

  @override
  void initState() {
    _authenticationController = context.read<AuthenticationController>();
    _authenticationController.loadUser();
    _authenticationController.addListener(authListene);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/logo.png')),
    );
  }
}
