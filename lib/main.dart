import 'package:flutter/material.dart';
import 'package:imoveis_app/app/splash_page.dart';
import 'package:imoveis_app/controllers/authentication_controller.dart';
import 'package:imoveis_app/controllers/filter_announcements_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthenticationController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FilterAnnouncementsController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          cardTheme: const CardTheme(
              surfaceTintColor: Colors.white, color: Colors.white),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey.shade100),
      home: const SplashPage(),
    );
  }
}
