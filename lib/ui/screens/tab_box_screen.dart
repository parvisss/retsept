import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:retsept_cherno/ui/screens/add_new_screen.dart';
import 'package:retsept_cherno/ui/screens/home_Screen.dart';
import 'package:retsept_cherno/ui/screens/profile_screen.dart';
import 'package:retsept_cherno/ui/screens/save_screen.dart';

class TabBoxScreen extends StatefulWidget {
  const TabBoxScreen({Key? key}) : super(key: key);
  @override
  State<TabBoxScreen> createState() => _TabBoxScreenState();
}

class _TabBoxScreenState extends State<TabBoxScreen> {
  int _selectedIndex = 0;
  @override
  void initState() {
    
    super.initState();
  }
  final List<Widget> _screens = [
    HomeScreen(),
    AddNewScreen(),
    SaveScreen(),
    // SearchScreen(),
    SaveScreen(),
    ProfileScreen(null),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        elevation: 10,
        activeColor: Colors.white,
        items: [
          const TabItem(
            icon: Icons.home,
            title: 'Home',
          ),
          TabItem(
              icon: SvgPicture.asset(
                'assets/svg/add_new.svg',
              ),
              title: 'Add New'),
          const TabItem(icon: Icons.save, title: 'Save'),
          const TabItem(icon: Icons.search, title: 'Search'),
          const TabItem(icon: Icons.people, title: 'Profile'),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
