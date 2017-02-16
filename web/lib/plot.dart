import 'dart:math';

import 'grid.dart';

final Random rng = new Random();
enum PlotState { empty, tree, burning, embers }

const String Empty = "rgb(68, 109, 42)";
const String Tree = "rgb(0,255,0)";
const String YellowFire = "rgb(255,120,0)";
const String RedFire = "rgb(255,0,0)";

class Plot {

  int x, y;
  Grid biome;
  Function getFireChance;
  Function getTreeChance;

  PlotState state = PlotState.empty;
  PlotState nextState = PlotState.empty;
  int treeAge = 0;

  Plot() {}

  void init() {
    if (isNewTree()) {
      state = PlotState.tree;
      treeAge = rng.nextInt(255);
    }
  }

  get colour {
    if (state == PlotState.tree) return "rgb(0,${110 + min(treeAge, 165)},0)";
    if (state == PlotState.empty) return Empty;
    if (state == PlotState.embers) return YellowFire;

    return "rgb(${155 + rng.nextInt(100)},${12 + rng.nextInt(123)},0)";
  }

  bool isNewTree() => rng.nextInt(getTreeChance()) == 1;

  bool isCatchingFire() => treeAge > 20 && rng.nextInt(getFireChance()) == 1;

  bool isCatchingFireFromNeighbour() =>
      rng.nextInt(8) > 1 && getBurningNeighbourCount() > 0;

  void update() {
    if (state == PlotState.burning)
      nextState = PlotState.embers;
    else if (state == PlotState.embers)
      nextState = PlotState.empty;
    else if (state == PlotState.tree && isCatchingFireFromNeighbour()) {
      nextState = PlotState.burning;
      treeAge = 0;
    }
    else if (state == PlotState.tree && isCatchingFire()) {
      treeAge = 0;
      nextState = PlotState.burning;
    }
    else if (state == PlotState.empty && isNewTree()) {
      treeAge = 0;
      nextState = PlotState.tree;
    }

    if (state == PlotState.tree) treeAge++;
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
    int width = biome.width - 1;
    if (nx < 0 || ny < 0 || nx > width || ny > width) return false;
    return biome.data[nx][ny].state == PlotState.burning;
  }
}