import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/food8.png',
    'assets/food2.png',
    'assets/food3.png',
    'assets/food4.png',
    'assets/food5.png',
    'assets/food6.png',
  ];

  final List<Map<String, String>> chefs = [
    {'name': 'Mark Salvador', 'image': 'assets/chef3.png'},
    {'name': 'Martin Robert', 'image': 'assets/chef2.png'},
    {'name': 'Melisa Anne', 'image': 'assets/chef2.png'},
    {'name': 'Dave Robert', 'image': 'assets/chef.png'},
  ];

  final List<String> tags = [
    '#egg',
    '#eggrecipe',
    '#eggfast',
    '#eggsandwich',
    '#eggrolls',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
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
          child: Column(
            children: [
              // Search bar and filter button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
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
                        padding: const EdgeInsets.all(12.0),
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
              ),

              // Tab bar
              const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Recipes'),
                  Tab(text: 'Chefs'),
                  Tab(text: 'Tags'),
                ],
              ),

              // Expanded grid view for the images
              Expanded(
                child: TabBarView(
                  children: [
                    _buildGridView(),
                    _buildChefList(),
                    _buildTagList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return _buildRecipeCard(imagePaths[index]);
      },
    );
  }

  Widget _buildRecipeCard(String imagePath) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 8.0,
          left: 8.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              children: const [
                Icon(Icons.star, color: Colors.yellow, size: 12.0),
                SizedBox(width: 4.0),
                Text(
                  '4.8',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Container(
            padding: const EdgeInsets.all(4.0),
            color: Colors.black54,
            child: const Text(
              'Chocolate Cake with Buttercream Frosting',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChefList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: chefs.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(chefs[index]['image']!),
          ),
          title: Text(chefs[index]['name']!),
        );
      },
    );
  }

  Widget _buildTagList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: tags.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.tag),
          ),
          title: Text(tags[index]),
        );
      },
    );
  }
}
