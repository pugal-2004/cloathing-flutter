import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFB2EE32),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/image2.jpeg'), // Make sure this image exists in your assets folder
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Mia Malkova',
              style: GoogleFonts.montserrat(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Ensure visibility against the background
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'mia@gmail.com',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.grey[700], // Darken the color for better visibility
              ),
            ),
            const SizedBox(height: 20),
            Divider(thickness: 2, color: Colors.grey[300]), // Make divider lighter for better contrast
            ListTile(
              leading: Icon(Icons.person_outline, color: Colors.grey[800]), // Darker icon for better visibility
              title: Text(
                'Edit Profile',
                style: GoogleFonts.montserrat(fontSize: 18, color: Colors.black), // Ensure text is visible
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                // Handle edit profile functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined, color: Colors.grey[800]),
              title: Text(
                'Settings',
                style: GoogleFonts.montserrat(fontSize: 18, color: Colors.black),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                // Handle settings functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.grey[800]),
              title: Text(
                'Log Out',
                style: GoogleFonts.montserrat(fontSize: 18, color: Colors.black),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                // Handle log out functionality
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      backgroundColor: Colors.white, // Set the background color to white for good contrast
    );
  }
}
