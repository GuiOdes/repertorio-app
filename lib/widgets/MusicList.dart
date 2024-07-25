import 'package:flutter/material.dart';

import '../models/MusicModel.dart';
import '../services/MusicService.dart';
import 'MusicCard.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  MusicListState createState() => MusicListState();
}

class MusicListState extends State<MusicList> {
  List<Music> _musicList = [];
  List<Music> _filteredMusicList = [];
  bool _isLoading = true;
  final MusicService _musicService = MusicService();
  TextEditingController editingController = TextEditingController();


  @override
  void initState() {
    _fetchMusicList();
    super.initState();
  }

  Future<void> _fetchMusicList() async {
    try {
      final result = await _musicService.findAllMusics();

      setState(() {
        _musicList = result;
        _filteredMusicList = result;
      });
    } catch (e) {
      print('Erro ao obter a lista de músicas: $e');
    }

    setState(() {
      _isLoading = false;
      editingController.text = '';
    });
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

  TextField _searchField() {
    return TextField(
      onChanged: (key) => _runFilter(key),
      controller: editingController,
      decoration: const InputDecoration(
        labelText: 'Filtrar músicas',
        suffixIcon: Icon(Icons.search),
      ),
    );
  }

  ListView _buildMusicList() {
    return ListView.builder(
        itemCount: _filteredMusicList.length,
        itemBuilder: (context, index) =>
            MusicCard.ofMusic(_filteredMusicList[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _searchField(),
          const SizedBox(height: 20),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: RefreshIndicator(
                      onRefresh: _fetchMusicList, child: _buildMusicList()))
        ],
      ),
    );
  }
}
