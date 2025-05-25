import 'package:flutter/material.dart';
import '../widgets/farmer/farmer_bottom_nav.dart';
import 'farmer_home_page/farmer_home_page.dart';
import 'farmer_search/farmer_search_screen.dart';

class FarmerHomeScreen extends StatefulWidget {
  const FarmerHomeScreen({super.key});

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  late final List<Widget> _pages = [
    FarmerHomePage(searchController: _searchController),
    const FarmerSearchScreen(),
    const Center(child: Text('Menu Widget')),
    const Center(child: Text('Profile Widget')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: FarmerBottomNav(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
