import 'dart:math';

import 'grid.dart';
import 'plot.dart';

class FeatureBuilder {
  final Random _rng = new Random();
  final Grid land;
  final PlotState state;
  final int startHeight;
  final int count;

  FeatureBuilder(this.land, this.state, this.startHeight, this.count) {

    for (int i = 0; i < count; i++) {
      int spx = _rng.nextInt(land.width);
      int spy = _rng.nextInt(land.width);
      int height = _rng.nextInt(startHeight);

      drawPoint(spx + 1, spy + 1, height);
      drawPoint(spx - 1, spy - 1, height);
      drawPoint(spx - 1, spy, height);
      drawPoint(spx, spy, height);
      drawPoint(spx + 1, spy, height);
      drawPoint(spx + 1, spy - 1, height);
      drawPoint(spx, spy + 1, height);
      drawPoint(spx - 1, spy + 1, height);
      drawPoint(spx, spy - 1, height);
    }
  }

  void drawPoint(int x, int y, int c) {
    if (x < 0 || y < 0 || x > land.width - 1 || y > land.width - 1) return;

    land.data[x][y]
      ..height = c
      ..state = state
      ..nextState = state;

    if (Vary3()) c--;
    if (c > 0) {
      if (Vary2()) drawPoint(x + 1, y - 1, c);
      if (Vary2()) drawPoint(x, y - 1, c);
      if (Vary2()) drawPoint(x - 1, y - 1, c);

      if (Vary2()) drawPoint(x - 1, y, c);
      if (Vary2()) drawPoint(x, y, c);
      if (Vary2()) return;
      if (Vary2()) drawPoint(x + 1, y, c);

      if (Vary2()) drawPoint(x + 1, y + 1, c);
      if (Vary2()) drawPoint(x, y + 1, c);
      if (Vary2()) drawPoint(x - 1, y + 1, c);
    }
  }

  bool Vary2() {
    return _rng.nextInt(7) == 1;
  }

  bool Vary3() {
    return _rng.nextInt(20) != 1;
  }
}