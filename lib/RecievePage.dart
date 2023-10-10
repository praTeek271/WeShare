import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'RTransfer.dart';

class ReceivePage extends StatefulWidget {
  @override
  _ReceivePageState createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  TextEditingController urlController = TextEditingController();
  String scannedText = '';
  bool popupShown = false;
  bool showReceiveButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receive Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Dispose of the QR controller when leaving the page
            controller.dispose();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.blue,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 200,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: urlController,
                      decoration: InputDecoration(
                        labelText: 'Enter URL',
                        hintText: 'https://example.com',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  if (showReceiveButton)
                    InkWell(
                      onTap: () {
                        final urlText = urlController.text.trim();
                        if (urlText.isNotEmpty) {
                          // Navigate to RTransfer.dart with the URL text
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RTransferPage(scannedText: urlText),
                            ),
                          );
                        } else {
                          // No text in the URL text field, do nothing
                        }
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showConfirmationPopup() async {
    final confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Do you want to proceed with the scanned URL?'),
          actions: [
            TextButton(
              onPressed: () {
                // Unpause the scanning and dismiss the popup
                controller.resumeCamera();
                Navigator.of(context).pop(false);
              },
              child: Text('Retake'),
            ),
            TextButton(
              onPressed: () {
                // Pass the scanned text to the URL text field
                urlController.text = scannedText;
                setState(() {
                  popupShown = true;
                  showReceiveButton = true;
                });
                Navigator.of(context).pop(true);
              },
              child: Text('Proceed'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      // Scanned text has been added to the URL text field
    } else {
      // Scanned text not added, reset the state
      setState(() {
        scannedText = '';
        showReceiveButton = false;
      });
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print('Scanned QR Code: ${scanData.code}');
      setState(() {
        scannedText = scanData.code ?? '';
        popupShown = true;
        controller.pauseCamera(); // Pause scanning when text is extracted
      });
      _showConfirmationPopup();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
