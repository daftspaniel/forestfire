import 'dart:math';

import 'grid.dart';

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