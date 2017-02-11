import 'dart:math';

final Random rng = new Random();
enum PlotState { empty, tree, burning }

const String Empty = "rgb(68, 109, 42)";
const String Tree = "rgb(0,255,0)";
const String YellowFire = "rgb(255,120,0)";
const String RedFire = "rgb(255,0,0)";

class Plot {

  final int x, y;
  final Map<String, Plot> biome;
  final Function getFireChance;
  final Function getTreeChance;

  PlotState state = PlotState.empty;
  PlotState nextState = PlotState.empty;

  Plot(this.x, this.y,
      this.biome,
      this.getTreeChance,
      this.getFireChance) {
    if (isNewTree()) state = PlotState.tree;
  }

  get colour {
    if (state == PlotState.tree) return Tree;
    if (state == PlotState.empty) return Empty;

    if (rng.nextInt(3) == 2)
      return YellowFire;
    else
      return RedFire;
  }

  bool isNewTree() {
    return rng.nextInt(getTreeChance()) == 1;
  }

  bool isCatchingFire() {
    return rng.nextInt(getFireChance()) == 1;
  }

  void update() {
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
    Plot t = biome["$nx-$ny"];
    if (t == null) return false;
    return t.state == PlotState.burning;
  }
}