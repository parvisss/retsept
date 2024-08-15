import 'package:flutter/material.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';
import 'package:retsept_cherno/ui/widgets/recipe_card.dart';

class ClassicVictoria extends StatelessWidget {
  const ClassicVictoria({super.key, required this.retsept});
  final RetseptModel retsept;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return RecipeCard(
                                      retsept: retsept,
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text('View More'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            retsept.description,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoChip(Icons.local_fire_department,
                              retsept.dietaryTarget),
                          _buildInfoChip(Icons.fastfood, retsept.difficulty),
                        ],
                      ),
                      _buildInfoChip(Icons.timer, retsept.preparationTime),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildInfoChip(
                              Icons.favorite, retsept.likes.toString()),
                          _buildInfoChip(
                              Icons.comment, retsept.coments.length.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Card(
        child: Container(
          clipBehavior: Clip.hardEdge,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150.0,
                height: 230.0,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        retsept.image,
                        fit: BoxFit.cover,
                        width: 150.0,
                        height: 230.0,
                      ),
                    ),
                    Positioned(
                      top: 8.0,
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
                            const Icon(Icons.star,
                                color: Colors.yellow, size: 12.0),
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
                      left: 8.0,
                      child: Row(
                        children: [
                          const Icon(Icons.timer,
                              color: Colors.white, size: 12.0),
                          const SizedBox(width: 4.0),
                          Text(
                            retsept.preparationTime,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          const Icon(Icons.restaurant,
                              color: Colors.white, size: 12.0),
                          const SizedBox(width: 4.0),
                          Text(
                            retsept.difficulty,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      retsept.name,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/chef2.png'), //! change to users image
                          radius: 20.0,
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.star, color: Colors.black, size: 12.0),
                              SizedBox(width: 4.0),
                              Text(
                                '4.9',
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
                    const SizedBox(height: 8.0),
                    Text(
                      retsept.description,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
}
