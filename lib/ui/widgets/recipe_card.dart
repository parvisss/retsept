import 'package:flutter/material.dart';
import 'package:retsept_cherno/data/models/coment_model.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.retsept});
  final RetseptModel retsept;

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
                child: Image.network(
                  retsept.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.0,
                ),
              ),
              Positioned(
                bottom: 8.0,
                left: 8.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 12.0),
                      const SizedBox(width: 4.0),
                      Text(
                        retsept.rate.toString(),
                        style: const TextStyle(
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
                      icon: const Icon(Icons.favorite_border,
                          color: Colors.white),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
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
            child: Text(
              retsept.name,
              style: const TextStyle(
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
              _buildInfoChip(
                  Icons.local_fire_department, retsept.dietaryTarget),
              _buildInfoChip(Icons.fastfood, retsept.difficulty),
              _buildInfoChip(Icons.timer, retsept.preparationTime),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildInfoChip(Icons.favorite, retsept.likes.toString()),
              const SizedBox(width: 10),
              _buildInfoChip(Icons.comment, retsept.coments.length.toString()),
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
                SizedBox(
                  height: 400.0,
                  child: TabBarView(
                    children: [
                      const Center(child: Text('Introduction content here')),
                      Expanded(
                        child: ListView.builder(
                          itemCount: retsept.coments.length,
                          itemBuilder: (ctx, index) {
                            // print(retsept.coments);
                            return _buildIngredients(
                                retsept.ingredients[index]);
                          },
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: retsept.coments.length,
                          itemBuilder: (ctx, index) {
                            // print(retsept.coments);
                            return _buildComment(
                              ComentModel.fromJson(retsept.coments[index]),
                            );
                          },
                          padding: const EdgeInsets.all(8.0),
                        ),
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

  Widget _buildComment(ComentModel comet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comet.sender),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Text(comet.title),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(comet.date),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIngredients(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
