import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:path/path.dart' show basename;
import 'dart:io';

class CamaraScreen extends StatefulWidget {
  @override
  _CamaraScreenState createState() => _CamaraScreenState();
}

class _CamaraScreenState extends State<CamaraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        final firstCamera = cameras.first;

        _controller = CameraController(
          firstCamera,
          ResolutionPreset.high,
        );

        _initializeControllerFuture = _controller?.initialize();
        setState(() {});
      } else {
        print('No cameras available');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller?.takePicture();
      if (image != null) {
        final imageUrl = await _uploadFile(File(image.path));
        await _saveImageUrlToFirestore(imageUrl); // Guarda la URL en Firestore
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _recordVideo() async {
    try {
      await _initializeControllerFuture;
      await _controller?.startVideoRecording();
    } catch (e) {
      print('Error starting video recording: $e');
    }
  }

  Future<void> _stopVideoRecording() async {
    try {
      final video = await _controller?.stopVideoRecording();
      if (video != null) {
        final videoUrl = await _uploadFile(File(video.path));
        await _saveImageUrlToFirestore(videoUrl); // Guarda la URL en Firestore
      }
    } catch (e) {
      print('Error stopping video recording: $e');
    }
  }

  Future<String> _uploadFile(File file) async {
    final fileName = basename(file.path);
    final storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> _saveImageUrlToFirestore(String imageUrl) async {
    await FirebaseFirestore.instance.collection('uploads').add({
      'url': imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cámara')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Expanded(
                  child: CameraPreview(_controller!),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: _takePicture,
                    ),
                    IconButton(
                      icon: Icon(Icons.videocam),
                      onPressed: _recordVideo,
                    ),
                    IconButton(
                      icon: Icon(Icons.stop),
                      onPressed: _stopVideoRecording,
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
