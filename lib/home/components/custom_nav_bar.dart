import 'package:cloth/home_page.dart';
import 'package:cloth/profile_page.dart';
import 'package:cloth/screens/home_screen/listpage.dart';
import 'package:cloth/screens/home_screen/orderpage.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  // This list will store selected (favorite) products
  List<String> selectedProducts = [];
  
  // You can also keep track of the currently selected image
  String? selectedImagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      color: Colors.grey.shade900,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildGestureDetector('assets/icons/home.png', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
          }),
          buildGestureDetector('assets/icons/magnifying-glass.png', () {
            // Pass the selected products to ImagesPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImagesPage(onImageSelected: (imagePath) {
                  setState(() {
                    selectedImagePath = imagePath;
                  });
                }),
              ),
            );
          }),
           buildGestureDetector('assets/icons/bag.png', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersPage()));
          }),
          buildGestureDetector('assets/icons/categories.png', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProfileScreen()));
          }),
        ],
      ),
    );
  }
 

  GestureDetector buildGestureDetector(String iconPath, VoidCallback pressed) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        margin: const EdgeInsets.all(18),
        height: 25,
        width: 25,
        child: Image.asset(
          iconPath,
          color: Colors.white,
        ),
      ),
    );
  }
}
