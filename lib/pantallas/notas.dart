import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotasScreen extends StatefulWidget {
  @override
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  final TextEditingController _controller = TextEditingController();
  final CollectionReference _notasCollection = FirebaseFirestore.instance.collection('notas');

  void _addNota() async {
    if (_controller.text.isNotEmpty) {
      await _notasCollection.add({'Nota': _controller.text});
      _controller.clear();
    }
  }

  void _deleteNota(DocumentSnapshot doc) async {
    await _notasCollection.doc(doc.id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nueva Nota',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addNota,
              child: Text('Agregar Nota'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: _notasCollection.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!snapshot.hasData) {
                    return Text('No hay datos disponibles');
                  }

                  final List<DocumentSnapshot> documents = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final document = documents[index];
                      final nota = document.data() != null && (document.data()! as Map).containsKey('Nota')
                          ? document['Nota']
                          : 'Nota no disponible';

                      return ListTile(
                        title: Text(nota),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteNota(document),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
