import 'package:cloth/screens/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class BuyNowBtn extends StatelessWidget {
  const BuyNowBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 100,
      right: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: const Size(30, 60),
          backgroundColor: const Color(0xFFB2EE32),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ShopCategory()));
        },
        child: Center(
          child: Text(
            'BUY',
            style: GoogleFonts.ubuntu(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
