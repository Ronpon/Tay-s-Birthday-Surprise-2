// lib/screens/quests_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/quest.dart';
import '../models/speech_check.dart'; // Import SpeechCheck

class QuestsScreen extends StatefulWidget {
  const QuestsScreen({Key? key}) : super(key: key);

  @override
  _QuestsScreenState createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  int wagerAmount = 0;

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final playerCaps = gameState.caps;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Wager Section at the Top
            WagerSection(
              wagerAmount: wagerAmount,
              playerCaps: playerCaps,
              onWagerAmountChanged: (newAmount) {
                setState(() {
                  wagerAmount = newAmount;
                });
              },
              onWagerConfirmed: () {
                if (wagerAmount > 0) {
                  _showWagerResultDialog(context, gameState);
                }
              },
            ),
            const SizedBox(height: 20),
            // Divider
            const Divider(),
            const SizedBox(height: 10),
            // Quests List
            Expanded(
              child: gameState.quests.isEmpty
                  ? const Center(child: Text('No quests available.'))
                  : ListView.builder(
                      itemCount: gameState.quests.length,
                      itemBuilder: (context, index) {
                        final quest = gameState.quests[index];
                        return QuestCard(quest: quest);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Dialog to Confirm Wager
  void _showWagerResultDialog(BuildContext context, GameState gameState) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Wager'),
          content: Text('Do you want to wager $wagerAmount caps?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showWagerOutcomeDialog(context, gameState);
              },
              child: const Text('Wager'),
            ),
          ],
        );
      },
    );
  }

  // Dialog to Choose Wager Outcome (Win or Lose)
  void _showWagerOutcomeDialog(BuildContext context, GameState gameState) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Wager Outcome'),
          content: const Text('Did you win or lose the wager?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // User chose to lose the wager
                gameState.resolveWager(wagerAmount, false);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You lost $wagerAmount caps.')),
                );
                setState(() {
                  wagerAmount = 0;
                });
              },
              child: const Text('Lose'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // User chose to win the wager
                gameState.resolveWager(wagerAmount, true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You won $wagerAmount caps!')),
                );
                setState(() {
                  wagerAmount = 0;
                });
              },
              child: const Text('Win'),
            ),
          ],
        );
      },
    );
  }
}

class WagerSection extends StatelessWidget {
  final int wagerAmount;
  final int playerCaps;
  final Function(int) onWagerAmountChanged;
  final VoidCallback onWagerConfirmed;

  const WagerSection({
    Key? key,
    required this.wagerAmount,
    required this.playerCaps,
    required this.onWagerAmountChanged,
    required this.onWagerConfirmed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Player's Total Caps
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Total Caps: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '$playerCaps',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Wager Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Decrease Wager Button
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: wagerAmount > 0
                  ? () {
                      onWagerAmountChanged(wagerAmount - 1);
                    }
                  : null,
            ),
            // Display Current Wager Amount
            Text(
              '$wagerAmount',
              style: const TextStyle(fontSize: 18),
            ),
            // Increase Wager Button
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: wagerAmount < playerCaps
                  ? () {
                      onWagerAmountChanged(wagerAmount + 1);
                    }
                  : null,
            ),
            const SizedBox(width: 20),
            // Wager Button
            ElevatedButton(
              onPressed: wagerAmount > 0 ? onWagerConfirmed : null,
              child: const Text('Wager'),
            ),
          ],
        ),
      ],
    );
  }
}

class QuestCard extends StatelessWidget {
  final Quest quest;

  const QuestCard({Key? key, required this.quest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context, listen: false);

    bool isCompleted = quest.isCompleted;
    bool isRepeatable = quest.isRepeatable;

    return Opacity(
      opacity: isCompleted && !isRepeatable ? 0.5 : 1.0,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quest Title
              Text(
                quest.title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Quest Description
              Text(quest.description),
              const SizedBox(height: 8),
              // Speech Checks
              ...quest.speechChecks.map((speechCheck) {
                bool isUsed =
                    quest.speechCheckResults.contains(speechCheck.prompt);
                return SpeechCheckWidget(
                  speechCheck: speechCheck,
                  isUsed: isUsed,
                  onResult: (isSuccess) {
                    gameState.performSpeechCheck(quest, speechCheck, isSuccess);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isSuccess
                            ? 'Success: ${speechCheck.successResult}'
                            : 'Failure: ${speechCheck.failureResult}'),
                      ),
                    );
                  },
                );
              }).toList(),
              const SizedBox(height: 8),
              // Reward and Complete Quest Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Reward Information
                  Text(
                    'Reward: ${quest.experience} XP${quest.caps > 0 ? ', ${quest.caps} Caps' : ''}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  // "Quest Complete" Button
                  ElevatedButton(
                    onPressed: isCompleted && !isRepeatable
                        ? null
                        : () {
                            gameState.completeQuest(quest);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isCompleted && isRepeatable
                                      ? 'Quest completed and reset!'
                                      : 'Quest completed!',
                                ),
                              ),
                            );
                          },
                    child: const Text('Quest Complete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpeechCheckWidget extends StatelessWidget {
  final SpeechCheck speechCheck;
  final bool isUsed;
  final Function(bool) onResult;

  const SpeechCheckWidget({
    Key? key,
    required this.speechCheck,
    required this.isUsed,
    required this.onResult,
  }) : super(key: key);

  void _showSpeechCheckDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${speechCheck.prompt} (${speechCheck.successThreshold}+)'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onResult(false); // Failure
              },
              child: const Text('Fail'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onResult(true); // Success
              },
              child: const Text('Success'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isUsed ? 0.5 : 1.0,
      child: ElevatedButton(
        onPressed: isUsed ? null : () => _showSpeechCheckDialog(context),
        child: Text('${speechCheck.prompt} (${speechCheck.successThreshold}+)'),
      ),
    );
  }
}
