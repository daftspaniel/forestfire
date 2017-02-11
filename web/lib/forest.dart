import 'dart:math';

import 'plot.dart';

class Forest {
  final Map<String, Plot> plots = {};
  final int width = 180;
  final Random rng = new Random();

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
  set active(bool val) =>_active = val;

  int getTreeChance() => _treeChance;

  int getFireChance() => _fireChance;

  Forest() {
    reset();
  }

  void reset() {
    for (int x = 0; x < width; x++)
      for (int y = 0; y < width; y++)
        plots["$x-$y"] = new Plot(x, y, plots, getTreeChance, getFireChance);
  }

  void update() {
    plots.forEach((k, c) => c.update());
    plots.forEach((k, c) => c.commit());
  }
}