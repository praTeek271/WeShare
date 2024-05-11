import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class SendPage extends StatefulWidget {
  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  List<File> selectedFiles = [];

  Future<void> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = (result.paths ?? []).where((path) => path != null).map((path) => File(path!)).toList();

      setState(() {
        selectedFiles.addAll(files);
      });
    }
  }

  void removeFile(int index) {
    setState(() {
      selectedFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Files'),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Add_files.gif'), // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: selectedFiles.map((file) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Color(0x3DECEBE8), // Purple background color
                      ),
                      child: ListTile(
                        title: Text(
                          file.path.split('/').last, // Display only the file name
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.highlight_remove_rounded),
                          onPressed: () => removeFile(selectedFiles.indexOf(file)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: openFilePicker,
                    child: Icon(Icons.add),
                  ),
                  SizedBox(width: 16.0),
                  FloatingActionButton(
                    onPressed: () {
                      // Implement send functionality
                    },
                    child: Icon(
                      Icons.send,
                      color: Color(0xCABAFAEA),
                      size: 24.0,
                    ),
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
