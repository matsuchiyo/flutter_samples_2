

import 'dart:math' as math;
import 'package:flutter/rendering.dart';

class LinearGradientRotation extends GradientTransform {
  final double degree; // 6時→12時の方向が0degree。そこから時計回り。

  const LinearGradientRotation({required this.degree});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final radians = ((degree % 360) / 360) * (math.pi * 2);

    final radians2 = radians % math.pi;

    // 長方形の頂点を左上から反時計周りにABCD、対角線の交点をOとする。
    final diagonalLength = math.sqrt(math.pow(bounds.height, 2) + math.pow(bounds.width, 2));
    final sinBDC = bounds.width / diagonalLength;
    final cornerBDC = math.asin(sinBDC);
    final cornerDBC = math.pi / 2 - cornerBDC;

    const scaleX = 1.0;
    double scaleY = 1.0;
    if (radians2 == 0.0) {
      scaleY = 1.0;
    } else if (radians2 > 0.0 && radians2 < cornerBDC) {
      final cosOfCornerBDCMinusRadians2 = math.cos(cornerBDC - radians2);
      scaleY = ((diagonalLength / 2) * cosOfCornerBDCMinusRadians2 * 2) / bounds.height;
    } else if (radians2 == cornerBDC) {
      scaleY = diagonalLength / bounds.height;
    } else if (radians2 > cornerBDC && radians2 < (math.pi / 2)) {
      final cosOfRadians2MinusCornerBDC = math.cos(radians2 - cornerBDC);
      scaleY = ((diagonalLength / 2) * cosOfRadians2MinusCornerBDC * 2) / bounds.height;
    } else if (radians2 == (math.pi / 2)) {
      scaleY = bounds.width / bounds.height;
    } else if (radians2 > (math.pi / 2) && radians2 < (math.pi - cornerBDC)) {
      final cosOfCornerDBCPlusHalfPiMinusRadians2 = math.cos(cornerDBC + math.pi / 2 - radians2);
      scaleY = ((diagonalLength / 2) * cosOfCornerDBCPlusHalfPiMinusRadians2 * 2) / bounds.height;
    } else if (radians2 == (math.pi - cornerBDC)) {
      scaleY = diagonalLength / bounds.height;
    } else if (radians2 > (math.pi - cornerBDC)) {
      final cosOfRadians2MinusHalfPiMinusCornerDBC = math.cos(radians2 - math.pi / 2 - cornerDBC);
      scaleY = ((diagonalLength / 2) * cosOfRadians2MinusHalfPiMinusCornerDBC * 2) / bounds.height;
    }

    final Offset center = bounds.center;

    final scale = Matrix4.fromList([
      scaleX, 0.0, 0.0, 0.0,
      0.0, scaleY, 0.0, 0.0,
      0.0, 0.0, 1.0, 0.0,
      0.0, 0.0, 0.0, 1.0,
    ]);

    final translate = Matrix4.fromList([
      1.0, 0.0, 0.0, 0.0,
      0.0, 1.0, 0.0, 0.0,
      0.0, 0.0, 1.0, 0.0,
      -center.dx * scaleX, -center.dy * scaleY, 0.0, 1.0,
    ]);

    final rotate = Matrix4.fromList([
      math.cos(radians), math.sin(radians), 0.0, 0.0,
      -math.sin(radians), math.cos(radians), 0.0, 0.0,
      0.0, 0.0, 1.0, 0.0,
      0.0, 0.0, 0.0, 1.0,
    ]);

    final translate2 = Matrix4.fromList([
      1.0, 0.0, 0.0, 0.0,
      0.0, 1.0, 0.0, 0.0,
      0.0, 0.0, 1.0, 0.0,
      center.dx, center.dy, 0.0, 1.0,
    ]);

    return translate2
        .multiplied(rotate)
        .multiplied(translate)
        .multiplied(scale)
    ;
  }
}