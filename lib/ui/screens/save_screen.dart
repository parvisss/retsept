import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final List<Map<String, String>> categories = [
    {'title': 'All', 'image': 'assets/food2.png'},
    {'title': 'Egg', 'image': 'assets/food10.png'},
    {'title': 'Cake', 'image': 'assets/food3.png'},
    {'title': 'Palov', 'image': 'assets/food4.png'},
    {'title': 'Soup', 'image': 'assets/food5.png'},
    {'title': 'Stake food', 'image': 'assets/food6.png'},
    {'title': 'Strawbery cake', 'image': 'assets/food7.png'},
    {'title': 'Salad', 'image': 'assets/food8.png'},
  ];

  void _shareFood(String title) {
    final String message = 'Check out this amazing $title recipe!';
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Saved",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return InkWell(
              onTap: () {},
              child: Stack(
                children: [
                  CustomPaint(
                    painter: BorderPainter(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage(category['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        category['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.open_in_new,
                          color: Colors.orange,
                        ),
                        onPressed: () {
                          _shareFood(category['title']!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    final borderRadius = BorderRadius.circular(10.0).toRRect(rect);
    canvas.drawRRect(borderRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
