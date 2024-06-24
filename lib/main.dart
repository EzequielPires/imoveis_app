import 'package:flutter/material.dart';
import 'package:imoveis_app/controllers/filter_announcements_controller.dart';
import 'package:imoveis_app/routes.g.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
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
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          cardTheme: const CardTheme(
              surfaceTintColor: Colors.white, color: Colors.white),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey.shade100),
      routerConfig: Routefly.routerConfig(
        routes: routes, // GENERATED
      ),
    );
  }
}
