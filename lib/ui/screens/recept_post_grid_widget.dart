import 'package:flutter/material.dart';

class ReceptPostGridWidget extends StatefulWidget {
  final List<String> imagePaths;

  const ReceptPostGridWidget({super.key, required this.imagePaths});

  @override
  State<ReceptPostGridWidget> createState() => _ReceptPostGridWidgetState();
}

class _ReceptPostGridWidgetState extends State<ReceptPostGridWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: widget.imagePaths.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  widget.imagePaths[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16.0),
                      SizedBox(width: 4.0),
                      Text(
                        '4.8',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                bottom: 8.0,
                left: 8.0,
                child: Text(
                  'Post Title',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
