import 'dart:math';

import 'plot.dart';

class Forest {
  Map<String, Plot> plots = {};
  int width = 180;
  Random rng = new Random();
  int _treeChance = 43;
  int _fireChance = 6000;

  set treeChance(int val) {
    _treeChance = val;
  }

  set fireChance(int val) {
    _fireChance = val * 200;
  }

  int get treeChance => _treeChance;

  int get fireChance => _fireChance;

  Forest() {
    for (int x = 0; x < width; x++)
      for (int y = 0; y < width; y++)
        plots["$x-$y"] = new Plot(x, y, plots);
  }

  void update() {
    plots.forEach((k, c) => c.update(fireChance, treeChance));
    plots.forEach((k, c) => c.commit());
  }
}