import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'A Functions.dart';
import 'case.dart';

class Plateau {
  List<List<Case>> _plateau = List.generate(25, (i) => List.generate(25, (j) => Case(false)));
  Plateau();

  List<List<Case>> getTab() {
    return this._plateau;
  }

  afficherPlateau() {
    print("");
    stdout.write(" ┏━━━━━━━━━━━━━━━━━━━━━┓ ");
    print("");
    for (int i = 0; i < this._plateau.length; i++) {
      stdout.write(" ┃ ");
      for (int j = 0; j < this._plateau[i].length; j++) {
        if (this._plateau[i][j].getetat() == true) {
          stdout.write("● ");
        } else {
          stdout.write("  "); //○
        }
      }
      stdout.write("┃ ");
      print("");
    }
    stdout.write(" ┗━━━━━━━━━━━━━━━━━━━━━┛ ");
  }

  initCoordonnees() {
    //LIGNE
    // this._plateau[1][0].changeetat();
    // this._plateau[1][1].changeetat();
    // this._plateau[1][2].changeetat();

    //FORME DE TETRIS INFINIE
    // this._plateau[5][4].changeetat();
    // this._plateau[5][5].changeetat();
    // this._plateau[5][6].changeetat();
    // this._plateau[6][5].changeetat();

    //DIAGONALE
    // this._plateau[0][0].changeetat();
    // this._plateau[1][1].changeetat();
    // this._plateau[2][2].changeetat();
    // this._plateau[3][3].changeetat();
    // this._plateau[4][4].changeetat();
    // this._plateau[5][5].changeetat();
    // this._plateau[6][6].changeetat();
    // this._plateau[7][7].changeetat();
    // this._plateau[8][8].changeetat();
    // this._plateau[9][9].changeetat();
    // this._plateau[10][10].changeetat();
    // this._plateau[11][11].changeetat();
    // this._plateau[12][12].changeetat();
    // this._plateau[13][13].changeetat();

    //NAVIRE
    this._plateau[3][0].changeetat();
    this._plateau[3][1].changeetat();
    this._plateau[3][2].changeetat();
    this._plateau[2][2].changeetat();
    this._plateau[1][1].changeetat();
  }

  List<List<Case>> transfer(List<List<Case>> plat1, List<List<Case>> plat2) {
    for (int i = 0; i < plat1.length; i++) {
      for (int j = 0; j < plat1[i].length; j++) {
        plat2[i][j].clone(plat1[i][j].getetat());
      }
    }
    return plat2;
  }

  int nombreVoisin(int x, int y) {
    List<List<Case>> plateauu =
        List.generate(this._plateau.length + 2, (i) => List.generate(this._plateau.length + 2, (j) => Case(false)));
    for (int i = 0; i < this._plateau.length; i++) {
      for (int j = 0; j < this._plateau[i].length; j++) {
        plateauu[i + 1][j + 1] = this._plateau[i][j];
      }
    }

    int nbvoisins = 0;
    x += 1;
    y += 1;
    //print("Analyse de la case ${x};${y}");
    if (plateauu[x - 1][y + 1].getetat() == true) {
      // ↗
      nbvoisins++;
      // print("Un voisin en ${x - 1};${y + 1}");
    }
    if (plateauu[x + 1][y + 1].getetat() == true) {
      // ↘
      nbvoisins++;
      //  print("Un voisin en ${x + 1};${y + 1}");
    }
    if (plateauu[x - 1][y - 1].getetat() == true) {
      // ↖
      nbvoisins++;
      //  print("Un voisin en ${x - 1};${y - 1}");
    }
    if (plateauu[x + 1][y - 1].getetat() == true) {
      // ↙
      nbvoisins++;
      //  print("Un voisin en ${x + 1};${y - 1}");
    }
    if (plateauu[x][y - 1].getetat() == true) {
      // ⬅
      nbvoisins++;
      //  print("Un voisin en ${x};${y - 1}");
    }
    if (plateauu[x][y + 1].getetat() == true) {
      // ➡
      nbvoisins++;
      //  print("Un voisin en ${x};${y + 1}");
    }
    if (plateauu[x - 1][y].getetat() == true) {
      // ⬆
      nbvoisins++;
      //  print("Un voisin en ${x - 1};${y}");
    }
    if (plateauu[x + 1][y].getetat() == true) {
      // ⬇
      nbvoisins++;
      //  print("Un voisin en ${x + 1};${y}");
    }
    // print("Voisins totaux : ${nbvoisins}\n------------------------------------------");
    return nbvoisins;
  }

  List<List<Case>> generationSuivante() {
    List<List<Case>> platempo =
        transfer(this._plateau, List.generate(25, (i) => List.generate(this._plateau.length, (j) => Case(false))));
    for (int i = 0; i < this._plateau.length; i++) {
      for (int j = 0; j < this._plateau[i].length; j++) {
        if (this._plateau[i][j].getetat() == false) {
          if (nombreVoisin(i, j) == 3) {
            platempo[i][j].changeetat();
          }
        }
        if (this._plateau[i][j].getetat() == true) {
          if (nombreVoisin(i, j) != 2 && nombreVoisin(i, j) != 3) {
            platempo[i][j].changeetat();
          }
        }
      }
    }
    transfer(platempo, this._plateau);
    return this._plateau;
  }

  void reset() {
    this._plateau = List.generate(this._plateau.length, (i) => List.generate(this._plateau.length, (j) => Case(false)));
  }
}
