// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
import 'dart:math' as math;

/// WelcomeRingsWidget — анимация «геометрические кольца»
///
/// Прозрачный фон: можно ставить поверх любого цвета.
///
/// 4 концентрические дуги медленно вращаются в разные стороны. На конце
/// каждой дуги — светящаяся точка. В центре — мягко пульсирующее ядро.
class WelcomeRingsWidget extends StatefulWidget {
  const WelcomeRingsWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<WelcomeRingsWidget> createState() => _WelcomeRingsWidgetState();
}

class _WelcomeRingsWidgetState extends State<WelcomeRingsWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final DateTime _startTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(days: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          final double tSec =
              DateTime.now().difference(_startTime).inMilliseconds / 1000.0;

          return CustomPaint(
            painter: _WelcomeRingsPainter(
              tSec: tSec,
            ),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class _WelcomeRingsPainter extends CustomPainter {
  _WelcomeRingsPainter({
    required this.tSec,
  });

  final double tSec;

  static const Color _accentColor = Color(0xFF5EECD4);

  static const List<_RingConfig> _rings = [
    _RingConfig(
      radius: 30.0,
      arc: 1.7,
      direction: 1,
      alpha: 0.85,
      strokeWidth: 1.5,
    ),
    _RingConfig(
      radius: 52.0,
      arc: 1.4,
      direction: -1,
      alpha: 0.55,
      strokeWidth: 1.2,
    ),
    _RingConfig(
      radius: 78.0,
      arc: 1.1,
      direction: 1,
      alpha: 0.32,
      strokeWidth: 1.0,
    ),
    _RingConfig(
      radius: 105.0,
      arc: 0.8,
      direction: -1,
      alpha: 0.18,
      strokeWidth: 1.0,
    ),
  ];

  Color _withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity.clamp(0.0, 1.0));
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final Offset center = Offset(cx, cy);

    // Масштаб нужен, чтобы анимация красиво помещалась в любой размер виджета.
    // Базовый внешний радиус в оригинальном варианте — 105.
    final double minSide = math.min(size.width, size.height);
    final double scale = minSide / 240.0;

    for (int i = 0; i < _rings.length; i++) {
      final _RingConfig ring = _rings[i];

      final double radius = ring.radius * scale;
      final double arcAngle = ring.arc * math.pi;
      final double rotation = tSec * 0.18 * ring.direction + i * 0.4;

      canvas.save();
      canvas.translate(cx, cy);
      canvas.rotate(rotation);

      final Rect rect = Rect.fromCircle(
        center: Offset.zero,
        radius: radius,
      );

      final Paint arcPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = ring.strokeWidth * scale
        ..color = _withOpacity(_accentColor, ring.alpha);

      canvas.drawArc(
        rect,
        -arcAngle / 2,
        arcAngle,
        false,
        arcPaint,
      );

      final double endX = math.cos(arcAngle / 2) * radius;
      final double endY = math.sin(arcAngle / 2) * radius;

      canvas.drawCircle(
        Offset(endX, endY),
        2.0 * scale,
        Paint()..color = _withOpacity(Colors.white, ring.alpha),
      );

      canvas.restore();
    }

    final double pulse = (math.sin(tSec * 0.9) + 1) / 2;
    final double coreRadius = (3.0 + pulse * 1.5) * scale;
    final double glowRadius = 16.0 * scale;

    final Paint glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          _withOpacity(Colors.white, 0.85 + pulse * 0.15),
          _withOpacity(_accentColor, 0.5 + pulse * 0.2),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: glowRadius,
        ),
      );

    canvas.drawCircle(center, glowRadius, glowPaint);

    canvas.drawCircle(
      center,
      coreRadius,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant _WelcomeRingsPainter oldDelegate) => true;
}

class _RingConfig {
  const _RingConfig({
    required this.radius,
    required this.arc,
    required this.direction,
    required this.alpha,
    required this.strokeWidth,
  });

  final double radius;
  final double arc;
  final int direction;
  final double alpha;
  final double strokeWidth;
}
