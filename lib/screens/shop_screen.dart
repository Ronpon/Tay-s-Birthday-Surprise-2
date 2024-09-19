// lib/screens/shop_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/item.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    List<Item> items = [
      Item(
        name: 'Mesmerizer',
        price: 150,
        description:
            'Automatically win a speech check. (Single use - no wagering)',
      ),
      Item(
        name: 'Massage Coupon',
        price: 300,
        description: '15-minute massage wherever you want.',
      ),
      Item(
        name: 'Rewinder',
        price: 100,
        description: 'Redo one speech check.',
      ),
      Item(
        name: 'Dommy Mommy Wand',
        price: 200,
        description:
            'Force Jormes to do one quest (or one part of a quest) for you.',
      ),
      // Add more items if needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text('Caps: ${gameState.caps}',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Item item = items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text('${item.description}\nPrice: ${item.price} caps'),
                    isThreeLine: true,
                    trailing: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(item.name),
                              content: Text(
                                  '${item.description}\n\nPrice: ${item.price} caps'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (gameState.caps >= item.price) {
                                      gameState.purchaseItem(item);
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('${item.name} purchased!')),
                                      );
                                    } else {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Not enough caps!')),
                                      );
                                    }
                                  },
                                  child:
                                      Text('Purchase (${item.price} caps)'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Buy'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
