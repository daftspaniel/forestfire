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
    addWater();
    print("water created");
    addMountains();
    print("stone created");
  }

  void addWater() {
    new FeatureBuilder(
        land, PlotState.water, 20 + rng.nextInt(20), 6 + rng.nextInt(6));
  }

  void addMountains() {
    new FeatureBuilder(
        land, PlotState.stone, 20 + rng.nextInt(20), 6 + rng.nextInt(6));
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
