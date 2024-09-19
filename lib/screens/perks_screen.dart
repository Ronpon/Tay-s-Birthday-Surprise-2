// lib/screens/perks_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/perk.dart';

class PerksScreen extends StatelessWidget {
  const PerksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Perk Points: ${gameState.perkPoints}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text('Available Perks:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: gameState.predefinedPerks.length,
                itemBuilder: (context, index) {
                  final perk = gameState.predefinedPerks[index];
                  Perk? acquiredPerk;
                  try {
                    acquiredPerk = gameState.acquiredPerks.firstWhere(
                      (p) => p.name == perk.name,
                    );
                  } catch (e) {
                    acquiredPerk = null;
                  }
                  final currentLevel = acquiredPerk?.currentLevel ?? 0;
                  final canAcquire = gameState.perkPoints > 0 &&
                      gameState.level >= perk.requiredLevel &&
                      currentLevel < perk.maxLevel;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(perk.name),
                      subtitle: Text(perk.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Lv ${currentLevel}/${perk.maxLevel}',
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: canAcquire
                                ? () {
                                    gameState.acquirePerk(perk);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('${perk.name} acquired!')),
                                    );
                                  }
                                : null,
                            child: const Text('Acquire'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
