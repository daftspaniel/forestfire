class block {}

class point {
  int x;
  int y;

  point(this.x, this.y);
}

main() {
  Map<String, block> testMap = new Map();
  List<List> testLol = new List();
  List<point> dataPoints = new List();
  Stopwatch watch;

  print("Set up maps.");
  for (int i = 0; i < 100; i++)
    for (int j = 0; j < 100; j++) {
      testMap["$j-$i"] = new block();
      dataPoints.add(new point(j, i));
    }

  print("Set up list of lists.");
  for (int i = 0; i < 100; i++) {
    List<block> row = new List();
    for (int j = 0; j < 100; j++) {
      row.add(new block());
    }
    testLol.add(row);
  }

  dataPoints.shuffle();

  print("Run tests.");
  watch = new Stopwatch();
  watch.start();
  for (int j = 0; j < 8000; j++) {
    dataPoints.forEach((p) => testMap["${p.x}-${p.y}"]);
  }
  watch.stop();
  print("${watch.elapsed}");

  watch = new Stopwatch();
  watch.start();
  for (int j = 0; j < 8000; j++) {
    dataPoints.forEach((p) => testLol[p.x][p.y]);
  }
  watch.stop();
  print("${watch.elapsed}");
}