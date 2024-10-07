import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Products extends StatefulWidget {
  const Products({
    super.key,
  });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<String> products = [
    'assets/images/image1.jpeg',
    'assets/images/image7.jpg',
    'assets/images/image5.jpg',
    'assets/images/image11.jpeg',
  ];

  // List to store selected (favorited) products
  List<String> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Sales',
                style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  // Navigate to the new page showing selected products
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritesPage(selectedProducts: selectedProducts),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          height: 550,
          width: double.infinity,
          child: GridView.builder(
            itemCount: products.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 250,
            ),
            itemBuilder: (BuildContext context, index) {
              bool isSelected = selectedProducts.contains(products[index]);

              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          products[index],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: isSelected ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isSelected) {
                            selectedProducts.remove(products[index]);
                          } else {
                            selectedProducts.add(products[index]);
                          }
                        });
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<String> selectedProducts;

  const FavoritesPage({super.key, required this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: selectedProducts.isEmpty
          ? const Center(child: Text('No favorites selected'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: selectedProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 250,
              ),
              itemBuilder: (context, index) {
                // Print to debug the image paths
                print(selectedProducts[index]);

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      selectedProducts[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Text('Image not found'));
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

