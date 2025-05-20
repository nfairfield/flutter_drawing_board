import 'package:flutter/material.dart';

import '../draw_path/draw_path.dart';
import '../drawing_controller.dart';
import 'paint_content.dart';
import 'simple_line.dart';

class LineEraser extends PaintContent {
  LineEraser(this.controller);

  DrawingController controller;

  //factory LineEraser.fromJson(Map<String, dynamic> _) => LineEraser();

  @override
  String get contentType => 'LineEraser';

  @override
  void startDraw(Offset startPoint) {}

  @override
  void drawing(Offset nowPoint) {
    for (int i = 0; i < controller.getHistory.length; i++) {
      final PaintContent history = controller.getHistory[i];
      if (history.runtimeType == SimpleLine) {
        final DrawPath historyPath = (history as SimpleLine).path;
        if (historyPath.path.contains(nowPoint)) {
          controller.getHistory.removeAt(i);
          controller.refresh();
          i--;
        }
      }
    }
  }

  @override
  void draw(Canvas canvas, Size size, bool deeper) {}

  @override
  LineEraser copy() => LineEraser(controller);

  @override
  Map<String, dynamic> toContentJson() {
    return <String, dynamic>{};
  }
}
