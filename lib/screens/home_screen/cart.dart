import 'package:cloth/home/components/order_model.dart' as order_model; // Create an alias
import 'package:cloth/home/components/order_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  final String imagePath;
  final double pricePerItem = 20.0; // Set a fixed price per item for this example

  const CartPage({super.key, required this.imagePath});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String selectedSize = 'M'; // Default size
  int quantity = 1; // Default quantity
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.pricePerItem;
  }

  void _updateTotalPrice() {
    setState(() {
      totalPrice = widget.pricePerItem * quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Cart Page'),
      ),
      backgroundColor: Colors.black, // Black background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.imagePath,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            _buildSizeSelection(),
            const SizedBox(height: 20),
            _buildQuantitySelector(),
            const SizedBox(height: 20),
            _buildTotalPriceDisplay(),
            const SizedBox(height: 20),
            _buildBuyNowButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ['S', 'M', 'L', 'XL'].map((size) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ChoiceChip(
            label: Text(
              size,
              style: TextStyle(
                color: selectedSize == size ? Colors.white : Colors.grey,
              ),
            ),
            selected: selectedSize == size,
            onSelected: (bool selected) {
              setState(() {
                selectedSize = size;
              });
            },
            selectedColor: Colors.blue,
            backgroundColor: Colors.grey[800],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: quantity > 1
              ? () {
                  setState(() {
                    quantity--;
                    _updateTotalPrice();
                  });
                }
              : null,
          icon: const Icon(Icons.remove, color: Colors.white),
        ),
        Text(
          '$quantity',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              quantity++;
              _updateTotalPrice();
            });
          },
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildTotalPriceDisplay() {
    return Text(
      'Total: \$${totalPrice.toStringAsFixed(2)}',
      style: const TextStyle(fontSize: 20, color: Colors.white),
    );
  }

  Widget _buildBuyNowButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showConfirmationDialog(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      child: const Text(
        'Buy Now',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Order'),
          content: const Text('Are you sure you want to place the order?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the confirmation dialog

                // Save order to Firestore and OrderProvider
                _saveOrderToFirestore(); // Save to Firestore
                Provider.of<OrderProvider>(context, listen: false).addOrder(
                  order_model.Order( // Use the alias here
                    size: selectedSize,
                    quantity: quantity,
                    totalPrice: totalPrice,
                    imagePath: widget.imagePath,
                  ),
                );

                _showThankYouDialog(context); // Show thank you dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thank You!'),
          content: const Text('Your order has been placed successfully.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the thank you dialog
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home',
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveOrderToFirestore() async {
    final firestore = FirebaseFirestore.instance;

    try {
      // Create a new order document in the 'cart order' collection
      await firestore.collection('cart order').add({
        'size': selectedSize,
        'quantity': quantity,
        'totalPrice': totalPrice,
        'imagePath': widget.imagePath,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Handle any errors (e.g., show a snackbar or log the error)
      print("Error saving order to Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to place the order. Please try again.'),
        ),
      );
    }
  }
}
