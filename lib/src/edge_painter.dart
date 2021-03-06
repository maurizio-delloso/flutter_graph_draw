import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:geometry_kp/geometry.dart';

///extends CustomPainter and draw an edge
///
///[edge] is the edge to be drawn
///[color] is his color
///[strokeWidth] tje width of his body
///[hasLabel] true only if the edge has a label
class EdgePainter extends CustomPainter {
  final Arrow edge;
  final Color color;
  final double strokeWidth;
  final bool hasLabel;

  EdgePainter({
    @required this.edge,
    this.color = Colors.black,
    this.strokeWidth = 3.0,
    this.hasLabel = false,
  }) : assert(edge != null);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    final paintStroke = Paint();
    paintStroke.color = color;
    paintStroke.style = PaintingStyle.stroke;
    paintStroke.strokeWidth = strokeWidth;

    final paintFill = Paint();
    paintFill.color = color;
    paintFill.style = PaintingStyle.fill;

    var path = Path();
    path.addPolygon([
      Offset(edge.tip.x, edge.tip.y),
      Offset(edge.rigth.x, edge.rigth.y),
      Offset(edge.left.x, edge.left.y)
    ], true);
    canvas.drawPath(path, paintFill);
    if (hasLabel)
      canvas.drawCircle(Offset(edge.mid.x, edge.mid.y), 4.0, paintFill);
    edge.body is Circle
        ? canvas.drawArc(
            Rect.fromCircle(
                center: Offset((edge.body as Circle).center.x,
                    (edge.body as Circle).center.y),
                radius: (edge.body as Circle).radius),
            edge.start.angleOnCircle(edge.body),
            (edge.body as Circle).arc(edge.start, edge.end),
            false,
            paintStroke)
        : canvas.drawLine(
            Offset(edge.start.x, edge.start.y),
            Offset(edge.start.x + edge.end.x, edge.start.y + edge.end.y),
            paintStroke);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
