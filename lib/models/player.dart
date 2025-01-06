int idC = 0;

class Player {
  Player(this.name) : id = idC++;
  final int id;
  final String name;
  int points = 0;
  bool isImposter = false;
}
