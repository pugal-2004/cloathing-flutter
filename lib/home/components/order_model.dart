class Order {
  final String size;
  final int quantity;
  final double totalPrice;
  final String imagePath; // Add this line

  Order({
    required this.size,
    required this.quantity,
    required this.totalPrice,
    required this.imagePath, // Add this line
  });
}
