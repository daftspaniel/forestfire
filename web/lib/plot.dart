import 'common.dart';


class Plot {

  int x, y;
  Map Environment;
  TreeState state = TreeState.empty;
  TreeState nextState = TreeState.empty;

  Plot(this.x, this.y, this.Environment) {
    if (isTree()) {
      state = TreeState.tree;
    }
  }

  bool isTree() {
    int tree = rng.nextInt(2);
    return tree == 1;
  }


  bool isFire() {
    int fire = rng.nextInt(10000);
    return fire == 1;
  }

  void update() {
    if (state == TreeState.burning)
      nextState = TreeState.empty;
    else if (state == TreeState.tree && isNeighbourBurning())
      nextState = TreeState.burning;
    else if (state == TreeState.tree && isFire())
      nextState = TreeState.burning;
    else if (state == TreeState.empty && isTree())
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