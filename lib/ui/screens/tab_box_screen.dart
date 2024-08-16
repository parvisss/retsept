// import 'package:exam_5_oy/ui/image_screen/image_screen.dart';
// import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../add_recipe_screen/add_recipe_screen.dart';
//
// class TabBoxScreen extends StatefulWidget {
//   @override
//   _TabBoxScreenState createState() => _TabBoxScreenState();
// }
//
// class _TabBoxScreenState extends State<TabBoxScreen> {
//   int _selectedIndex = 0;
//   List<Widget> tabItems = [
//     const Center(child: Text("1")),
//     const Center(child: Text("2")),
//     const ImageScreen(),
//     const AddNewScreen(),
//   ];
//   @override
//   void initState() {
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: tabItems[_selectedIndex],
//         ),
//         bottomNavigationBar: FlashyTabBar(
//           shadows: const [
//             BoxShadow(
//               offset: Offset.infinite,
//               blurRadius: 3,
//               spreadRadius: 10,
//             )
//           ],
//           animationCurve: Curves.linear,
//           selectedIndex: _selectedIndex,
//           iconSize: 30,
//           showElevation: false,
//           onItemSelected: (index) => setState(() {
//             _selectedIndex = index;
//           }),
//           items: [
//             FlashyTabBarItem(
//                 icon: const Icon(Icons.home),
//                 title: const Text('Home'),
//                 activeColor: Colors.lightBlue,
//                 inactiveColor: Colors.red),
//             FlashyTabBarItem(
//                 icon: const Icon(Icons.search),
//                 title: const Text('Search'),
//                 activeColor: Colors.lightBlue,
//                 inactiveColor: Colors.yellow),
//             FlashyTabBarItem(
//                 icon: const Icon(Icons.emoji_food_beverage_outlined),
//                 title: const Text('Add new'),
//                 activeColor: Colors.lightBlue,
//                 inactiveColor: Colors.green),
//             FlashyTabBarItem(
//                 icon: const Icon(Icons.settings),
//                 title: const Text('Profile'),
//                 activeColor: Colors.lightBlue,
//                 inactiveColor: Colors.purple),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:retsept_cherno/ui/screens/add_new_screen.dart';
import 'package:retsept_cherno/ui/screens/home_Screen.dart';
import 'package:retsept_cherno/ui/screens/profile_screen.dart';
import 'package:retsept_cherno/ui/screens/save_screen.dart';
import 'package:retsept_cherno/ui/screens/search_screen.dart';

class TabBoxScreen extends StatefulWidget {
  const TabBoxScreen({Key? key}) : super(key: key);
  @override
  State<TabBoxScreen> createState() => _TabBoxScreenState();
}

class _TabBoxScreenState extends State<TabBoxScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    AddNewScreen(),
    SaveScreen(),
    // SearchScreen(),
    SaveScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        elevation: 10,
        activeColor: Colors.white,
        items: [
          TabItem(
            icon: Icons.home,
            title: 'Home',
          ),
          TabItem(
              icon: SvgPicture.asset(
                'assets/svg/add_new.svg',
              ),
              title: 'Add New'),
          TabItem(icon: Icons.save, title: 'Save'),
          TabItem(icon: Icons.search, title: 'Search'),
          TabItem(icon: Icons.people, title: 'Profile'),
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
