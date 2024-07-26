import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Repertório"),
      backgroundColor: Colors.blueAccent
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
