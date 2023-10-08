import 'package:flutter/material.dart';
import 'RecievePage.dart'; // Import the ReceivePage
import 'SendPage.dart';  // Import Send Page

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1f7ea1), // Hex color value for the second color
              Colors.black, // Hex color value for the first color
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Your background design here
            Positioned(
              right: 25,
              bottom: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SendPage()), // Navigate to SendPage
                      );
                    },
                    child: Text('Send'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReceivePage()), // Navigate to ReceivePage
                      );
                    },
                    child: Text('Receive'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
