
class Music {
  final int id;
  final String name;
  final String key;
  final String? chordLink;
  final String? lyricsLink;
  final String? videoLink;
  final String capo;

  Music({
    required this.id,
    required this.name,
    required this.key,
    this.chordLink,
    this.lyricsLink,
    this.videoLink,
    required this.capo,
  });

  static Music fromJson(Map<String, dynamic> jsonItem) {
    return Music(
      id: jsonItem['id'],
      name: jsonItem['name'],
      key: jsonItem['key'],
      chordLink: jsonItem['chordLink'],
      lyricsLink: jsonItem['lyricsLink'],
      videoLink: jsonItem['videoLink'],
      capo: jsonItem['capo'],
    );
  }
}
