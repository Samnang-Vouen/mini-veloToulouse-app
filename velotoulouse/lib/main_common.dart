import 'package:flutter/material.dart';
import 'package:velotoulouse/ui/screens/map_screen.dart';
import 'package:velotoulouse/ui/screens/subcription_screen.dart';
import 'package:velotoulouse/ui/theme/theme.dart';

void mainCommon() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = [MapScreen(), SubcriptionScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Map'),
          BottomNavigationBarItem(
            icon: Icon(Icons.euro_outlined),
            label: 'Subscriptions',
          ),
        ],
      ),
    );
  }
}
