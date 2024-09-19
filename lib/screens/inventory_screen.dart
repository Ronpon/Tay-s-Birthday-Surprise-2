// lib/screens/inventory_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/item.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  void useItem(BuildContext context, GameState gameState, Item item) {
    // Use the item via GameState
    gameState.useItem(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} used!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: gameState.inventory.isEmpty
          ? const Center(child: Text('No items in inventory.'))
          : ListView.builder(
              itemCount: gameState.inventory.length,
              itemBuilder: (context, index) {
                Item item = gameState.inventory[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.description),
                  trailing: ElevatedButton(
                    onPressed: () {
                      useItem(context, gameState, item);
                    },
                    child: const Text('Use'),
                  ),
                );
              },
            ),
    );
  }
}
