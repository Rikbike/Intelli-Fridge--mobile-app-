import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'view_files_screen.dart';

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
      // Obtén la lista de cámaras disponibles en el dispositivo.
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        // Selecciona la primera cámara de la lista (la cámara trasera).
        final firstCamera = cameras.first;

        _controller = CameraController(
          firstCamera,
          ResolutionPreset.high,
        );

        // Inicializa el controlador de la cámara.
        _initializeControllerFuture = _controller?.initialize();
        setState(() {});
      } else {
        print('No cameras available');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    // Asegúrate de limpiar el controlador de la cámara cuando se dispose el widget.
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
            // Si la inicialización está completa, muestra la vista previa de la cámara.
            return CameraPreview(_controller!);
          } else {
            // De lo contrario, muestra un indicador de carga.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
