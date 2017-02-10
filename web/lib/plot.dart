import 'dart:math';

final Random rng = new Random();
enum PlotState { empty, tree, burning }

const String Empty = "rgb(0,10,0)";
const String Tree = "rgb(0,255,0)";
const String YellowFire = "rgb(255,120,0)";
const String RedFire = "rgb(255,0,0)";

class Plot {

  Plot(this.x, this.y, this.Environment) {
    if (isNewTree()) {
      state = PlotState.tree;
    }
  }

  int x, y;
  Map<String, Plot> Environment;
  int _treeChance = 2;
  int _fireChance = 0;

  PlotState state = PlotState.empty;
  PlotState nextState = PlotState.empty;

  get colour {
    if (state == PlotState.empty) return Empty;
    if (state == PlotState.tree) return Tree;

    if (rng.nextInt(3) == 2)
      return YellowFire;
    else
      return RedFire;
  }

  bool isNewTree() {
    return rng.nextInt(_treeChance) == 1;
  }

  bool isCatchingFire() {
    return rng.nextInt(_fireChance) == 1;
  }

  void update(int fireChance, int treeChance) {
    _treeChance = treeChance;
    _fireChance = fireChance;

    if (state == PlotState.burning)
      nextState = PlotState.empty;
    else if (state == PlotState.tree && isNeighbourBurning())
      nextState = PlotState.burning;
    else if (state == PlotState.tree && isCatchingFire())
      nextState = PlotState.burning;
    else if (state == PlotState.empty && isNewTree())
      nextState = PlotState.tree;
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
    return t.state == PlotState.burning;
  }
}