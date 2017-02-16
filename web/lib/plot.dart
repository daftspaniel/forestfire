import 'dart:math';

final Random rng = new Random();
enum PlotState { empty, tree, burning, ash }

const String Empty = "rgb(68, 109, 42)";
const String Tree = "rgb(0,255,0)";
const String YellowFire = "rgb(255,120,0)";
const String RedFire = "rgb(255,0,0)";
const String Ash = "rgb(50,50,50)";

class Plot {

  final int x, y;
  final Map<String, Plot> biome;
  final Function getFireChance;
  final Function getTreeChance;

  PlotState state = PlotState.empty;
  PlotState nextState = PlotState.empty;
  int treeAge = 0;

  Plot(this.x, this.y,
      this.biome,
      this.getTreeChance,
      this.getFireChance) {
    if (isNewTree()) {
      state = PlotState.tree;
      treeAge = rng.nextInt(76);
    }
  }

  get colour {
    if (state == PlotState.tree) return "rgb(0,${128 + min(treeAge, 127)},0)";
    if (state == PlotState.empty) return Empty;
    if (state == PlotState.ash) return Ash;

    return "rgb(${55 + rng.nextInt(200)},${12 + rng.nextInt(123)},0)";
  }

  bool isNewTree() {
    return rng.nextInt(getTreeChance()) == 1;
  }

  bool isCatchingFire() {
    return rng.nextInt(getFireChance()) == 1;
  }

  void update() {
    if (state == PlotState.burning)
      nextState = PlotState.ash;
    else if (state == PlotState.ash)
      nextState = PlotState.empty;
    else if (state == PlotState.tree && rng.nextInt(8)>1 && isNeighbourBurning()) {
      nextState = PlotState.burning;
      treeAge = 0;
    }
    else if (state == PlotState.tree && treeAge > 40 && isCatchingFire()) {
      treeAge = 0;
      nextState = PlotState.burning;
    }
    else if (state == PlotState.empty && isNewTree()) {
      treeAge++;
      nextState = PlotState.tree;
    }

    if (state == PlotState.tree) treeAge++;
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