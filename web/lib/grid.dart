import 'plot.dart';

class Grid {
  final List<List<Plot>> data = new List();
  final int width = 180;

  Grid(Function getTreeChance, Function getFireChance) {
    for (int i = 0; i < width; i++) {
      List<Plot> row = new List();
      for (int j = 0; j < width; j++) {
        Plot p = new Plot();
        p
          ..x = i
          ..y = j
          ..getTreeChance = getTreeChance
          ..getFireChance = getFireChance
          ..biome = this;

        row.add(p);
      }
      data.add(row);
    }
  }
}