import 'package:cloth/screens/home_screen/cart.dart';
import 'package:flutter/material.dart';

class ImagesPage extends StatelessWidget {
  final Function(String) onImageSelected; // Callback to pass the selected image

  ImagesPage({super.key, required this.onImageSelected});

  // List of image paths
  final List<String> imagePaths = [
    'assets/images/image1.jpeg',
    'assets/images/image7.jpg',
    'assets/images/image5.jpg',
    'assets/images/image11.jpeg',
    'assets/images/image3.jpeg',
    'assets/images/image4.jpeg',
    'assets/images/image8.jpeg',
    'assets/images/image11.jpeg',
    'assets/images/image2.jpeg',
    
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,  // Number of images per row
            crossAxisSpacing: 8.0,  // Horizontal spacing between images
            mainAxisSpacing: 8.0,  // Vertical spacing between images
          ),
          itemCount: imagePaths.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Call the callback with the selected image path
                onImageSelected(imagePaths[index]);
                // Optionally navigate to CartPage immediately
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(imagePath: imagePaths[index]),
                  ),
                );
              },
              child: Image.asset(
                imagePaths[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
