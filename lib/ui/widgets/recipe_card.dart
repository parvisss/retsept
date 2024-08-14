import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Recipe Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/amlet.png', // Replace with your actual image asset
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.0,
                ),
              ),
              Positioned(
                bottom: 8.0,
                left: 8.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 12.0),
                      SizedBox(width: 4.0),
                      Text(
                        '4.3',
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
                right: 8.0,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Chef Information
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/chef2.png'), // Replace with your actual image asset
                radius: 20.0,
              ),
              const SizedBox(width: 8.0),
              const Text(
                'Kelly Mayer',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star, color: Colors.black, size: 12.0),
                    SizedBox(width: 4.0),
                    Text(
                      '4.8',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Recipe Title
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'Perfect homemade pancake',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Recipe Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoChip(Icons.local_fire_department, 'Low Calory'),
              _buildInfoChip(Icons.fastfood, 'Simple'),
              _buildInfoChip(Icons.timer, '48 Min'),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoChip(Icons.favorite, '435'),
              _buildInfoChip(Icons.comment, '5'),
            ],
          ),
          const SizedBox(height: 16.0),
          // Tabs
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: 'Introduction'),
                    Tab(text: 'Ingredients'),
                    Tab(text: 'Comments'),
                  ],
                ),
                Container(
                  height: 200.0,
                  child: TabBarView(
                    children: [
                      const Center(child: Text('Introduction content here')),
                      const Center(child: Text('Ingredients content here')),
                      // Comments Section
                      ListView(
                        padding: const EdgeInsets.all(8.0),
                        children: [
                          const Text('3 Comments',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          _buildComment(
                              'assets/chef3.png', // Replace with actual user image
                              'This recipe is a game-changer! The combination of spices and textures is phenomenal. I\'ve already shared it with all my friends – it\'s too good not to pass along!'),
                          _buildComment(
                              'assets/chef2.png', // Replace with actual user image
                              'As a busy mom, I appreciate quick and tasty recipes. This one not only saved me time but also earned me compliments from the whole family. Winner!'),
                          _buildComment(
                              'assets/chef.png', // Replace with actual user image
                              'I\'m always on the lookout for healthy recipes, and this one exceeded my expectations. Packed with nutrients and flavor, it\'s become a regular in my weekly menu.'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16.0),
      label: Text(label),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildComment(String imagePath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath), // Use provided image path
            radius: 16.0,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
