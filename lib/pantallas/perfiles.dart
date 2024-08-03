import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilesScreen extends StatefulWidget {
  @override
  _PerfilesScreenState createState() => _PerfilesScreenState();
}

class _PerfilesScreenState extends State<PerfilesScreen> {
  final TextEditingController _perfilController = TextEditingController();
  final CollectionReference _perfilesCollection = FirebaseFirestore.instance.collection('perfiles');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _addPerfil(String perfil) async {
    String userId = _auth.currentUser?.uid ?? '';
    await _perfilesCollection.add({
      'perfil': perfil,
      'ID_Usuario': userId,
      'fechaCreación': Timestamp.now(),
    });
    _perfilController.clear();
  }

  Future<void> _deletePerfil(DocumentSnapshot doc) async {
    await _perfilesCollection.doc(doc.id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfiles'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Lista de Perfiles',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _perfilesCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No hay perfiles disponibles.'));
                  }

                  final perfiles = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: perfiles.length,
                    itemBuilder: (context, index) {
                      final perfil = perfiles[index];
                      final perfilData = perfil.data() as Map<String, dynamic>;

                      return ListTile(
                        title: Text(perfilData['perfil']),
                        //subtitle: Text('Usuario ID: ${perfilData['ID_Usuario']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deletePerfil(perfil),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _perfilController,
                decoration: InputDecoration(
                  labelText: 'Nuevo Perfil',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_perfilController.text.isNotEmpty) {
                  _addPerfil(_perfilController.text);
                }
              },
              child: Text('Añadir Nuevo Perfil'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
