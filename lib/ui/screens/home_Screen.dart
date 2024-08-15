import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart'; // Removed the duplicate import
import 'package:carousel_slider/carousel_slider.dart';
import 'package:retsept_cherno/ui/widgets/bottom_navigation_bar.dart';
import 'package:retsept_cherno/ui/widgets/carusel_item.dart';
import 'package:retsept_cherno/ui/widgets/classic_victoria.dart';
import 'package:retsept_cherno/ui/widgets/latest_recipe_card.dart';
import 'package:retsept_cherno/ui/widgets/pea_and_ricotta.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageList = [
    'assets/food2.png',
    'assets/food3.png',
    'assets/food4.png',
    'assets/food5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/foodify.svg",
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 32.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8.0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 24.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: SvgPicture.asset(
                        "assets/svg/filter.svg",
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                const Row(
                  children: [
                    Text(
                      'Popular Recipes',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                CarouselSlider.builder(
                  itemCount: imageList.length,
                  itemBuilder: (context, index, realIndex) {
                    return CaruselItem(
                      imagePath: imageList[index], // Pass the image path
                      title:
                          'Recipe ${index + 1}', // Pass a title or use a dynamic title
                    );
                  },
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
                const SizedBox(height: 20.0),
                const LatestRecipeCard(),
                const SizedBox(height: 20.0),
                const ClassicVictoria(),
                const SizedBox(height: 20.0),
                PeaAndRicotta(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(), // Updated with custom bottom navigation
    );
  }
}
