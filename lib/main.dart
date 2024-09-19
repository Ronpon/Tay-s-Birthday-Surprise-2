// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/game_state.dart';
import 'screens/dashboard_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/perks_screen.dart';
import 'screens/quests_screen.dart';
import 'screens/shop_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Define your custom TextTheme with Share Tech Mono and green color
  TextTheme _buildTextTheme() {
    return const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'ShareTechMono',
        color: Colors.green,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'ShareTechMono',
        color: Colors.green,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: 'ShareTechMono',
        color: Colors.green,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'ShareTechMono',
        color: Colors.green,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'ShareTechMono',
        color: Colors.green,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'ShareTechMono',
        color: Colors.green,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontFamily: 'ShareTechMono',
        color: Colors.green,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontFamily: 'ShareTechMono',
        color: Colors.green,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'ShareTechMono',
        color: Colors.green,
        fontSize: 16.0,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'ShareTechMono',
        color: Colors.green,
        fontSize: 14.0,
      ),
      bodySmall: TextStyle(
        fontFamily: 'ShareTechMono',
        color: Colors.green,
        fontSize: 12.0,
      ),
      labelLarge: TextStyle(
        fontFamily: 'ShareTechMono',
        color: Colors.green,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fallout-Themed App',
      theme: ThemeData(
        // Set the scaffold background color to black
        scaffoldBackgroundColor: Colors.black,

        // Define the default font family
        fontFamily: 'ShareTechMono',

        // Define the default brightness and colors
        brightness: Brightness.dark,

        // Apply the custom TextTheme
        textTheme: _buildTextTheme(),

        // Define default ElevatedButton styles
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
              fontFamily: 'ShareTechMono',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Customize AppBar theme
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'ShareTechMono',
            color: Colors.green,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.green),
        ),

        // Customize IconTheme
        iconTheme: const IconThemeData(
          color: Colors.green,
          size: 24.0,
        ),
      ),
      home: const DashboardScreen(), // Changed to DashboardScreen
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/perks': (context) => const PerksScreen(),
        '/quests': (context) => const QuestsScreen(),
        '/inventory': (context) => const InventoryScreen(),
        '/shop': (context) => const ShopScreen(),
      },
    );
  }
}
