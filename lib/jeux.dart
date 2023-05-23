import 'plateau.dart';
import 'dart:io';

class Jeu {
  Plateau _plateau = Plateau();

  Plateau getPlateau() {
    return this._plateau;
  }

  jouer() {
    this._plateau.generationSuivante();
  }

  reset() {
    this._plateau.reset();
  }
}
