import 'package:flutter/material.dart';
import 'dart:async';
import 'jeux.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Jeu jeu = Jeu();

  void initco() {
    var duration = const Duration(seconds: 1);
    setState(() {
      jeu.reset();
      jeu.getPlateau().initCoordonnees();
    });
    jeu.getPlateau().afficherPlateau();

    int counter = 0;
    Timer.periodic(duration, (Timer timer) {
      setState(() {
        jeu.jouer();
      });
      counter++;

      if (counter >= 1000) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(16.0), // Ajoutez le padding souhaité ici
        child: Container(
          width: (30 * jeu.getPlateau().getTab().length).toDouble(), // Largeur totale de la grille
          height: (30 * jeu.getPlateau().getTab().length).toDouble(), // Hauteur totale de la grille
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 0, // Espace horizontal entre les cases
            runSpacing: 0, // Espace vertical entre les cases
            children: List.generate(
              jeu.getPlateau().getTab().length, // Nombre de lignes
              (int rowIndex) => Row(
                children: List.generate(
                  jeu.getPlateau().getTab()[rowIndex].length, // Nombre de colonnes
                  (int colIndex) {
                    bool estVivant = jeu
                        .getPlateau()
                        .getTab()[rowIndex][colIndex]
                        .getetat(); // Obtenez l'état de la case aux indices donnés

                    return Container(
                      width: 30, // Largeur de la case (plus petite valeur)
                      height: 30, // Hauteur de la case (plus petite valeur)
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black, // Couleur de la bordure
                          width: 1.0, // Largeur de la bordure
                        ),
                        color: estVivant ? Colors.grey : Colors.white, // Couleur de la case
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: initco,
        tooltip: 'Play',
        child: const Icon(Icons.play_arrow),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
