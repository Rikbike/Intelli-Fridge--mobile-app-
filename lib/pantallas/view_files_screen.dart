// view_files_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ViewFilesScreen extends StatelessWidget {
  Future<List<Map<String, dynamic>>> _loadFiles() async {
    List<Map<String, dynamic>> files = [];
    final ListResult result = await FirebaseStorage.instance.ref('uploads').listAll();
    for (var ref in result.items) {
      final String url = await ref.getDownloadURL();
      final FullMetadata meta = await ref.getMetadata();
      files.add({
        'url': url,
        'name': meta.name,
        'contentType': meta.contentType,
      });
    }
    return files;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotos y Videos'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final file = snapshot.data![index];
                  return ListTile(
                    leading: file['contentType'].contains('image')
                        ? Image.network(file['url'])
                        : Icon(Icons.videocam),
                    title: Text(file['name']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(file['url']),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return Center(child: Text('No files found'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String fileUrl;

  DetailScreen(this.fileUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle'),
      ),
      body: Center(
        child: fileUrl.contains('image')
            ? Image.network(fileUrl)
            : Text('Video URL: $fileUrl'), // Puedes usar un reproductor de video aquí
      ),
    );
  }
}
