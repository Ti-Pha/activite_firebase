import 'package:flutter/material.dart';
import 'ajout_redacteur_page.dart';
import 'redacteur_info_page.dart';

class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Magazine Infos')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ), // Correction ici
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Ajouter un Rédacteur'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AjoutRedacteurPage())),
            ), // Correction ici
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Informations des Rédacteurs'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RedacteurInfoPage())),
            ), // Correction ici
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PartieTitre(),
            Image.asset('assets/couverture.jpg', height: 200, fit: BoxFit.cover),
            const PartieTexte(),
            const PartieIcone(),
            const PartieRubrique()
          ],
        ),
      ),
    );
  }
}

// Widgets réutilisables
class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Bienvenue au Magazine Infos', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Votre magazine numérique, source d\'inspiration', textAlign: TextAlign.center)
        ],
      ),
    );
  }
}

class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        'Magazine Infos est bien plus qu\'un simple magazine. C\'est une plateforme complète sur l\'entreprise et le développement économique.',
        textAlign: TextAlign.center,
      ),
    );
  }
}

class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(children: [Icon(Icons.phone), Text('TEL')]),
        Column(children: [Icon(Icons.mail), Text('MAIL')]),
        Column(children: [Icon(Icons.share), Text('PARTAGE')])
      ],
    );
  }
}

class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(4, (index) => Image.asset('assets/rubrique_$index.jpg')),
    );
  }
}