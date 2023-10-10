import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String url="https://prateek271.github.io/Drop_test_Proj_development/upload";
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0, // Remove the drop shadow
        automaticallyImplyLeading: false, // Hide the title
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: WebView(
        initialUrl:url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

