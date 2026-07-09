import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../paint_extension/ex_offset.dart';
import '../paint_extension/ex_paint.dart';
import 'paint_content.dart';

/// Text Content
class TextContent extends PaintContent {
  TextContent();

  TextContent.data({
    required this.position,
    required this.text,
    required Paint paint,
  }) : super.paint(paint);

  factory TextContent.fromJson(Map<String, dynamic> data) {
    return TextContent.data(
      position: jsonToOffset(data['position'] as Map<String, dynamic>),
      text: data['text'] as String,
      paint: jsonToPaint(data['paint'] as Map<String, dynamic>),
    );
  }

  Offset? position;
  String text = '';

  @override
  String get contentType => 'TextContent';

  @override
  void startDraw(Offset startPoint) => position = startPoint;

  @override
  void drawing(Offset nowPoint) {} // no-op for text

  @override
  void draw(Canvas canvas, Size size, bool deeper) {
    if (position == null || text.isEmpty) {
      return;
    }

    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: paint.color,
          fontSize: (paint.strokeWidth * 4) + 12, // Rescaled to have a readable minimum size
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: size.width - position!.dx);
    tp.paint(canvas, position!);
  }

  @override
  TextContent copy() => TextContent();

  @override
  Map<String, dynamic> toContentJson() {
    return <String, dynamic>{
      'position': position?.toJson(),
      'text': text,
      'paint': paint.toJson(),
    };
  }
}
