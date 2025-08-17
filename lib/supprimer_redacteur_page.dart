import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupprimerRedacteurPage extends StatelessWidget {
  final String redacteurId;

  const SupprimerRedacteurPage({super.key, required this.redacteurId});

  Future<void> _supprimerRedacteur(BuildContext context) async {
    await FirebaseFirestore.instance.collection('redacteurs').doc(redacteurId).delete();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Suppression réussie'),
        content: const Text('Le rédacteur a été supprimé avec succès.'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    ).then((_) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Supprimer le Rédacteur')),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Text('Êtes-vous sûr de vouloir supprimer ce rédacteur ?',
            style: TextStyle(fontSize: 18)),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
            onPressed: () => _supprimerRedacteur(context),
            child: const Text('Supprimer le rédacteur', style: TextStyle(fontSize: 18)),
          ),
          ],
        ),
      ),
    );
  }
}