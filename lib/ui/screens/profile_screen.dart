import 'package:flutter/material.dart';
import 'package:retsept_cherno/ui/screens/recept_post_grid_widget.dart';
import 'package:retsept_cherno/ui/widgets/classic_victoria.dart';
import 'package:retsept_cherno/ui/widgets/pea_and_ricotta.dart';
import 'package:retsept_cherno/ui/widgets/recept_widget.dart';
import 'package:retsept_cherno/ui/widgets/latest_recipe_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // TabBar'dagi zakladkalar soni
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 220.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/food2.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16.0,
                        bottom: 16.0,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.star,
                                  color: Colors.yellow, size: 16.0),
                              SizedBox(width: 4.0),
                              Text(
                                '4.9',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 180.0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          color: Colors.blue,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '15K',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Followers',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 120),
                              Column(
                                children: [
                                  Text(
                                    '246',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Following',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 130.0,
                        left: MediaQuery.of(context).size.width / 2 - 50,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 4.0,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/chef2.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60.0),
                  const Text(
                    'Celina Damon',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Toronto, Canada',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'To cook is to see how simple ingredients can create magic on the plate.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(128, 40),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'Follow',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size(150, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'Share Profile',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  const TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: '18 Post'),
                      Tab(text: 'Latest Recipes'),
                      Tab(text: 'Classic Victoria'),
                      Tab(text: 'Pea & Ricotta'),
                    ],
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  const ReceptPostGridWidget(
                    imagePaths: [
                      'assets/food10.png',
                      'assets/food2.png',
                      'assets/food3.png',
                      'assets/food4.png',
                      'assets/food5.png',
                      'assets/food6.png',
                    ],
                  ),
                  const LatestRecipeCard(),
                  const ClassicVictoria(),
                  PeaAndRicotta(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
