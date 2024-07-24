import 'package:flutter/material.dart';

import '../models/MusicModel.dart';
import '../services/MusicService.dart';
import 'MusicCard.dart';

class MusicList extends StatelessWidget {
  const MusicList({super.key});

  Future<List<Music>> _fetchMusicList() async {
    try {
      final MusicService musicService = MusicService();
      return await musicService.findAllMusics();
    } catch (e) {
      print('Erro ao obter a lista de músicas: $e');
      return []; // Retorne uma lista vazia ou trate o erro de forma adequada.
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Music>>(
      future: _fetchMusicList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro ao carregar músicas: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Nenhuma música encontrada.');
        } else {
          final musicList = snapshot.data!;
          return ListView.builder(
            itemCount: musicList.length,
            itemBuilder: (context, index) {
              final music = musicList[index];
              return MusicCard(
                title: music.name,
                tonality: music.key,
                letterLink: music.lyricsLink,
                sheetMusicLink: music.chordLink,
                videoLink: music.videoLink,
              );
            },
          );
        }
      },
    );
  }
}