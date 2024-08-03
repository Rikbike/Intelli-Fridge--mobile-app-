import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'temperatura.dart';
import 'notas.dart';
import 'perfiles.dart';
import 'CamaraScreen.dart';
import 'LoginScreen.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  Future<void> _signOut(BuildContext context) async {
    await _authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intelli Fridge'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _signOut(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'imagenes/smartfr.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TemperatureHumidityWidget()),
                    );
                  },
                  icon: Icon(Icons.thermostat),
                  label: Text('Ver Temperatura'),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotasScreen()),
                    );
                  },
                  icon: Icon(Icons.note),
                  label: Text('Ver Notas'),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PerfilesScreen()),
                    );
                  },
                  icon: Icon(Icons.person),
                  label: Text('Ver Perfiles'),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CamaraScreen()),
                    );
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text('Ver Cámara'),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  icon: Icon(Icons.exit_to_app),
                  label: Text('Salir'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
