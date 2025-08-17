import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'modifier_redacteur_page.dart';
import 'supprimer_redacteur_page.dart';

class RedacteurInfoPage extends StatefulWidget {
  const RedacteurInfoPage({super.key});

  @override
  _RedacteurInfoPageState createState() => _RedacteurInfoPageState();
}

class _RedacteurInfoPageState extends State<RedacteurInfoPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste des Rédacteurs')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('redacteurs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final redacteurs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: redacteurs.length,
            itemBuilder: (context, index) {
              final data = redacteurs[index].data() as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  title: Text(data['nom']),
                  subtitle: Text('Spécialité: ${data['specialite']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ModifierRedacteurPage(
                              redacteurId: redacteurs[index].id,
                              redacteurData: data,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SupprimerRedacteurPage(redacteurId: redacteurs[index].id),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}