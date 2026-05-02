import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/features/timer/presentation/store/home.store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeStore store = HomeStore();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Observer(
                  builder: (context) {
                    return Text(
                      store.formattedTime,
                      style: const TextStyle(fontSize: 80),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    IconButton.filledTonal(
                      onPressed: () {
                        store.resetTimer();
                      },
                      icon: const Icon(Icons.restart_alt),
                    ),
                    Observer(
                      builder: (context) {
                        return IconButton.filled(
                          iconSize: 40,
                          padding: const EdgeInsets.all(16),
                          onPressed: () {
                            store.startTimer();
                          },
                          icon: store.isRunner
                              ? const Icon(Icons.pause)
                              : const Icon(Icons.play_arrow),
                        );
                      },
                    ),
                    IconButton.filledTonal(
                      onPressed: () {
                        store.nextTimer();
                      },
                      icon: const Icon(Icons.skip_next),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
