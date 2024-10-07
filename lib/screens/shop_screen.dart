import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopCategory extends StatefulWidget {
  const ShopCategory({super.key});

  @override
  _ShopCategoryState createState() => _ShopCategoryState();
}

class _ShopCategoryState extends State<ShopCategory> {
  final List<String> _imagePaths = [
    'assets/images/image10.jpg',
    'assets/images/image9.jpg',
    'assets/images/image5.jpg',
    'assets/images/image8.jpeg',
  ];

  late String _currentImagePath;
  final _random = Random();
  final _timerDuration = const Duration(hours: 8); // Change image every 8 hours
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentImagePath = _getRandomImagePath();
    _startImageChangeTimer();
  }

  String _getRandomImagePath() {
    return _imagePaths[_random.nextInt(_imagePaths.length)];
  }

  void _startImageChangeTimer() {
    _timer = Timer.periodic(_timerDuration, (Timer timer) {
      setState(() {
        _currentImagePath = _getRandomImagePath();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> _storeOrderInFirestore() async {
    try {
      final docRef = FirebaseFirestore.instance.collection('special order').doc();
      await docRef.set({
        'imagePath': _currentImagePath,
        'timestamp': Timestamp.now(),
      });
      print('Order stored successfully.');
    } catch (e) {
      print('Error storing order: $e');
    }
  }

  void _showPurchaseSuccessMessage(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        'Item purchased successfully!',
        style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Shop', style: GoogleFonts.montserrat()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Shop Screen',
              style: GoogleFonts.montserrat(
                fontSize: 30,
                color: const Color(0xFFB2EE32),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _currentImagePath.isNotEmpty
                ? SizedBox(
                    width: 300, // Set your desired width
                    height: 200, // Set your desired height
                    child: Image.asset(
                      _currentImagePath,
                      fit: BoxFit.fill, // Adjust how the image fits the container
                    ),
                  )
                : const CircularProgressIndicator(), // Show loading indicator if no image
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _storeOrderInFirestore();
                _showPurchaseSuccessMessage(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, 
                backgroundColor: const Color(0xFFB2EE32),   // Button text color
                textStyle: GoogleFonts.montserrat(fontSize: 16), // Button text style
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding inside the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
              child: Text('Confirm Order'),
            ),
          ],
        ),
      ),
    );
  }
}
