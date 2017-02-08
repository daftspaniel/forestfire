// Copyright (c) 2017, daftspaniel. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'lib/common.dart';
import 'lib/forest.dart';

var ce;
var c2d;

Forest myWoods = new Forest();

void main() {
  ce = querySelector('#surface');
  c2d = ce.getContext("2d");

  //new Timer.periodic(new Duration(milliseconds: 1000), (timer) => updateAll());
  new Timer.periodic(new Duration(milliseconds: 1000), (timer) => drawAll());
}

updateAll() {

}

drawAll() {
  myWoods.update();
  draw(myWoods);
}

// Draw out all cells in the culture.
void draw(Forest forest) {
  int w = forest.width;
  int r, g, b;
  int width = 16;

  for (int x = 0; x < w; x++) {
    for (int y = 0; y < w; y++) {
      var c = forest.plots["$x-$y"];

      if (c.state == TreeState.empty) {
        r = 0;
        g = 100;
        b = 0;
      }
      if (c.state == TreeState.tree) {
        r = 0;
        g = 255;
        b = 0;
      }
      if (c.state == TreeState.burning) {
        r = 255;
        g = 0;
        b = 0;
      }
      c2d
        ..fillStyle = "rgb($r,$g,$b)"
        ..fillRect(x * width, y * width, width, width);
    }
  }
}
