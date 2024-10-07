import 'package:flutter/material.dart';

import 'order_model.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  // Getter to retrieve the list of orders
  List<Order> get orders => _orders;

  // Method to add a new order
  void addOrder(Order order) {
    _orders.add(order); // Add the order to the list
    notifyListeners();   // Notify listeners to update the UI
  }
}
