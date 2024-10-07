import 'package:cloth/home/components/buy_now_btn.dart';
import 'package:cloth/home/components/dot_indicator.dart';
import 'package:cloth/screens/shop_screen.dart';
import 'package:flutter/material.dart';

class HorizontalItemView extends StatelessWidget {
  final PageController _controller = PageController();

  HorizontalItemView({
    super.key,
  });

  List<String> imagePath = [
    'assets/images/image10.jpg',
    'assets/images/image9.jpg',
    'assets/images/image5.jpg',
    'assets/images/image8.jpeg',
  ];

  void _navigateToCart(BuildContext context) {
    print("Image tapped, navigating to ShopCategory");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ShopCategory()), 
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
          width: size.width,
          height: 350,
          child: ListView.builder(
            itemCount: imagePath.length,
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () => _navigateToCart(context),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 450,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        imagePath[index],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        DotIndicator(controller: _controller, imagePath: imagePath),
        const BuyNowBtn(),
      ],
    );
  }
}
