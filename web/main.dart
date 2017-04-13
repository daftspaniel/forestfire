// Copyright (c) 2017, daftspaniel. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'lib/forest.dart';

const int drawPlotWidth = 2;
const int minHertz = 1;
const int maxHertz = 60;
final CanvasElement ca = querySelector("#surface");
final CanvasRenderingContext2D c2d = ca.getContext("2d");

final InputElement fireControl = querySelector('#Fire');
final InputElement treeControl = querySelector('#Tree');
final InputElement speedControl = querySelector('#Speed');
final ButtonElement startButton = querySelector('#Start');
final ButtonElement stopButton = querySelector('#Stop');
final ButtonElement resetButton = querySelector('#Reset');
final ButtonElement mountainsButton = querySelector('#Mountains');
final ButtonElement lochsButton = querySelector('#Lochs');
final SpanElement statusDisplay = querySelector('#Status');

final Forest trees = new Forest();

Timer timer;

void main() {
  statusDisplay.text = "Building world...";
  setupGuiEventHandlers();

  timer = new Timer.periodic(new Duration(milliseconds: 1000), update);
}

void update(_) {
  statusDisplay.text = "Updating...";
  if (trees.active)
    trees.update();

  for (int x = 0; x < trees.width; x++)
    for (int y = 0; y < trees.width; y++)
      c2d
        ..fillStyle = trees.land.data[x][y].colour
        ..fillRect(
            x * drawPlotWidth, y * drawPlotWidth, drawPlotWidth, drawPlotWidth);
  statusDisplay.text = "Updated.";
}

void setupGuiEventHandlers() {
  fireControl.onChange.listen((e) {
    trees.fireChance = 100 - fireControl.valueAsNumber.toInt();
  });

  treeControl.onChange.listen((e) {
    trees.treeChance = 101 - treeControl.valueAsNumber.toInt();
  });

  speedControl.onChange.listen((e) {
    timer?.cancel();
    final minDelay = 1000 ~/ maxHertz;
    final maxDelay = 1000 ~/ minHertz;
    int delay = minDelay +
        ((100 - speedControl.valueAsNumber) / 100 * maxDelay).round();
    timer = new Timer.periodic(new Duration(milliseconds: delay), update);
  });

  startButton.onClick.listen((e) {
    trees.active = true;
  });
  stopButton.onClick.listen((e) {
    trees.active = false;
  });
  resetButton.onClick.listen((e) {
    statusDisplay.text = "Building world...";
    trees.reset();
    statusDisplay.text = "World built.";
  });
  mountainsButton.onClick.listen((e) {
    trees.addMountains();
  });
  lochsButton.onClick.listen((e) {
    trees.addWater();
  });
}
