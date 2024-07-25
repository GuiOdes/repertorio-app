import 'package:flutter/material.dart';
import 'package:repertorio/models/MusicModel.dart';

import '../commons/Builders.dart';

class MusicCard extends StatefulWidget {
  @override
  final ValueKey key;
  final String id;
  final String title;
  final String tonality;
  final String? letterLink;
  final String? sheetMusicLink;
  final String? videoLink;

  const MusicCard({
    required this.key,
    required this.id,
    required this.title,
    required this.tonality,
    this.letterLink,
    this.sheetMusicLink,
    this.videoLink
  });

  static ofMusic(Music music) {
    return MusicCard(
      key: ValueKey(music.id),
      id: music.id.toString(),
      title: music.name,
      tonality: music.key,
      letterLink: music.lyricsLink,
      sheetMusicLink: music.chordLink,
      videoLink: music.videoLink,
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _DropdownState();
  }
}

class _DropdownState extends State<MusicCard> {
  bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(widget.title),
            subtitle: Text('Tom: ${widget.tonality}'),
            tileColor: Colors.black12,
            trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
            onTap: () {
              setState(() {
                _isDropdownOpen = !_isDropdownOpen;
              });
            },
          ),
          if (_isDropdownOpen)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildInfoLink('Letra', widget.letterLink) ??
                        const Text("Letra indisponível"),
                    buildInfoLink('Cifra', widget.sheetMusicLink) ??
                        const Text("Cifra indisponível"),
                    buildInfoLink('Vídeo', widget.videoLink) ??
                        const Text("Vídeo indisponível"),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
