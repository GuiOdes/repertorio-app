import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MusicCard extends StatefulWidget {
  final String title;
  final String tonality;
  final String? letterLink;
  final String? sheetMusicLink;
  final String? videoLink;

  const MusicCard({
    super.key,
    required this.title,
    required this.tonality,
    this.letterLink,
    this.sheetMusicLink,
    this.videoLink
  });

  @override
  State<StatefulWidget> createState() {
    return _DropdownState(title, tonality, letterLink, sheetMusicLink, videoLink);
  }
}

class _DropdownState extends State<MusicCard> {
  final String title;
  final String tonality;
  final String? letterLink;
  final String? sheetMusicLink;
  final String? videoLink;

  bool _isDropdownOpen = false;

  _DropdownState(this.title, this.tonality, this.letterLink,
      this.sheetMusicLink, this.videoLink);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(title),
            subtitle: Text('Tom: $tonality'),
            tileColor: Colors.black12,
            trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
            onTap: () {
              setState(() {
                _isDropdownOpen = !_isDropdownOpen;
                print("$title $_isDropdownOpen");
              });
            },
          ),
          if (_isDropdownOpen)
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildInfoLink('Letra', letterLink) ?? const Text("Letra indisponível"),
                    _buildInfoLink('Cifra', sheetMusicLink) ?? const Text("Cifra indisponível"),
                    _buildInfoLink('Vídeo', videoLink) ?? const Text("Vídeo indisponível"),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget? _buildInfoLink(String infoName, String? link) {
  if (link == null) {
    return null;
  }

  return InkWell(
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(infoName),
    ),
    onTap: () {
      launchUrl(Uri.parse(link));
    },
  );
}
