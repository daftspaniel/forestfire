// Copyright (c) 2017, daftspaniel. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'lib/forest.dart';

const int width = 2;
final CanvasElement ca = querySelector("#surface");
final CanvasRenderingContext2D c2d = ca.getContext("2d");

Forest trees = new Forest();
final InputElement fireControl = querySelector('#Fire');

void main() {
  print(trees);
  print(trees.width);
  fireControl.onChange.listen((e) {
    trees.fireChance = 100 - fireControl.valueAsNumber.toInt();
    print(trees.fireChance);
    print(trees.treeChance);
  });


  new Timer.periodic(new Duration(milliseconds: 1000), (timer) {
    trees.update();

    for (int x = 0; x < trees.width; x++)
      for (int y = 0; y < trees.width; y++)
        c2d
          ..fillStyle = trees.plots["$x-$y"].colour
          ..fillRect(x * width, y * width, width, width);
  });
}
