// lib/models/game_state.dart

import 'package:flutter/foundation.dart';
import 'perk.dart';
import 'item.dart';
import 'quest.dart';
import 'speech_check.dart';
import 'subtask.dart';

class GameState with ChangeNotifier {
  // Player stats
  String playerName = 'Taylor';
  int level = 1;
  int experience = 0;
  int experienceToNextLevel = 100; // Level x 100
  int caps = 50; // Starting caps
  int perkPoints = 0;

  // Lists to hold acquired perks, purchased items, and quests
  List<Perk> acquiredPerks = [];
  List<Item> inventory = [];
  List<Quest> quests = [];

  GameState() {
    // Initialize quests
    quests = [
      // 1. Let’s Get Smashed
      Quest(
        title: 'Let’s Get Smashed',
        description: 'Beat Jormes Jacobs at Super Smash Bros.',
        experience: 50,
        caps: 0,
        isRepeatable: true,
        speechChecks: [
          SpeechCheck(
            prompt: 'What, are you scared?',
            successThreshold: 7,
            successResult: 'He starts with -1 life.',
            failureResult: 'No effect.',
          ),
        ],
        canWager: true,
      ),

      // 2. Let Them Eat Pie: Part 1
      Quest(
        title: 'Let Them Eat Pie: Part 1',
        description: 'Find a recipe.',
        experience: 50,
        caps: 0,
        isRepeatable: false,
        speechChecks: [],
        canWager: false,
      ),

      // 3. Let Them Eat Pie: Part 2
      Quest(
        title: 'Let Them Eat Pie: Part 2',
        description: 'Fetch the ingredients.',
        experience: 50,
        caps: 0,
        isRepeatable: false,
        speechChecks: [
          SpeechCheck(
            prompt: 'Fine, but you’re paying.',
            successThreshold: 5,
            successResult: 'Jormes will pay for the ingredients.',
            failureResult: 'You have to pay for the ingredients.',
          ),
        ],
        canWager: false,
      ),

      // 4. Let Them Eat Pie: Part 3
      Quest(
        title: 'Let Them Eat Pie: Part 3',
        description: 'Bake the pie.',
        experience: 200,
        caps: 0,
        isRepeatable: false,
        speechChecks: [
          SpeechCheck(
            prompt: 'But you’re SO GOOD at it!',
            successThreshold: 8,
            successResult: 'Chef Jormes will bake it for you.',
            failureResult: 'You have to bake the pie.',
          ),
        ],
        canWager: false,
      ),

      // 5. Jormio Kart
      Quest(
        title: 'Jormio Kart',
        description: 'Beat Jormes Jacobs at Mario Kart (1 Grand Prix).',
        experience: 100,
        caps: 0,
        isRepeatable: true,
        speechChecks: [
          SpeechCheck(
            prompt: 'Let me pick!',
            successThreshold: 5,
            successResult: 'You pick Jormes’ racer.',
            failureResult: 'You pick Jormes’ racer and his kart setup.',
          ),
        ],
        canWager: true,
      ),

      // 6. Archery Contest
      Quest(
        title: 'Archery Contest',
        description: 'Complete one level of “In Death: Unchained” (Kingdom of Heaven Mode).',
        experience: 200,
        caps: 0,
        isRepeatable: true,
        speechChecks: [
          SpeechCheck(
            prompt: 'That’s too hard!',
            successThreshold: 8,
            successResult: 'You only have to make it to wave 10.',
            failureResult: 'No effect.',
          ),
        ],
        canWager: false,
      ),

      // 7. Party Time
      Quest(
        title: 'Party Time',
        description: 'Win a best of 5 minigames in Mario Party. Loser chooses the next game. Jormes picks first.',
        experience: 75,
        caps: 0,
        isRepeatable: true,
        speechChecks: [
          SpeechCheck(
            prompt: 'It’s MY birthday party!',
            successThreshold: 3,
            successResult: 'You pick first.',
            failureResult: 'No effect.',
          ),
          SpeechCheck(
            prompt: 'It’s MY birthday party!',
            successThreshold: 8,
            successResult: 'You choose all the games.',
            failureResult: 'No effect.',
          ),
          SpeechCheck(
            prompt: 'It’s MY birthday party!',
            successThreshold: 11,
            successResult: 'You choose all the games, AND you only have to win 2 of them.',
            failureResult: 'No effect.',
          ),
        ],
        canWager: true,
      ),

      // 8. The Third Williams Sister
      Quest(
        title: 'The Third Williams Sister',
        description: 'Win a 3-set game of Mario Tennis.',
        experience: 100,
        caps: 0,
        isRepeatable: true,
        speechChecks: [
          SpeechCheck(
            prompt: 'I’m rusty.',
            successThreshold: 8,
            successResult: 'You choose both characters.',
            failureResult: 'No effect.',
          ),
        ],
        canWager: false,
      ),

      // 9. The Bored Gamer
      Quest(
        title: 'The Bored Gamer',
        description: 'Challenge Jormes to a board game of his choice.',
        experience: 200,
        caps: 0,
        isRepeatable: true,
        speechChecks: [
          SpeechCheck(
            prompt: 'Let me pick!',
            successThreshold: 5,
            successResult: 'You choose the game.',
            failureResult: 'No effect.',
          ),
          SpeechCheck(
            prompt: 'Just give up now.',
            successThreshold: 11,
            successResult: 'You win automatically.',
            failureResult: 'No effect.',
          ),
        ],
        canWager: true,
      ),

      // 10. Fallout Snap
      Quest(
        title: 'Fallout Snap',
        description: 'Take photos of 7 different types of animals.',
        experience: 50,
        caps: 100,
        isRepeatable: false,
        speechChecks: [
          SpeechCheck(
            prompt: 'That’s too many!',
            successThreshold: 5,
            successResult: 'You have to take photos of 6 types of animals.',
            failureResult: 'You have to take photos of 5 types of animals.',
          ),
        ],
        canWager: false,
      ),

      // 11. Target Practice (Easy)
      Quest(
        title: 'Target Practice (Easy)',
        description: 'Hit all the targets. 4 targets, 6 shots. Cost: 10 bottlecaps.',
        experience: 20,
        caps: 20,
        isRepeatable: true,
        speechChecks: [
          SpeechCheck(
            prompt: '4 is too many!',
            successThreshold: 8,
            successResult: 'You only have to hit 3 targets.',
            failureResult: 'No effect.',
          ),
        ],
        canWager: false,
      ),

      // 12. Target Practice (Hard)
      Quest(
        title: 'Target Practice (Hard)',
        description: 'Hit all the targets. 4 targets, 6 shots. Cost: 10 bottlecaps.',
        experience: 40,
        caps: 40,
        isRepeatable: true,
        speechChecks: [
          SpeechCheck(
            prompt: '4 is still too many!',
            successThreshold: 8,
            successResult: 'You only have to hit 3 targets.',
            failureResult: 'No effect.',
          ),
        ],
        canWager: false,
      ),

      // 13. Mine Sweeper
      Quest(
        title: 'Mine Sweeper',
        description: 'Clear the land mines (poops) from the backyard.',
        experience: 200,
        caps: 0,
        isRepeatable: false,
        speechChecks: [
          SpeechCheck(
            prompt: 'This shovel is too heavy!',
            successThreshold: 6,
            successResult: 'Jormes will pick them up; you still need to direct him.',
            failureResult: 'No effect.',
          ),
          SpeechCheck(
            prompt: 'This shovel is too heavy!',
            successThreshold: 10,
            successResult: 'Jormes will do it all for you.',
            failureResult: 'No effect.',
          ),
        ],
        canWager: false,
      ),

      // 14. Canine Chaperone
      Quest(
        title: 'Canine Chaperone',
        description: 'Take Inuk for a walk.',
        experience: 200,
        caps: 0,
        isRepeatable: false,
        speechChecks: [
          SpeechCheck(
            prompt: 'I’m lonely!',
            successThreshold: 3,
            successResult: 'Jormes will accompany you.',
            failureResult: 'No effect.',
          ),
          SpeechCheck(
            prompt: 'I’m weak!',
            successThreshold: 5,
            successResult: 'Jormes will hold the leash.',
            failureResult: 'No effect.',
          ),
          SpeechCheck(
            prompt: 'I’m lazy!',
            successThreshold: 10,
            successResult: 'Jormes will take the dog himself.',
            failureResult: 'No effect.',
          ),
        ],
        canWager: false,
      ),

      // 15. Laundry Day
      Quest(
        title: 'Laundry Day',
        description: 'Do a load of laundry (washer, dryer, fold).',
        experience: 100,
        caps: 0,
        isRepeatable: false,
        speechChecks: [
          SpeechCheck(
            prompt: 'It’s my birthday!',
            successThreshold: 5,
            successResult: 'Jormes will fold the clothes.',
            failureResult: 'No effect.',
          ),
          SpeechCheck(
            prompt: 'It’s my birthday!',
            successThreshold: 8,
            successResult: 'Jormes will dry and fold the clothes.',
            failureResult: 'No effect.',
          ),
          SpeechCheck(
            prompt: 'It’s my birthday!',
            successThreshold: 10,
            successResult: 'Jormes will do the whole shebang.',
            failureResult: 'No effect.',
          ),
        ],
        canWager: false,
      ),
    ];
  }

  // Methods to update stats
  void addExperience(int amount) {
    experience += amount;
    while (experience >= experienceToNextLevel) {
      experience -= experienceToNextLevel;
      levelUp();
    }
    notifyListeners();
  }

  void levelUp() {
    level += 1;
    experienceToNextLevel = level * 100; // Adjusted formula
    perkPoints += 1;
    notifyListeners();
  }

  void addCaps(int amount) {
    caps += amount;
    notifyListeners();
  }

  void spendCaps(int amount) {
    caps -= amount;
    notifyListeners();
  }

  void acquirePerk(Perk perk) {
    if (perkPoints > 0 &&
        level >= perk.requiredLevel &&
        perk.currentLevel < perk.maxLevel) {
      perk.currentLevel += 1;
      perkPoints--;
      if (!acquiredPerks.contains(perk)) {
        acquiredPerks.add(perk);
      }
      notifyListeners();
    }
  }

  void purchaseItem(Item item) {
    if (caps >= item.price) {
      spendCaps(item.price);
      inventory.add(item);
      notifyListeners();
    }
  }

  void useItem(Item item) {
    inventory.remove(item);
    // Handle specific item effects
    switch (item.name) {
      case 'Rewinder':
        resetSpeechChecks();
        break;
      // Add cases for other items if needed
      default:
        // No action or default behavior
        break;
    }
    notifyListeners();
  }

  void addPerkByName(String perkName) {
    // Check if the perk already exists
    Perk? existingPerk;
    try {
      existingPerk = acquiredPerks.firstWhere((perk) => perk.name == perkName);
    } catch (e) {
      existingPerk = null;
    }

    if (existingPerk != null) {
      if (existingPerk.currentLevel < existingPerk.maxLevel && perkPoints > 0) {
        existingPerk.currentLevel += 1;
        perkPoints--;
        notifyListeners();
      }
    } else {
      // Add new perk if not already acquired
      Perk newPerk = predefinedPerks.firstWhere(
        (perk) => perk.name == perkName,
        orElse: () => Perk(
          name: perkName,
          description: 'Description for $perkName',
          requiredLevel: 1,
          maxLevel: 3,
        ),
      );
      acquirePerk(newPerk);
    }
  }

  // Updated list of predefined perks (Removed Mesmerizer, Rewinder, Dommy Mommy Wand)
  List<Perk> predefinedPerks = [
    // Existing Perks
    Perk(
      name: 'Smooth talker',
      description: 'All speech rolls get +1/+2/+3.',
      requiredLevel: 1,
      maxLevel: 3,
    ),
    Perk(
      name: 'Special Delivery',
      description: 'You will get lunch delivered to work on a day of your choice.',
      requiredLevel: 1,
      maxLevel: 1,
    ),
    Perk(
      name: 'Snack Attack',
      description:
          'Got a craving? Save this perk to send your loving husband on a trip to get any snack you want, anytime.',
      requiredLevel: 1,
      maxLevel: 1,
    ),
    Perk(
      name: 'Hustler',
      description: 'You may wager on Target Practice.',
      requiredLevel: 2,
      maxLevel: 1,
    ),
    Perk(
      name: 'Gamer Girl',
      description: 'Choose 2 game quests to automatically complete.',
      requiredLevel: 3,
      maxLevel: 1,
    ),
    Perk(
      name: 'Sharpshooter',
      description: 'You only have to hit 3 targets in Target Practice to win.',
      requiredLevel: 3,
      maxLevel: 1,
    ),
    Perk(
      name: 'Moisturize Me',
      description:
          'For the rest of the day, Ron will massage you whenever and wherever you want - with moisturizer if requested.',
      requiredLevel: 4,
      maxLevel: 1,
    ),
    Perk(
      name: 'Queen for the day',
      description: 'Ron must do whatever you want (outside of this game).',
      requiredLevel: 7,
      maxLevel: 1,
    ),
  ];

  // Method to perform a speech check
  void performSpeechCheck(
      Quest quest, SpeechCheck speechCheck, bool isSuccess) {
    if (quest.speechCheckResults.contains(speechCheck.prompt)) {
      // Already attempted
      return;
    }

    String result =
        isSuccess ? speechCheck.successResult : speechCheck.failureResult;

    // Update the description with the result
    quest.description = '${quest.originalDescription}\n$result';
    quest.speechCheckResults.add(speechCheck.prompt);

    notifyListeners();
  }

  // Method to complete a quest
  void completeQuest(Quest quest) {
    if (quest.isCompleted && !quest.isRepeatable) {
      // Non-repeatable quest already completed
      return;
    }

    // Award experience and caps
    int xp = quest.experience;
    if (acquiredPerks.any((perk) => perk.name == 'Gamer Girl') &&
        quest.title.contains('Game')) {
      xp *= 2; // Double XP for game quests
    }
    addExperience(xp);
    addCaps(quest.caps);

    if (quest.isRepeatable) {
      // Reset speech checks and description
      quest.speechCheckResults.clear();
      quest.description = quest.originalDescription;
    } else {
      // Mark non-repeatable quest as completed
      quest.isCompleted = true;
    }

    // Handle special cases for quests
    if (quest.title == 'Canine Chaperone') {
      promptForPokestopsAndPokemon(quest);
    } else if (quest.title == 'Fallout Snap') {
      promptForAdditionalAnimals(quest);
    } else if (quest.title.contains('Target Practice')) {
      handleTargetPracticeRewards(quest);
    }

    notifyListeners();
  }

  // Method to reset speech checks using Rewinder
  void resetSpeechChecks() {
    for (var quest in quests) {
      if (!quest.isCompleted || quest.isRepeatable) {
        quest.speechCheckResults.clear();
        quest.description = quest.originalDescription;
      }
    }
    notifyListeners();
  }

  // Method to complete subtasks
  void setSubtaskCompleted(Quest quest, Subtask subtask) {
    subtask.isCompleted = true;
    notifyListeners();
  }

  // Placeholder methods for quest-specific rewards
  void promptForPokestopsAndPokemon(Quest quest) {
    // Implementation for specific quest rewards
    // For example, add more caps or experience
    addCaps(50); // Example reward
  }

  void promptForAdditionalAnimals(Quest quest) {
    // Implementation for specific quest rewards
    addCaps(100); // Example reward
  }

  void handleTargetPracticeRewards(Quest quest) {
    // Implementation for specific quest rewards
    addExperience(200); // Example reward
  }

  // Implement the resolveWager method
  void resolveWager(int wagerAmount, bool won) {
    if (won) {
      addCaps(wagerAmount); // Gain wagered caps
    } else {
      spendCaps(wagerAmount); // Lose wagered caps
    }
    notifyListeners();
  }
}
