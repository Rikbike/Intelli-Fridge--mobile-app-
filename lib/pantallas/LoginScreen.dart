import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _incrementFailedAttempts(String email) async {
    DocumentReference userDoc = _firestore.collection('Usuarios').doc(email);
    DocumentSnapshot doc = await userDoc.get();
    if (doc.exists) {
      int failedAttempts = (doc.data() as Map<String, dynamic>)['failedAttempts'] ?? 0;
      await userDoc.update({'failedAttempts': failedAttempts + 1});
    } else {
      await userDoc.set({'failedAttempts': 1});
    }
  }

  Future<void> _resetFailedAttempts(String email) async {
    DocumentReference userDoc = _firestore.collection('Usuarios').doc(email);
    await userDoc.update({'failedAttempts': 0});
  }

  Future<int> _getFailedAttempts(String email) async {
    DocumentReference userDoc = _firestore.collection('Usuarios').doc(email);
    DocumentSnapshot doc = await userDoc.get();
    if (doc.exists) {
      return (doc.data() as Map<String, dynamic>)['failedAttempts'] ?? 0;
    } else {
      return 0;
    }
  }

  Future<User?> _signInWithEmailAndPassword() async {
    try {
      final String email = _emailController.text.trim();
      final int failedAttempts = await _getFailedAttempts(email);

      if (failedAttempts >= 3) {
        _showErrorDialog('Cuenta temporalmente bloqueada. Intenta más tarde.');
        return null;
      }

      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: _passwordController.text.trim(),
      );
      await _resetFailedAttempts(email);
      return userCredential.user;
    } catch (error) {
      final String email = _emailController.text.trim();
      await _incrementFailedAttempts(email);
      print('Error en inicio de sesión con correo: $error');
      return null;
    }
  }

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        print('Google sign in aborted');
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (error) {
      print('Error en inicio de sesión con Google: $error');
      return null;
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50),
              Image.asset('imagenes/intelli2.jpg', height: 180),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Correo electrónico'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
                    _showErrorDialog('Por favor, complete todos los campos.');
                    return;
                  }

                  User? user = await _signInWithEmailAndPassword();
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } else {
                    _showErrorDialog('Error en el inicio de sesión con correo y contraseña.');
                  }
                },
                child: Text('Iniciar sesión'),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  User? user = await _signInWithGoogle();
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } else {
                    _showErrorDialog('Error en el inicio de sesión con Google.');
                  }
                },
                icon: Icon(Icons.login),
                label: Text('Iniciar sesión con Google'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
