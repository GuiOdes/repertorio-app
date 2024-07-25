import 'package:flutter/material.dart';
import 'package:repertorio/commons/Constants.dart';

import '../commons/Builders.dart';
import '../models/MusicModel.dart';
import '../services/MusicService.dart';
import 'MusicCard.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  MusicListState createState() => MusicListState();
}

class MusicListState extends State<MusicList> {
  late List<Music> _musicList;
  List<Music> _filteredMusicList = [];

  @override
  void initState() {
    _fetchMusicList();
    super.initState();
  }

  Future<void> _fetchMusicList() async {
    try {
      final MusicService musicService = MusicService();
      final musicList = await musicService.findAllMusics();
      setState(() {
        _musicList = musicList;
        _filteredMusicList = musicList;
      });
    } catch (e) {
      print('Erro ao obter a lista de músicas: $e');
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Music> results = [];

    if (enteredKeyword.isEmpty) {
      results = _musicList;
    } else {
      results = _musicList
          .where((music) =>
              music.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredMusicList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            onChanged: (key) => _runFilter(key),
            decoration: const InputDecoration(
              labelText: 'Filtrar músicas',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _filteredMusicList.isNotEmpty ?
            ListView.builder(
                itemCount: _filteredMusicList.length,
                itemBuilder: (context, index) => MusicCard.ofMusic(_filteredMusicList[index])
            ) : Center(child: buildInfoLink('Nenhuma música encontrada.', '$apiUrl/file')),
          ),
        ],
      ),
    );
  }
}
