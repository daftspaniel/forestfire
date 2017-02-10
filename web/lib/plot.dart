import 'dart:math';

final Random rng = new Random();
enum TreeState { empty, tree, burning }

class Plot {

  int x, y;
  Map Environment;
  TreeState state = TreeState.empty;
  TreeState nextState = TreeState.empty;
  
  bool isNewTree() => rng.nextInt(43) == 1;
  bool isCatchingFire() => rng.nextInt(6000) == 1;

  Plot(this.x, this.y, this.Environment) {
    if (isNewTree()) {
      state = TreeState.tree;
    }
  }

  void update() {
    if (state == TreeState.burning)
      nextState = TreeState.empty;
    else if (state == TreeState.tree && isNeighbourBurning())
      nextState = TreeState.burning;
    else if (state == TreeState.tree && isCatchingFire())
      nextState = TreeState.burning;
    else if (state == TreeState.empty && isNewTree())
      nextState = TreeState.tree;
  }

  bool isNeighbourBurning() {
    return getBurningNeighbourCount() > 0;
  }

  void commit() {
    state = nextState;
  }

  int getBurningNeighbourCount() {
    int n = 0;

    if (isNeighbourOnFire(x - 1, y - 1)) n++;
    if (isNeighbourOnFire(x, y - 1)) n++;
    if (isNeighbourOnFire(x + 1, y - 1)) n++;

    if (isNeighbourOnFire(x - 1, y)) n++;

    if (n > 0) return n;

    if (isNeighbourOnFire(x + 1, y)) n++;

    if (isNeighbourOnFire(x - 1, y + 1)) n++;
    if (isNeighbourOnFire(x, y + 1)) n++;
    if (isNeighbourOnFire(x + 1, y + 1)) n++;

    return n;
  }

  bool isNeighbourOnFire(int nx, int ny) {
    Plot t = Environment["$nx-$ny"];
    if (t == null) return false;
    return t.state == TreeState.burning;
  }
}