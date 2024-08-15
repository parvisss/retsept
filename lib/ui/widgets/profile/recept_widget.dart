import 'package:flutter/material.dart';

class ReceptWidget extends StatefulWidget {
  const ReceptWidget({super.key});

  @override
  State<ReceptWidget> createState() => _ReceptWidgetState();
}

class _ReceptWidgetState extends State<ReceptWidget> {
  @override
Widget build(BuildContext context) {
    final List<Map<String, String>> recipes = [
      {
        'title': 'Frosted pinecone cake',
        'author': 'Kelly Mayer',
        'time': '30 Min',
        'difficulty': 'Medium',
        'rating': '4.8',
        'image': 'assets/food10.png',
      },
      {
        'title': 'Classic Victoria sandwich recipe',
        'author': 'Rick Dolynsky',
        'time': '120 Min',
        'difficulty': 'Simple',
        'rating': '4.4',
        'image': 'assets/food2.png',
      },
      {
        'title': 'Pea and Ricotta Omelets',
        'author': 'Dave Robert',
        'time': '15 Min',
        'difficulty': 'Hard',
        'rating': '5.0',
        'image': 'assets/food3.png',
      },
      {
        'title': 'Kangaroo meatball with tomato sauce',
        'author': 'Diana Shpik',
        'time': '60 Min',
        'difficulty': 'Simple',
        'rating': '4.5',
        'image': 'assets/food4.png',
      },
    ];

    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) {
        final recipe = recipes[index];

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                recipe['image']!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'By ${recipe['author']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(Icons.timer, color: Colors.grey.shade600, size: 16.0),
                        const SizedBox(width: 4.0),
                        Text(
                          recipe['time']!,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Icon(Icons.leaderboard, color: Colors.grey.shade600, size: 16.0),
                        const SizedBox(width: 4.0),
                        Text(
                          recipe['difficulty']!,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow.shade700, size: 16.0),
                        const SizedBox(width: 4.0),
                        Text(
                          recipe['rating']!,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}