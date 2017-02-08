import 'dart:math';

import 'plot.dart';


class Forest {
  Map<String, Plot> plots = {};
  int width = 50;
  Random rng = new Random();

  Forest() {
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < width; y++) {
        plots["$x-$y"] = new Plot(x, y, plots);
      }
    }
  }

  void update() {
    plots.forEach((k, c) => c.update());
    plots.forEach((k, c) => c.commit());
  }
}

