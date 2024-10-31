import 'package:dishcovery/pages/homepage.dart';
import 'package:dishcovery/pages/recipe_category.dart';
import 'package:dishcovery/pages/save_screen.dart';
import 'package:dishcovery/pages/serach_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected tab

  // List of pages to navigate to
  final List<Widget> _pages = [
    const HomeScreen(),
    const SerachScreen(),
    const SaveScreen(),
    const RecipeCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages, // Switch between pages
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: const EdgeInsets.all(16),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index; // Update the selected tab
              });
            },
            tabs: const [
              GButton(icon: Icons.home, text: "Home"),
              GButton(icon: Icons.search, text: "Search"),
              GButton(icon: Icons.favorite, text: "Saved"),
              GButton(icon: Icons.category, text: "Category"),
            ],
          ),
        ),
      ),
    );
  }
}