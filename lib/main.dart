import 'package:flutter/material.dart';
import 'package:weather_app/controllers/theme_controller.dart';
import 'package:weather_app/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeController(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeController>(context).themeData,
      home: const HomePage(),
    );
  }
}
