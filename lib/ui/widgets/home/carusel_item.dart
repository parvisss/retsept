import 'package:flutter/material.dart';

class CaruselItem extends StatelessWidget {
  const CaruselItem({
    super.key,
    required this.imagePath,
    required this.title,
  });

  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Use the height parameter here
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
          onError: (error, stackTrace) {},
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
