import 'dart:math';

import 'featurebuilder.dart';
import 'grid.dart';
import 'plot.dart';

class Forest {

  Grid land;

  final Random rng = new Random();

  get width => land.width;

  bool _active = true;
  int _treeChance = 43;
  int _fireChance = 6000;

  set treeChance(int val) {
    _treeChance = val;
  }

  set fireChance(int val) {
    _fireChance = val * 200;
  }

  bool get active => _active;

  set active(bool val) => _active = val;

  int getTreeChance() => _treeChance;

  int getFireChance() => _fireChance;

  Forest() {
    reset();
  }

  void reset() {
    land = new Grid(getTreeChance, getFireChance);
    print("world created");
    //water
    new FeatureBuilder(
        land, PlotState.water, 10 + rng.nextInt(4), 6 + rng.nextInt(4));
    print("water created");
    new FeatureBuilder(
        land, PlotState.stone, 15 + rng.nextInt(10), 3 + rng.nextInt(4));
    print("stone created");
  }

  void update() {
    for (int i = 0; i < land.width; i++)
      for (int j = 0; j < land.width; j++)
        land.data[i][j].update();

    for (int i = 0; i < land.width; i++)
      for (int j = 0; j < land.width; j++)
        land.data[i][j].commit();
  }
}
