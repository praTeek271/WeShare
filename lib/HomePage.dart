import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:web_share/RecievePage.dart';
import 'package:web_share/SendPage.dart';
import 'dart:async'; // Import the 'dart:async' package

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isConnected = true; // Set the initial state to connected

  @override
  void initState() {
    super.initState();

    // Check connectivity on widget initialization
    checkConnectivity();

    // Create a periodic timer to re-evaluate connectivity every 2-3 seconds
    Timer.periodic(const Duration(seconds: 7), (timer) {
      checkConnectivity();
    });
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      isConnected = connectivityResult != ConnectivityResult.none;
    });

    if (!isConnected) {
      // If not connected, show a notification and automatically remove it after 2 seconds.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please connect to Network',textAlign: TextAlign.center,),
          duration: const Duration(seconds: 2),
          backgroundColor: const Color(0xA0FFAAAA), // Change the background color
          behavior: SnackBarBehavior.floating, // Display the notification as a floating card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Add rounded corners to the notification
          ),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Your background design here
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Vide_ani_1.gif'), // Replace with your image asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 25,
            bottom: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (isConnected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SendPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('No Internet',textAlign: TextAlign.center,),
                          duration: const Duration(seconds: 2),
                          backgroundColor: const Color(0xD0E1BCA2), // Change the background color
                          behavior: SnackBarBehavior.floating, // Display the notification as a floating card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Add rounded corners to the notification
                          ),
                        ),
                      );

                    }
                  },
                  child: const Text('  Send  '),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (isConnected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReceivePage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('No Internet',textAlign: TextAlign.center,),
                          duration: const Duration(seconds: 2),
                          backgroundColor: const Color(0xA0E5C0A6), // Change the background color
                          behavior: SnackBarBehavior.floating, // Display the notification as a floating card
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Add rounded corners to the notification
                          ),
                        ),
                      );

                    }
                  },
                  child: const Text('    Receive   '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
