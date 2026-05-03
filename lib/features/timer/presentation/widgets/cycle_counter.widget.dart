import 'package:flutter/material.dart';

class CycleCounter extends StatelessWidget {
  final int cycleCount;

  const CycleCounter({super.key, required this.cycleCount});

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: const IconThemeData(color: Colors.black54, size: 15),
      child: Row(
        spacing: 3,
        children: [
          ...List.generate(4, (index) {
            return cycleCount > (index)
                ? Icon(
                    Icons.circle,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : const Icon(Icons.circle);
          }),
          const SizedBox(width: 15),
          ...List.generate(4, (index) {
            return cycleCount > (index + 4)
                ? Icon(
                    Icons.circle,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : const Icon(Icons.circle);
          }),
        ],
      ),
    );
  }
}
