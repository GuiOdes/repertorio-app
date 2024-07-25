import 'package:flutter/material.dart';
import 'package:repertorio/models/MusicModel.dart';
import 'package:repertorio/services/MusicService.dart';
import 'package:repertorio/widgets/CustomAppBar.dart';
import 'package:repertorio/widgets/MusicCard.dart';
import 'package:repertorio/widgets/MusicList.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        appBar: CustomAppBar(),
        body: MusicList()
      ),
    );
  }
}
