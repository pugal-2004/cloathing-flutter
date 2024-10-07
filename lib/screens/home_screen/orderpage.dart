import 'package:cloth/home/components/order_provider.dart';
import 'package:cloth/screens/home_screen/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Previous Orders'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: orderProvider.orders.isEmpty
          ? const Center(
              child: Text(
                'No orders placed yet.',
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: orderProvider.orders.length,
              itemBuilder: (context, index) {
                final order = orderProvider.orders[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    color: Colors.grey[850],
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: Image.asset(
                        order.imagePath,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        'Size: ${order.size}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Quantity: ${order.quantity}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: Text(
                        'Total: \$${order.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Navigate to CartPage with order details
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(
                              imagePath: order.imagePath, // Pass the image path
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
