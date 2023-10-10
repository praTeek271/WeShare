import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RTransferPage extends StatelessWidget {
  final String scannedText;

  RTransferPage({required this.scannedText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RTransfer Page"),
      ),
      body: WebView(
        initialUrl: scannedText,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
