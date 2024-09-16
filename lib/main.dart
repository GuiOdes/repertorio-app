import 'package:flutter/material.dart';
import 'package:repertorio/models/MusicModel.dart';
import 'package:repertorio/pages/LoginPage.dart';
import 'package:repertorio/services/MusicService.dart';
import 'package:repertorio/pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<List<Music>> musicList() async {
    try {
      final MusicService musicService = MusicService();
      return await musicService.findAllMusics();
    } catch (e) {
      print('Erro ao obter a lista de músicas: $e');
      return [];
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Repertório',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 21),
            backgroundColor: Colors.deepOrange,
        )),
      ),
      home: const LoginPage(),
    );
  }
}
