


import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerView extends StatefulWidget {
  @override
  _FilePickerViewState createState() => _FilePickerViewState();
}

class _FilePickerViewState extends State<FilePickerView> {
  List<File> files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('رفع الملفات'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(files.isEmpty ? 'no Filed added yet': files.first.path),
              Container(height: 10),
              TextButton.icon(
                onPressed: () async {
                  FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: false);

                  if(result != null) {
                    List<File> files = result.paths.map((path) => File(path)).toList();
                    setState(() {
                      this.files = files;
                    });
                  } else {
                    // User canceled the picker
                  }
                }, label: Text('تحميل الملف',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  )
              ),
                icon: Icon(Icons.upload_file, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
