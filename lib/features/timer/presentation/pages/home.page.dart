import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('25:00', style: TextStyle(fontSize: 80)),
                IconButton.filled(
                  iconSize: 40,
                  padding: const EdgeInsets.all(16),
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
