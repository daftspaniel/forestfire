import 'plot.dart';

class Grid {
  final List<List<Plot>> data = new List.generate(180, (_) => new List<Plot>());
  final int width = 180;

  Grid(Function getTreeChance, Function getFireChance) {
    List<Plot> row;
    for (int i = 0; i < width; i++) {
      row = data[i];
      for (int j = 0; j < width; j++)
        row.add(new Plot(i, j, getTreeChance, getFireChance, this));

      data.add(row);
    }
  }
}