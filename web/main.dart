// Copyright (c) 2017, daftspaniel. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'lib/forest.dart';
import 'lib/plot.dart';

final CanvasElement ca = querySelector("#surface");
final CanvasRenderingContext2D c2d = ca.getContext("2d");
final Forest myWoods = new Forest();

void main() {
  new Timer.periodic(new Duration(milliseconds: 1000), (timer) => drawAll());
}

drawAll() {
  myWoods.update();
  draw(myWoods);
}

void draw(Forest forest) {
  int w = forest.width;
  int r, g;
  int width = 16;

  for (int x = 0; x < w; x++) {
    for (int y = 0; y < w; y++) {
      Plot c = forest.plots["$x-$y"];

      if (c.state == TreeState.empty) {
        r = 0;
        g = 10;
      }
      else if (c.state == TreeState.tree) {
        r = 0;
        g = 255;
      }
      else if (c.state == TreeState.burning) {
        r = 255;
        g = 0;
        if (rng.nextInt(3) == 2) g = 128;
      }

      c2d
        ..fillStyle = "rgb($r,$g,0)"
        ..fillRect(x * width, y * width, width, width);
    }
  }
}
