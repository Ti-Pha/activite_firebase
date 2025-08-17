import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ModifierRedacteurPage extends StatefulWidget {
  final String redacteurId;
  final Map<String, dynamic> redacteurData;

  const ModifierRedacteurPage({
    super.key,
    required this.redacteurId,
    required this.redacteurData,
  });

  @override
  _ModifierRedacteurPageState createState() => _ModifierRedacteurPageState();
}

class _ModifierRedacteurPageState extends State<ModifierRedacteurPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TextEditingController _nomController;
  late TextEditingController _specialiteController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.redacteurData['nom']);
    _specialiteController = TextEditingController(text: widget.redacteurData['specialite']);
  }

  Future<void> _enregistrerModifications() async {
    final modifications = {
      'nom': _nomController.text,
      'specialite': _specialiteController.text,
    };

    await _firestore.collection('redacteurs').doc(widget.redacteurId).update(modifications);
    _afficherSuccessDialog();
  }

  void _afficherSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modification réussie'),
        content: const Text('Les informations du rédacteur ont été mises à jour.'),
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
  void dispose() {
    _nomController.dispose();
    _specialiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modifier le Rédacteur')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nomController,
              decoration: const InputDecoration(
                labelText: 'Nom de rédacteur',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _specialiteController,
              decoration: const InputDecoration(
                labelText: 'Spécialité de rédacteur',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _enregistrerModifications,
              child: const Text('Enregistrer les modifications', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}