import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Add this import

import 'package:animated_text_kit/animated_text_kit.dart';
import 'HomePage.dart'; // Import the HomePage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: StartPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool showHomePage = false;

  @override
  void initState() {
    super.initState();
    // Start a timer to show the HomePage after 12 seconds
    Future.delayed(Duration(seconds: 13), () {
      setState(() {
        showHomePage = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child: showHomePage
            ? HomePage() // Show the HomePage
            : Container( // Your existing StartPage content
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24.4, top: 0.20 * MediaQuery.of(context).size.height, right: 24.4),
                child: TypewriterAnimatedTextKit(
                  totalRepeatCount: 1,
                  speed: Duration(milliseconds: 100),
                  text: [
                    'Welcome....\nuser..\n______________..\nLet the Sharing Begin\n..\n..\n',
                    ' ',
                    '...\n_\n_\n  WebShare...',
                  ],
                  textStyle: TextStyle(fontSize: 24, color: Color(0xFF9AD003)),
                ),
              ),
              Spacer(), // Push the following content to the bottom
              Center(
                child: SizedBox(
                  width: 387,
                  height: 323,
                  child: Image.asset('assets/startpage.gif'), // Replace 'startpage.gif' with your actual GIF asset path
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
