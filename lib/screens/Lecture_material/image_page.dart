import 'package:learning_thrive/api/firebase_api.dart';
import 'package:learning_thrive/model/firebase_file.dart';
import 'package:flutter/material.dart';
import 'package:learning_thrive/api/firebase_api.dart';

class ImagePage extends StatelessWidget {
  final FirebaseFile file;

  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isImage = ['.jpeg', '.jpg', '.png', '.pdf'].any(file.name.contains);

    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () async {
              await FirebaseApi1.downloadFile(file.ref);

              final snackBar = SnackBar(
                content: Text('Downloaded ${file.name}'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: isImage
          ? Image.network(
              file.url,
              height: double.infinity,
              fit: BoxFit.cover,
            )
          : const Center(
              child: Text(
                'Cannot be displayed',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
