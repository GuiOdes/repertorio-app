import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget? buildInfoLink(String infoName, String? link) {
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